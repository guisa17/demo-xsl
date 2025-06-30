<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="filtro_ciudad" />

  <xsl:template match="/">
    <html>
      <head>
        <title>Estaciones en <xsl:value-of select="$filtro_ciudad" /></title>
        <style>
          body { font-family: Arial, sans-serif; }
          h1 { background-color: #007BFF; color: white; padding: 10px; }
          table { border-collapse: collapse; width: 100%; margin-top: 10px; }
          th, td { border: 1px solid #ddd; padding: 8px; }
          th { background-color: #f2f2f2; }
          tr:nth-child(even) { background-color: #f9f9f9; }
        </style>
      </head>
      <body>
        <h1>Estaciones de Carga en <xsl:value-of select="$filtro_ciudad" /></h1>
        <table>
          <tr>
            <th>Nombre</th>
            <th>Dirección</th>
            <th>Horario</th>
            <th>DC Rápido</th>
            <th>Level 2</th>
          </tr>
          <xsl:for-each select="/response/row/row[city = $filtro_ciudad]">
            <tr>
              <td><xsl:value-of select="station_name" /></td>
              <td><xsl:value-of select="street_address" /></td>
              <td><xsl:value-of select="access_days_time" /></td>
              <td><xsl:value-of select="ev_dc_fast_count" /></td> <!-- Agregado -->
              <td><xsl:value-of select="ev_level2_evse_num" /></td> <!-- Agregado -->
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
