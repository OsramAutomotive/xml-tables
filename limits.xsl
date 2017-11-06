<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">

  <html>
    <head>
      <link rel="stylesheet" type="text/css" charset="utf-8" href="styles.css"></link>
      <script type="text/javascript" src="scripts.js"></script>
    </head>

    <body>
      <div>
        <a href="#" id="save" class="save-button" onClick="saveChanges()" download="filename">Save Changes</a>
      </div>

      <div id="content" contenteditable="true">


        <h1><u>TEST STATION LIMITS</u></h1>
        <div class="info">

          <!-- Limits File Information -->
          <div class="top-container project-info">
            <h2>Product: <xsl:value-of select="root/product"/></h2>
            <h2>Phase: <xsl:value-of select="root/phase"/></h2>
            <h2>Revision: <xsl:value-of select="root/revision"/></h2>
          </div>

          <!-- Board Module Information -->
          <div class="top-container board-info">
            <table class="board-table" id="board-table">
              <tr>
                <th>Board</th>
                <th>Module</th>
                <th>LED Bins</th>
                <th>Outage Link</th>
              </tr>
              <xsl:for-each select="root/boards/board">
                <tr class="board">
                  <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
                  <td><xsl:value-of select="@id"/></td>
                  <td><xsl:value-of select="module"/></td>
                  <td><xsl:value-of select="bins"/></td>
                  <td><xsl:value-of select="outage"/></td>
                </tr>
              </xsl:for-each>
              <tr class="board-change">
                <td colspan="2">
                  <button onClick="addBoard()">(+) Add Board</button>
                </td>
                <td colspan="2">
                  <button onClick="removeBoard()">(-) Remove Board</button>
                </td>
              </tr>
            </table>
          </div>

        </div> <!-- end of info -->
        <br/>


        <!-- Limits -->
        <div class="limits">

          <!-- Actions Methods -->
          <div class="actions">
            <h3>Actions:</h3>
            <div>
              <button onClick="addMode()">(+) Add Mode</button>
              <button onClick="removeMode()">(-) Remove Mode</button>
            </div>
            <div>
              <button onClick="addOutage()">(+) Add Outage</button>
              <button onClick="removeOutage()">(-) Remove Outage</button>
            </div>
            <div>
              <button onClick="addTemp()">(+) Add Temp</button>
              <button onClick="removeTemp()">(-) Remove Temp</button>
            </div>
            <div>
              <button onClick="addVoltage()">(+) Add Voltage</button>
              <button onClick="removeVoltage()">(-) Remove Voltage</button>
            </div>
          </div>

          <!-- Each Mode -->
          <div id="modes">
          <xsl:for-each select="root/limits/modes/mode">
            <!-- Mode -->
            <div class="mode">
              <xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute>
              <h2>
                <xsl:attribute name="class">mode-header <xsl:value-of select="@name"/></xsl:attribute>
                <xsl:value-of select="@name"/>
              </h2>

              <!-- mode tables div -->
              <div class="mode-tables">
              <!-- Temperatures -->
              <xsl:for-each select="temperature">
                <table>
                  <xsl:attribute name="class">temp-table temp<xsl:value-of select="@value"/></xsl:attribute>
                  <xsl:attribute name="temperature"><xsl:value-of select="@value"/></xsl:attribute>
                  <tr>
                    <th colspan="3">
                      <xsl:attribute name="class">temp-table-header color<xsl:value-of select="@value"/></xsl:attribute>
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
                      <xsl:attribute name="class"><xsl:value-of select="@value"/></xsl:attribute>
                      <xsl:attribute name="id">voltage</xsl:attribute>
                      <th>
                        <xsl:value-of select="@value"/>
                      </th>
                      <td>
                        <xsl:attribute name="class">min</xsl:attribute>
                        <xsl:value-of select="min"/>
                      </td>
                      <td>
                        <xsl:attribute name="class">max</xsl:attribute>
                        <xsl:value-of select="max"/>
                      </td>
                    </tr>
                  </xsl:for-each><!-- end voltage rows-->
                </table>
              </xsl:for-each><!-- end temperature tables-->
              </div>
            </div><!-- end mode -->
          </xsl:for-each>
        </div><!-- end modes -->

        <!-- Outage Tables -->
        <div id="OUTAGE">
        <h2 class="outage-header">OUTAGE</h2>
          <div class="outage-tables">
            <!-- off table -->
            <table class="outage-table" state="OFF">
              <tr class="off-header">
                <th colspan="3">OFF</th>
              </tr>
              <tr bgcolor="#d3d3d3">
                <th>Voltage</th>
                <th>Min</th>
                <th>Max</th>
              </tr>
              <xsl:for-each select="root/limits/outage/off/voltage">
                <tr>
                  <xsl:attribute name="class"><xsl:value-of select="@value"/></xsl:attribute>
                  <xsl:attribute name="id">voltage</xsl:attribute>
                  <th><xsl:value-of select="@value"/></th>
                  <td>
                    <xsl:attribute name="class">min</xsl:attribute>
                    <xsl:value-of select="min"/>
                  </td>
                  <td>
                    <xsl:attribute name="class">max</xsl:attribute>
                    <xsl:value-of select="max"/>                  
                  </td>
                </tr>
              </xsl:for-each>
            </table>
            <table class="outage-table" state="ON">
              <tr>
                <th colspan="3">ON</th>
              </tr>
              <tr bgcolor="#d3d3d3">
                <th>Voltage</th>
                <th>Min</th>
                <th>Max</th>
              </tr>
              <xsl:for-each select="root/limits/outage/on/voltage">
                <tr>
                  <xsl:attribute name="class"><xsl:value-of select="@value"/></xsl:attribute>
                  <xsl:attribute name="id">voltage</xsl:attribute>
                  <th><xsl:value-of select="@value"/></th>
                  <td>
                    <xsl:attribute name="class">min</xsl:attribute>
                    <xsl:value-of select="min"/>
                  </td>
                  <td>
                    <xsl:attribute name="class">max</xsl:attribute>
                    <xsl:value-of select="max"/>                  
                  </td>
                </tr>
              </xsl:for-each>
            </table>
          </div><!-- end outage tables -->
        </div><!-- end outage div -->

      </div><!-- end limits -->
      </div> <!-- end content -->

    </body>
  </html>

</xsl:template>
</xsl:stylesheet>
