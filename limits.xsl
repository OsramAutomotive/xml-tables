<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">

  <html>
    <head>
      <link rel="stylesheet" type="text/css" href="styles.css"></link>
    </head>

    <body>
      <h1 contenteditable="true"><u>TEST STATION LIMITS</u></h1>
      <div class="info-container">
        <!-- Limits File Information -->
        <div class="top-container">
          <h2 contenteditable="true">Product: <xsl:value-of select="root/product"/></h2>
          <h2 contenteditable="true">Phase: <xsl:value-of select="root/phase"/></h2>
          <h2 contenteditable="true">Revision: <xsl:value-of select="root/revision"/></h2>
        </div>
        <!-- Board Module Information -->
        <div class="top-container">
          <table class="board-table">
            <tr>
              <th>Board</th>
              <th>Module</th>
              <th>LED Bins</th>
              <th>Outage Link</th>
            </tr>
            <xsl:for-each select="root/boards/board">
              <tr>
                <td><xsl:value-of select="@id"/></td>
                  <td><xsl:value-of select="module"/></td>
                  <td><xsl:value-of select="bins"/></td>
                  <td><xsl:value-of select="outage"/></td>
              </tr>
            </xsl:for-each>
          </table>
        </div>
      </div>
      
      <!-- Modes Limits -->
      <div>
        <!-- Each Mode -->
        <xsl:for-each select="root/limits/modes/mode">
          <!-- Mode Header -->
          <div>
            <xsl:attribute name="class">
              <xsl:value-of select="@name"/> mode-header
            </xsl:attribute>
            <h2>
              <xsl:value-of select="@name"/>
            </h2>
          </div>
          
          <!-- mode tables div -->
          <div class="mode-tables-container">
          <!-- Temperatures -->
          <xsl:for-each select="temperature">
            <div class="temp-table-container">
            <table border="1">
              <tr>
                <xsl:attribute name="class">
                  temp<xsl:value-of select="@value"/>
                </xsl:attribute>
                <th colspan="3">
                  <xsl:value-of select="@value"/>
                </th>
              </tr>
              <!-- Voltage Header -->
              <tr bgcolor="#d3d3d3">
                <th>Voltage</th>
                <th>Min</th>
                <th>Max</th>
              </tr>
              <xsl:for-each select="voltage">
                <tr>
                  <th contenteditable="true" bgcolor="#e4e4e4">
                    <xsl:value-of select="@value"/>V
                  </th>
                  <td contenteditable="true">
                    <xsl:value-of select="min"/>
                  </td>
                  <td contenteditable="true">
                    <xsl:value-of select="max"/>
                  </td>
                </tr>
              </xsl:for-each><!-- end voltages-->
            </table>
            </div>
          </xsl:for-each><!-- end temperatures-->
          </div>
                  
        </xsl:for-each><!-- end modes -->
      </div>
    
    </body>
  </html>

</xsl:template>
</xsl:stylesheet>