# Contexto de marketing: Merka POS

**Versión del documento:** v1
**Última actualización:** 2026-11-12
**Responsable:** Alexander Estrada (Autix)

Todo lo marcado `[POR CONFIRMAR]` no debe usarse en público hasta confirmarse.

## Producto

**Una línea:** punto de venta en la nube con boleta electrónica del SII para comercios de Chile.
**Qué hace:** el negocio cobra desde el navegador (celular, tablet o computador), el stock baja con cada venta, la caja se cierra por turno, y con el módulo opcional la boleta electrónica del SII sale al cobrar (a través de Tuu) y se anula con nota de crédito.
**Categoría (cómo lo buscan):** "punto de venta", "sistema POS", "programa para minimarket", "boleta electrónica".
**Tipo:** SaaS por suscripción mensual.
**Modelo y precios (pesos chilenos):**
- Plan único, todo incluido (con boleta SII): precio normal $15.000 al mes. Oferta de lanzamiento: $8.990 al mes si contrata y paga hasta el 30 de noviembre de 2026, y lo mantiene mientras siga pagando. Sin pago anual ni módulo aparte.
- Hay que actualizar la fecha de término de la oferta en la web (hoy 30-11-2026, también en datos estructurados) y no extenderla indefinidamente: una oferta que se corre cada mes es urgencia falsa.
- 30 días gratis, sin tarjeta, sin contrato.
- La llave de API y los documentos los entrega Tuu. Con el terminal de Tuu la emisión es gratis; sin él, depende del plan del proveedor.
**Alcance actual:** solo software. Sin venta de equipos, sin instalación en terreno, sin servicio de puesta en marcha de pago.

## Funciones reales hoy

Terminal de ventas (efectivo, tarjeta, transferencia, mixto), venta por peso con balanza EAN-13, inventario con alertas y precios por volumen, reportes con ganancia neta, crédito a clientes, cuentas por pagar a proveedores, cierre de caja por turno, panel de control, permisos por usuario con registro de auditoría, usuarios ilimitados, importación y exportación, boleta electrónica (PDF de 80 mm, nota de crédito, medios que emiten configurables), llave de boleta cifrada.

## Límites (decirlos con claridad)

Necesita internet para registrar y sincronizar. Solo boleta y nota de crédito: no emite facturas ni guías. La transferencia no emite boleta por decisión del negocio. No hay instalación en terreno. No es asesoría tributaria.

## Cliente

**Negocios objetivo:** minimarkets, almacenes, queserías, carnicerías, fiambrerías, botillerías, panaderías, ferreterías pequeñas, en Chile.
**Quién decide:** el dueño, que muchas veces atiende o supervisa la caja.
**Trabajos que contrata (por confirmar con entrevistas):**
- Saber cuánto gana de verdad y cuánto le falta por reponer. [POR CONFIRMAR]
- Emitir boleta sin hacerla a mano en otro sistema. [POR CONFIRMAR]
- Cobrar rápido y que la caja cuadre al cierre. [POR CONFIRMAR]
- Vender por peso sin calculadora (quesería, carnicería). [POR CONFIRMAR]
**Anti-cliente:** quien necesita facturación electrónica completa, quien no tiene internet estable, quien busca que alguien le instale todo, multi-sucursal compleja con bodegas.

## Competencia

- Directos: otros sistemas POS con boleta electrónica en Chile (por ejemplo Bsale y Tivendo de Defontana). Precios y promesas actuales [POR CONFIRMAR] en sus sitios oficiales.
- Secundarios: la herramienta gratuita de boletas del SII; el panel de Tuu (Haulmer) para emitir; AgendaPro POS ($20.000 + IVA al mes, terminal pensado para belleza, según un artículo de AgendaPro).
- Indirectos: Excel, cuaderno, calculadora, "de memoria".

## Diferenciación (por validar con clientes)

Precio muy bajo con boleta SII integrada. Venta por peso. Funciona en el navegador sin instalar. Soporte por WhatsApp. Pensado para el mostrador chileno. Cuidado: el precio ultra bajo puede atrapar el precio hacia abajo (ver Aprendizajes).

## Objeciones frecuentes y respuesta

| Objeción | Respuesta |
|---|---|
| Ya uso Excel o cuaderno | Funciona con poco volumen. Cuando el stock o la caja no cuadran ya se perdió plata |
| El SII tiene sistema gratis | Sirve para boletas sueltas. Aquí sale sola al cobrar, descuenta stock y se anula con nota de crédito |
| Mi máquina ya emite boleta | Se duplican. Dejar la máquina en "Sin documento" |
| Es caro o barato | $8.990 al mes son unos $300 al día. Preguntar cuánto pierde hoy |
| Si se cae internet | Necesita conexión. Decirlo sin rodeos |
| ¿Quién lo instala? | Por ahora solo software, funciona en el navegador |

## Dinámica de cambio (cuatro fuerzas) [POR CONFIRMAR con entrevistas]

- Empuje: [POR CONFIRMAR]
- Atracción: boleta integrada, precio, prueba gratis sin tarjeta.
- Hábito: Excel, cuaderno o el panel del proveedor ya conocido.
- Ansiedad: perder los datos, que el sistema se caiga, equivocarse con el SII.

## Lenguaje del cliente

Pendiente: llenar con frases textuales de dueños de negocio (entrevistas, WhatsApp, reseñas). Hasta entonces, no asumir cómo lo dicen.
Palabras a usar: caja, mostrador, boleta, kilo, granel, fiado, stock, cierre.
Palabras a evitar: solución integral, potente, robusto, optimiza, sinergia, ecosistema.

## Voz de marca

Directa, honesta, cercana, sin adornos. Tú. Frases cortas. Sin emojis. Dice lo que el producto no hace. No promete lo que depende de terceros.

## Pruebas disponibles

Ninguna cifra, reseña ni cliente citable por ahora. Disponibles: 30 días gratis sin tarjeta, seguridad (conexión cifrada, llave cifrada, permisos, registro de acciones, datos separados por negocio, sin datos de tarjetas), videos reales del sistema.
Pendiente: reseñas de Google, primeros clientes con permiso, cifras reales.

## Metas

**Principal:** cuentas que pasan de prueba a pago.
**Acción de conversión:** "Probar 30 días gratis" en app.merkapos.pro.
**Secundaria:** consultas por WhatsApp (+56 9 9202 5527).
**Métricas a seguir:** visitas, clics en probar, cuentas creadas, cuentas con 20 ventas en la primera semana, pagos, tiempo a la primera boleta real.

## Aprendizajes

- 2026-11-12. Titular "Cuadra la caja. Emite la boleta. Sabe cuánto ganas." Descartado por el dueño: son tres promesas, "Sabe" suena mal como orden y se escribió sin hablar con clientes. Lección: no escribir titulares sin lenguaje real del cliente. Alternativas pendientes de validar: precio con boleta; peso con boleta; control desde el celular; prueba con tus propios productos.
- 2026-11-12. Se detectó en el texto de la web el patrón "No solo X: Y" (contraste que revela). Evitar.
- 2026-11-12. Alerta de precio: la biblioteca de marketing advierte contra el precio ultra bajo (la trampa del precio de $9). $3.990 al mes está por debajo de lo habitual para un software de negocio. Decisión del dueño (2026-11-12): mantener $3.990 como precio de lanzamiento y probar además un precio más alto. Pendiente: fecha real de término del lanzamiento y diseño de la prueba por cohortes. Registrar el resultado cuando haya datos.
- 2026-11-12. Decisión de producto: se vende solo software. Quedan fuera equipos, kits, instalación en terreno y puesta en marcha de pago.
- 2026-11-12. El módulo SII se cobra desde la primera boleta emitida en producción. Cobro manual apoyado en un aviso semanal por WhatsApp (flujo n8n "Merka POS - Aviso semanal modulo boleta SII").

- 2026-11-12. Decisión del dueño: usar en la landing y en los videos de demostración fotos reales de productos de marcas (Soprole, Coca-Cola, Watt's, El Jardín, Vital). Riesgo advertido: derechos de imagen de terceros. Pendiente: confirmar permiso o reemplazar por fotos propias o genéricas.

- 2026-11-12. Diseño del hero: el dueño descartó el fondo oscuro azul marino con brillos turquesa porque se ve "hecho por IA". Nuevo sistema del hero: fondo papel cálido #F5F3EE, superficies blancas, texto #14171C y #565B63, líneas #E3E0D8, botón principal negro, un solo acento teal #0B7F66. Sin degradados de brillo, sin vidrio, sin neón. Pendiente: llevar el mismo sistema al resto de la página (hoy demo, planes y pie siguen oscuros).

- 2026-11-12. Hero rediseñado (dirección C "suizo directo" con boleta): papel #F1F1EE con cuadrícula, tinta #0E0E0E, señal naranja #FF4F1F solo en palabra clave, botón del menú y detalles, titular Manrope 800 gigante, precio $3.990 enorme, marco de video con sombra dura, boleta térmica de ejemplo ("Ejemplo de demostración"), etiquetas en JetBrains Mono. El dueño descartó las versiones previas por verse genéricas ("hecho por IA"). Pendiente: llevar el sistema al resto de la página (hoy el resto usa turquesa y secciones oscuras).

- 2026-11-12. Cambio de precio decidido por el dueño: el precio de $3.990 se veía demasiado barato. Nuevo modelo: plan único con todo incluido (boleta SII incluida), normal $15.000 al mes, oferta de lanzamiento $8.990 al mes para quien contrate y pague este mes (hasta el 30-11-2026) y se mantiene mientras siga pagando. Se eliminó el módulo SII aparte y el pago anual. El aviso semanal de primera boleta (n8n) ya no sirve para cobrar un módulo; sirve para seguimiento comercial. Hero: se quitó la cuadrícula y el naranja; acento ahora es un marcador de marca detrás de "sale solo.".

- 2026-11-12. Sistema de diseño extendido a toda la landing (papel #F1F1EE, tinta #0E0E0E, verde #22D3AB, esquinas rectas, líneas de tinta, sombra dura, etiquetas mono numeradas). Se eliminó la sección Demo (el video queda solo en el hero). La sección "servicios" pasó a ser una tabla "Lo que resuelve" (antes tachado / ahora con Merka POS) con 8 problemas y su solución real. Titulares más de venta: "Todo lo que hoy haces a mano, en un solo sistema", "Si vendes todos los días, es para ti", "Deja de hacerlo a mano". Regla: prometer todo lo que el sistema hace y nada que no haga.

- 2026-11-12. Titular del hero: "Estar al día no tiene que ser difícil." Bajada con la historia real del fundador ("Lo hice porque tuve un minimarket y no encontré un sistema simple, claro y barato"). Alternativas descartadas o pendientes: "Hecho por un dueño de minimarket. Para dueños de minimarket." y "El sistema que necesitaba mi minimarket. Ahora es tuyo." No afirmar "no hay sistemas así": no se puede respaldar. Pendiente: validar con 3 a 5 dueños.

## Registro de cambios

- v1 (2026-11-12): primer borrador a partir del código, la web y las decisiones de esta conversación.
