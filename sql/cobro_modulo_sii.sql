-- Merka POS: cobro del modulo de boleta SII.
-- Regla: el modulo se cobra desde la primera boleta electronica emitida en PRODUCCION.
-- Las emisiones en ambiente de pruebas no cuentan. Las notas de credito (tipo 61) tampoco.
-- Solo lectura.

-- 1) Estado por negocio: quien ya debe pagar el modulo y desde cuando.
WITH boletas AS (
  SELECT
    org_id,
    MIN(emitido_at)                                                    AS primera_boleta_at,
    MAX(emitido_at)                                                    AS ultima_boleta_at,
    COUNT(*)                                                           AS boletas_total,
    COUNT(*) FILTER (WHERE emitido_at >= date_trunc('month', NOW()))   AS boletas_mes_actual
  FROM merka_dte
  WHERE tipo = 39
    AND estado = 'emitida'
    AND ambiente = 'produccion'
    AND emitido_at IS NOT NULL
  GROUP BY org_id
)
SELECT
  n.org_id,
  COALESCE(to_jsonb(n)->>'nombre', to_jsonb(n)->>'name', to_jsonb(n)->>'business_name') AS negocio,
  n.payment_status,
  f.activo                                  AS modulo_activo,
  f.ambiente                                AS ambiente_configurado,
  f.conectado,
  b.primera_boleta_at,
  b.ultima_boleta_at,
  COALESCE(b.boletas_total, 0)              AS boletas_total,
  COALESCE(b.boletas_mes_actual, 0)         AS boletas_mes_actual,
  CASE
    WHEN b.primera_boleta_at IS NOT NULL
         AND n.payment_status <> 'paid' AND n.trial_end > NOW() THEN 'emitio boleta en prueba: cobrar al terminar la prueba'
    WHEN b.primera_boleta_at IS NOT NULL THEN 'cobrar modulo SII'
    WHEN f.activo AND f.conectado         THEN 'configurado, aun sin primera boleta'
    WHEN f.org_id IS NOT NULL             THEN 'en configuracion'
    ELSE 'sin modulo'
  END                                       AS estado_cobro,
  -- Primer ciclo de cobro del modulo: el mes de la primera boleta.
  date_trunc('month', b.primera_boleta_at)::date AS cobrar_desde_mes
FROM negocios n
LEFT JOIN merka_fiscal f ON f.org_id = n.org_id
LEFT JOIN boletas b      ON b.org_id = n.org_id
WHERE n.activo = true
ORDER BY b.primera_boleta_at NULLS LAST, n.org_id;

-- 2) Negocios cuya primera boleta de produccion fue en los ultimos 7 dias
--    (aviso para empezar a cobrar el modulo).
SELECT org_id, MIN(emitido_at) AS primera_boleta_at
FROM merka_dte
WHERE tipo = 39 AND estado = 'emitida' AND ambiente = 'produccion' AND emitido_at IS NOT NULL
GROUP BY org_id
HAVING MIN(emitido_at) >= NOW() - INTERVAL '7 days'
ORDER BY primera_boleta_at;
