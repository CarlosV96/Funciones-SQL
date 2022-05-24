-- Consulta donde se obtienen productos vendidos
-- Usando el tipo de documento, y numero de documento.
SELECT nombre FROM producto
JOIN detalle ON producto.id = detalle.producto_id
JOIN factura ON detalle.factura_id = factura.id
JOIN cliente on cliente.id = factura.cliente_id
WHERE cliente.documento = '6.273.383'
AND cliente.tipo_documento = 'CC';

-- Consulta productos por medio del nombre y muestra su proveedor.
SELECT proveedor.nombre FROM proveedor
JOIN producto ON proveedor.id = producto.proveedor_id
WHERE producto.nombre = 'mesa';