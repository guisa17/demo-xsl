<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="filtro_cargador" />

  <xsl:template match="/">
    <html>
      <head>
        <title>Estaciones con DC Rápido = <xsl:value-of select="$filtro_cargador" /></title>
        <style>
          * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
          }
          body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg,rgb(255, 255, 255) 0%,rgb(255, 255, 255) 100%);
            min-height: 100vh;
            padding: 20px;
          }
          .container {
            max-width: 1400px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
          }
          h1 { 
            background: linear-gradient(135deg, #FF5733 0%, #FF5733 100%);
            color: white; 
            padding: 20px;
            margin: -25px -25px 25px -25px;
            border-radius: 15px 15px 0 0;
            font-size: 1.8rem;
            font-weight: 600;
            text-align: center;
            box-shadow: 0 2px 10px rgba(255, 87, 51, 0.3);
          }
          .table-container {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
          }
          table { 
            border-collapse: collapse; 
            width: 100%; 
            background: white;
            border-radius: 12px;
            overflow: hidden;
          }
          th, td { 
            padding: 12px 15px; 
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
          }
          th { 
            background: linear-gradient(135deg, #FF5733 0%, #FF5733 100%);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            position: sticky;
            top: 0;
            z-index: 10;
          }
          tr:nth-child(even) { 
            background-color: #f8f9ff; 
          }
          tr:hover {
            background-color: #e8f0fe;
            transform: scale(1.002);
            transition: all 0.2s ease;
          }
          td {
            font-size: 0.9rem;
            color: #333;
          }
          td:nth-child(1) { /* Nombre */
            font-weight: 600;
            color: #2c3e50;
          }
          td:nth-child(2) { /* Ciudad */
            color: #7b68ee;
            font-weight: 500;
          }
          td:nth-child(4) { /* Horario */
            font-size: 0.8rem;
            color: #666;
          }
          td:nth-child(5), td:nth-child(6) { /* Contadores */
            text-align: center;
            font-weight: bold;
          }
          td:nth-child(5) { /* DC Rápido */
            color: #e74c3c;
          }
          td:nth-child(6) { /* Level 2 */
            color: #27ae60;
          }
          .badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: bold;
            background: #f0f0f0;
            margin-right: 4px;
          }
          .badge-dc {
            background: linear-gradient(135deg, #e74c3c 0%, #ff7675 100%);
            color: white;
          }
          .badge-level2 {
            background: linear-gradient(135deg, #27ae60 0%, #55efc4 100%);
            color: white;
          }
          .badge-none {
            background: #b2bec3;
            color: white;
          }
          @media (max-width: 900px) {
            .container { padding: 10px; }
            h1 { font-size: 1.2rem; padding: 10px; }
            th, td { padding: 6px 8px; font-size: 0.8rem; }
          }
          @media (max-width: 600px) {
            .container { padding: 2px; }
            h1 { font-size: 1rem; padding: 6px; }
            th, td { padding: 4px 4px; font-size: 0.7rem; }
          }
          .table-container::-webkit-scrollbar {
            height: 8px;
          }
          .table-container::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 4px;
          }
          .table-container::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 4px;
          }
          .table-container::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>Estaciones con cargadores rápidos DC = <xsl:value-of select="$filtro_cargador" /></h1>
          <div class="table-container">
            <table>
              <thead>
                <tr>
                  <th>Nombre</th>
                  <th>Ciudad</th>
                  <th>Dirección</th>
                  <th>Horario</th>
                  <th>DC Rápido</th>
                  <th>Level 2</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="/response/row/row[ev_dc_fast_count = $filtro_cargador]">
                  <tr>
                    <td><xsl:value-of select="station_name" /></td>
                    <td><xsl:value-of select="city" /></td>
                    <td><xsl:value-of select="street_address" /></td>
                    <td><xsl:value-of select="access_days_time" /></td>
                    <td>
                      <xsl:choose>
                        <xsl:when test="ev_dc_fast_count = 'NONE' or ev_dc_fast_count = '' or not(ev_dc_fast_count)">
                          <span class="badge badge-none">0</span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span class="badge badge-dc"><xsl:value-of select="ev_dc_fast_count" /></span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                    <td>
                      <xsl:choose>
                        <xsl:when test="ev_level2_evse_num = 'NONE' or ev_level2_evse_num = '' or not(ev_level2_evse_num)">
                          <span class="badge badge-none">0</span>
                        </xsl:when>
                        <xsl:otherwise>
                          <span class="badge badge-level2"><xsl:value-of select="ev_level2_evse_num" /></span>
                        </xsl:otherwise>
                      </xsl:choose>
                    </td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>