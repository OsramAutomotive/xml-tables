// Save changes into new limits file
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
    console.log(header.innerHTML);
    header.className = 'temp-table-header ' + 'color'+header.innerHTML;
    table.className = 'temp-table ' + 'temp'+header.innerHTML;
  });
};

// Voltage
const addVoltage = () => {
  let voltageValue = prompt("Enter the value of the voltage:", "13.5");
  if (voltageValue != null) {
    document.querySelectorAll('.temp-table').forEach(table => {
      let row = table.insertRow(table.rows.length);
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

const removeVoltage = () => {
  document.querySelectorAll('.temp-table').forEach(table => {
    (table.rows.length > 3) && table.deleteRow(table.rows.length-1);
  });
  saveChanges();
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
  let tablesDivs = document.querySelectorAll('.mode-tables');
  tablesDivs.forEach(tablesDiv => {
    let tables = tablesDiv.children;
    (tables.length > 3) && tablesDiv.removeChild(tablesDiv.lastChild);
  });
  saveChanges();
};

// Mode
const addMode = () => {
  let modeName = prompt("Enter the name of the mode:", "STOP");
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
  let modesDiv = document.getElementById('modes');
  (modesDiv.children.length > 2) && modesDiv.removeChild(modesDiv.lastChild);
  saveChanges();
  window.scrollTo(0,document.body.scrollHeight);
};
