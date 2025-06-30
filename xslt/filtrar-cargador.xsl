<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="filtro_cargador" />

  <xsl:template match="/">
    <html>
      <head>
        <title>Estaciones con DC Rápido = <xsl:value-of select="$filtro_cargador" /></title>
        <style>
          body { font-family: Arial, sans-serif; }
          h1 { background-color: #FF5733; color: white; padding: 10px; }
          table { border-collapse: collapse; width: 100%; margin-top: 10px; }
          th, td { border: 1px solid #ddd; padding: 8px; }
          th { background-color: #f2f2f2; }
          tr:nth-child(even) { background-color: #f9f9f9; }
        </style>
      </head>
      <body>
        <h1>Estaciones con cargadores rápidos DC = <xsl:value-of select="$filtro_cargador" /></h1>
        <table>
          <tr>
            <th>Nombre</th>
            <th>Ciudad</th>
            <th>Dirección</th>
            <th>Horario</th>
            <th>DC Rápido</th>
            <th>Level 2</th>
          </tr>
          <xsl:for-each select="/response/row/row[ev_dc_fast_count = $filtro_cargador]">
            <tr>
              <td><xsl:value-of select="station_name" /></td>
              <td><xsl:value-of select="city" /></td>
              <td><xsl:value-of select="street_address" /></td>
              <td><xsl:value-of select="access_days_time" /></td>
              <td><xsl:value-of select="ev_dc_fast_count" /></td>
              <td><xsl:value-of select="ev_level2_evse_num" /></td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
