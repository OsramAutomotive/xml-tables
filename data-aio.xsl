<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">

  <html>
    <head>
      <style>
        body {
          font-family: Calibri, Tahoma, Verdana, Segoe, sans-serif;
          text-align: center;
        }

        table {
          border-collapse: collapse;
          text-align: center;
        }

        table td, th {
          border: 1px solid black;
        }

        th {
          padding: 5px 8px;
        }

        td {
          padding: 5px 20px;
        }

        tr:hover {
          background-color: lightyellow;
        }

        .mode-header {
          margin: 10px 10px;
          width: 100%;
          border-radius: 5px;
          background-color: lightgray;
        }

        .mode-header.DRL {
          background-color: #00E5EE;
        }

        .mode-header.TURN {
          background-color: mediumpurple;
        }

        .mode-header.PARK {
          background-color: darkorange;
        }

        .mode-header.PARKTURN {
          background-color: orange;
        }

        .mode-header.DRLTURN {
          background-color: #ff96ca;
        }

        .color23C {
          background-color: palegreen;
        }

        .color-40C {
          background-color: deepskyblue;
        }

        .color85C {
          background-color: indianred;
        }

        .color45C {
          background-color: #ffff94;
        }

        .color60C {
          background-color: #ff9022;
        }

        .color95C {
          background-color: #bb5d00;
        }

        .info {
          display: flex;
          justify-content: center;
        }

        .top-container {
          margin-left: 50px;
          margin-right: 50px;
        }

        .project-info {
          background-color: khaki;
          padding: 25px 40px;
          border-radius: 15px;
        }

        .actions {
          margin: 30px;
          display: flex;
          flex-direction: column;
          justify-content: center;
        }

        .mode {
          margin: 30px 10px;
        }

        .mode-tables {
          display: flex;
          justify-content: center;
        }

        .temp-table {
          margin-right: 10px;
        }

        .board-table {
          border: 1px solid black;
        }

        .board-table tr:nth-child(odd){
          background-color: #ccc;
        }

        button.save-button {
          font-size: 1.2em;
          margin: 10px;
        }

        button.add-button {
          visibility: hidden;
          margin-left: 4px;
          margin-right: 4px;
        }

        tr:hover button.add-button {
          visibility: visible;
        }
      </style>

      <script>
        const saveChanges = () => {
          document.querySelectorAll('.mode').forEach(mode => {
            let header = mode.childNodes[0];
            header.className = 'mode-header ' + header.innerHTML;
            mode.id = header.innerHTML;
          });

          document.querySelectorAll('#voltage').forEach(row => {
            let header = row.childNodes[0];
            row.className = header.innerHTML;
            header.className = header.innerHTML;
          });

          document.querySelectorAll('.temp-table').forEach(table => {
            let header = table.getElementsByClassName('temp-table-header')[0];
            header.className = 'temp-table-header ' + 'color'+header.innerHTML;
            table.className = 'temp-table ' + 'temp'+header.innerHTML;
          });
        };

        // Voltage
        const addVoltage = () => {
          let voltageValue = prompt("Enter the value of the voltage:", "13.5");
          let rowIndex = compareVoltage(voltageValue, document.querySelectorAll('.temp-table')[0]);
          if (voltageValue != null) {
            document.querySelectorAll('.temp-table').forEach(table => {
              // let row = table.insertRow(table.rows.length);
              let row = table.insertRow(rowIndex);
              row.id = "voltage";
              let voltage = document.createElement('th');
              row.appendChild(voltage);
              let minimum = row.insertCell(1);
              let maximum = row.insertCell(2);
              minimum.className = "min";
              maximum.className = "max";
              voltage.innerHTML = voltageValue;
              minimum.innerHTML = "1.00";
              maximum.innerHTML = "2.00";
            });
            saveChanges();
          }
        };

        const compareVoltage = (value, table) => {
          for (i = 2; i &lt; table.rows.length; i++) {
            if (parseFloat(value) &lt; parseFloat(table.rows[i].className)) {
              return i;
            }
          }
          return i;
        };

        const removeVoltage = () => {
          let voltage = prompt("Enter voltage to remove:", "13.5");
          if (voltage != null) {
            document.querySelectorAll('#voltage').forEach(tr => {
              (tr.className == voltage) &amp;&amp; tr.parentNode.removeChild(tr);
            });
            saveChanges();
          }
        };

        // Temperature
        const addTemp = () => {
          let temperature = prompt("Enter the temperature:", "95C");
          if (temperature != null) {
            let tablesDivs = document.querySelectorAll('.mode-tables');
            tablesDivs.forEach(tablesDiv => {
              let tables = tablesDiv.children;
              let newTable = tables[0].cloneNode(true);
              newTable.getElementsByClassName('temp-table-header')[0].innerHTML = temperature;
              tablesDiv.appendChild(newTable);
            });
            saveChanges();
          }
        };

        const removeTemp = () => {
          let temperature = prompt("Enter the temperature to remove:", "95C");
          if (temperature != null) {
            let tablesToRemove = document.querySelectorAll('.temp-table.temp'+temperature);
            tablesToRemove.forEach(table => {
              table.parentNode.removeChild(table);
            });
            saveChanges();
          }
        };

        // Mode
        const addMode = () => {
          let modeName = prompt("Enter the name of the mode:", "MODE");
          if (modeName != null) {
            let modesDiv = document.getElementById('modes');
            let newMode = modesDiv.lastChild.cloneNode(true);
            modesDiv.appendChild(newMode);
            newMode.children[0].innerHTML = modeName;
            saveChanges();
            window.scrollTo(0,document.body.scrollHeight);
          }
        };

        const removeMode = () => {
          let modeName = prompt("Enter the mode to remove:", "LBHB");
          if (modeName != null) {
            let mode = document.getElementById(modeName);
            mode.scrollIntoView();
            mode.parentNode.removeChild(mode);
            // (modesDiv.children.length > 2) &amp;&amp; modesDiv.removeChild(modesDiv.lastChild);
            saveChanges();
          }
        };
      </script>

    </head>

    <body>
      <!-- Main Header -->
      <h2><div contenteditable="true">Test Tables</div></h2>
      
      <!-- Temperature Header -->
      <xsl:for-each select="test/temperature">
        <h2><div contenteditable="true"><xsl:value-of select="@temp"/></div></h2>
    
        <xsl:for-each select="mode">

          <table border="1">
            <!-- Mode Header -->
            <tr>
              <xsl:attribute name="class"><xsl:value-of select="@id"/></xsl:attribute>
              <th>
                <xsl:attribute name="colspan"><xsl:value-of select="@width"/></xsl:attribute>
                <div contenteditable="true"><xsl:value-of select="@id"/></div>
              </th>
            </tr>
            <xsl:for-each select="voltage">

              <!-- Voltage Header -->
              <tr bgcolor="#d3d3d3">
                <th>
                  <xsl:attribute name="colspan"><xsl:value-of select="@width"/></xsl:attribute>
                  <div contenteditable="true"><xsl:value-of select="@value"/></div>
                </th>
              </tr>

              <!-- Names -->
              <tr bgcolor="#d3d3d3">
                <th><div contenteditable="true">Name:</div></th>
                <xsl:for-each select="vsenses/vsense">
                  <td align="center"><div contenteditable="true"><xsl:value-of select="name"/></div></td>
                </xsl:for-each>
                <xsl:for-each select="systems/system">
                  <td align="center"><div contenteditable="true"><xsl:value-of select="name"/></div></td>
                </xsl:for-each>
              </tr>

              <!-- Minimums -->
              <tr>
                <th><div contenteditable="true">Min:</div></th>
                <xsl:for-each select="vsenses/vsense">
                  <td align="center"><xsl:value-of select="min"/></td>
                </xsl:for-each>
                <xsl:for-each select="systems/system">
                  <td align="center"><xsl:value-of select="min"/></td>
                </xsl:for-each>
              </tr>

              <!-- Maximums -->
              <tr>
                <th><div contenteditable="true">Max:</div></th>
                <xsl:for-each select="vsenses/vsense">
                  <td align="center"><xsl:value-of select="max"/></td>
                </xsl:for-each>
                <xsl:for-each select="systems/system">
                  <td align="center"><xsl:value-of select="max"/></td>
                </xsl:for-each>
              </tr>

              <!-- Check Data -->
              <tr>
                <th><div contenteditable="true">Check Data:</div></th>
                <xsl:for-each select="vsenses/vsense">
                  <xsl:choose>
                    <xsl:when test="check = 'Out of Spec'">
                      <td bgcolor="yellow" align="center"><xsl:value-of select="check"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                      <td align="center"><xsl:value-of select="check"/></td>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
                <xsl:for-each select="systems/system">
                  <xsl:choose>
                    <xsl:when test="check = 'Out of Spec'">
                      <td bgcolor="yellow" align="center"><xsl:value-of select="check"/></td>
                    </xsl:when>
                    <xsl:otherwise>
                      <td align="center"><xsl:value-of select="check"/></td>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </tr>

            </xsl:for-each>
          </table>
          <br></br><br></br>

        </xsl:for-each><!-- end mode -->
        <br></br><br></br><br></br><br></br>
      </xsl:for-each><!-- end temperature -->
    </body>

  </html>

</xsl:template>
</xsl:stylesheet>