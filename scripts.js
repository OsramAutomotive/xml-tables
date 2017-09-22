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
  for (i = 2; i < table.rows.length; i++) {
    if (parseFloat(value) < parseFloat(table.rows[i].className)) {
      return i;
    }
  }
  return i;
};

const removeVoltage = () => {
  let voltage = prompt("Enter voltage to remove:", "13.5");
  if (voltage != null) {
    document.querySelectorAll('#voltage').forEach(tr => {
      (tr.className == voltage) && tr.parentNode.removeChild(tr);
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
    // (modesDiv.children.length > 2) && modesDiv.removeChild(modesDiv.lastChild);
    saveChanges();
  }
};
