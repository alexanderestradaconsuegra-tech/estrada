# Seguridad — Merka POS

Auditoría hecha en septiembre 2026 sobre `index.html` (cliente) y el workflow de
n8n (backend, `n8n/merka-pos.workflow.json`). Este documento es el registro de
qué se encontró, qué se corrigió y qué sigue pendiente.

## 🔴 Crítico — corregido en `n8n/merka-pos.workflow.json`

### 1. Ningún endpoint de datos validaba el `api_key` contra la organización
Cada endpoint (`merka-ventas`, `merka-clientes`, `merka-cobrar`, `merka-cierres`,
`merka-proveedores`, `merka-pagar`, `merka-gastos`, `merka-usuarios`,
`merka-configuracion`, `merka-productos`) solo verificaba que `_key` y `org_id`
**no vinieran vacíos** — nunca comparaba `_key` contra `negocios.api_key`.
Resultado: cualquiera con cualquier `_key` no vacío + un `org_id` adivinado
(predecible: `email-antes-de-arroba` + 4-5 dígitos) tenía lectura y escritura
completa sobre los datos de esa organización, incluyendo PIN de empleados.

**Fix**: se insertó, en los 10 flujos, un nodo `Verificar sesión · <flujo>`
(`SELECT org_id FROM negocios WHERE org_id = $1 AND api_key = $2 AND activo =
true`) seguido de un nodo `¿Autorizado? · <flujo>` que corta a una respuesta
401 compartida (`Responder 401`) si no hay match. `merka-configuracion` no
tenía ni siquiera el chequeo de presencia — se le agregó `ExtractBody_Switch9`
desde cero con el mismo gate.

### 2. `merka-admin` permitía enumerar y borrar CUALQUIER negocio
`action: listar-negocios` devuelve **todas** las organizaciones (columna
`org_id` incluida — resuelve de un tiro el problema de "adivinar" org_id de
arriba). `action: eliminar-negocio` desactiva la cuenta de cualquiera. Usaba
el mismo chequeo débil (`_key` no vacío) que el resto — es decir, sin
protección real.

**Fix**: `ExtractBody_Switch11` ahora exige `b._key === $env.MERKA_ADMIN_SECRET`,
un secreto de plataforma nuevo, distinto del `api_key` de cualquier negocio.
**Pendiente de tu lado**: definir `MERKA_ADMIN_SECRET` como variable de entorno
en la instancia de n8n (EasyPanel → variables de entorno del servicio) antes de
importar el workflow corregido, o `merka-admin` quedará inutilizable.

### 3. Access token de Mercado Pago en texto plano en el workflow
`Bearer APP_USR-1101244252600049-...` estaba hardcodeado en dos nodos HTTP
Request. **Ese token debe rotarse ahora en el dashboard de Mercado Pago** — ya
salió del entorno de n8n.

**Fix**: los nodos ahora usan `{{ $env.MERCADOPAGO_ACCESS_TOKEN }}`.
**Pendiente de tu lado**: 1) rotar el token en Mercado Pago, 2) cargar el
token nuevo como `MERCADOPAGO_ACCESS_TOKEN` en las variables de entorno de n8n.

### 4. SQL injection vía interpolación directa en ~37 queries
Todas las queries Postgres armaban el SQL con `'{{ $json.campo }}'` (string
building), sin parametrizar. Un campo de texto libre (nombre, nota, concepto,
dirección...) con una comilla simple podía alterar la query.

**Fix**: las 37 queries se reescribieron a placeholders posicionales
(`$1, $2...`) con `options.queryReplacement` — el mecanismo nativo de
parametrización del nodo Postgres de n8n.

## 🟡 Alto — corregido parcialmente en `index.html`

### 5. XSS sin escapar en renders con `innerHTML`
No existía ninguna función de escape en todo el archivo (63 sitios con
`innerHTML =` usando datos del backend sin sanitizar). Se agregó
`escapeHtml()` y se aplicó a los puntos de mayor riesgo:
- **Pantalla de login (`renderLoginCashiers`)** — nombre/rol de cajero, visible
  **sin autenticarse**.
- **Grid de productos** — nombre, `imagen_url` (también como atributo `src`) y
  unidad.
- **Carrito** (`t-cart-item-name`, modal de descuento).

**Pendiente**: quedan ~55 sitios sin revisar (clientes, proveedores, gastos,
gestión de usuarios, cierres, insights). El patrón para corregirlos es el
mismo: envolver cualquier campo de texto libre proveniente de `DB.get(...)`
o de una respuesta de `API.call(...)` en `escapeHtml(...)` antes de
interpolarlo en un template de `innerHTML`.

## 🟡 Alto — pendiente, requiere rediseño (no tocado todavía)

### 6. Permisos de usuario solo en el cliente
Todos los empleados de un negocio comparten el mismo `api_key` de
organización — el objeto `permisos` (verCostos, eliminarVentas,
gestionarUsuarios...) solo oculta botones en el HTML, no está enforced en el
backend. Cualquier cajero con acceso a las devtools puede llamar
`API.call(...)` directo y saltarse cualquier permiso.

**Por qué no se tocó ahora**: arreglarlo bien requiere que cada usuario tenga
su propio token (no solo la organización) y que cada endpoint de n8n valide
permiso por acción — es un cambio de arquitectura de auth, no un parche
puntual. Se puede abordar aparte cuando haya tiempo de probarlo con calma.

### 7. PIN de cajero en texto plano, validado en el cliente
`doLogin()` compara `pinInput !== loginSelectedUser.pin` en JavaScript —el PIN
de cada empleado viaja completo al navegador dentro de `DB.get('usuarios')`.
Mismo motivo que el punto 6: requiere mover la verificación al backend.

### 8. Plan/trial gateado solo por `sessionStorage`
`checkTrialStatus()` / `isProIaPlan()` leen `sessionStorage.getItem('merka_plan')`
— cualquiera puede escribir `sessionStorage.setItem('merka_plan','pro-ia')` en
la consola y desbloquear el plan pago gratis. La query `login` (punto 4, ya
parametrizada) sí trae `plan`/`trial_expired`/`payment_status` desde
`negocios` — falta que el **backend** rechace acciones si el plan no es válido,
no solo que el cliente muestre un banner. Este es el mismo patrón que se
necesita para el addon de delivery que se va a construir después — conviene
resolverlo junto con eso, con el mismo mecanismo de verificación server-side.

## Checklist antes de pasar esto a producción

1. Rotar el token de Mercado Pago (punto 3) — ya.
2. En EasyPanel, agregar las variables de entorno de n8n:
   `MERCADOPAGO_ACCESS_TOKEN` (el token rotado) y `MERKA_ADMIN_SECRET`
   (un secreto nuevo, largo y random — no reusar ningún `api_key` existente).
3. Importar `n8n/merka-pos.workflow.json` en una instancia de **staging** de
   n8n (no directo a producción) y probar cada endpoint manualmente: login,
   crear/editar/borrar en cada tabla, y confirmar que un `org_id` válido con
   un `_key` inventado ahora responde 401.
4. Recién con eso verificado, importarlo a producción reemplazando el
   workflow actual.
