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
    header.className = 'temp-table-header ' + 'color' + header.innerHTML;
    table.className = 'temp-table ' + 'temp' + header.innerHTML;
  });

  console.log("clicked Save");
  document.getElementById('save').href = window.location.href; // save as dialog window
};

// Voltage
const addVoltage = () => {
  let voltageValue = prompt("Enter the value of the voltage:", "13.5");
  let rowIndex = compareVoltage(voltageValue, document.querySelectorAll('.temp-table')[0]);
  if (voltageValue != null) {
    document.querySelectorAll('.temp-table').forEach(table => {
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
    saveChanges();
  }
};

// Board
const addBoard = () => {
  let boardTable = document.getElementById('board-table');
  let newBoardNumber = getNewBoardNumber(boardTable.rows[boardTable.rows.length-2]);
  let newRow = boardTable.insertRow(boardTable.rows.length-1);
  newRow.className = "board";
  newRow.id = 'B' + newBoardNumber;
  let cell1 = newRow.insertCell(0);
  let cell2 = newRow.insertCell(1);
  let cell3 = newRow.insertCell(2);
  let cell4 = newRow.insertCell(3);
  cell1.innerHTML = 'B' + newBoardNumber;
  cell2.innerHTML = "Module";
  cell3.innerHTML = "";
  cell4.innerHTML = "False";
};

const getNewBoardNumber = (lastBoard) => {
  return parseInt(lastBoard.id.slice(1, lastBoard.id.length)) + 1;
};

const removeBoard = () => {
  let boardTable = document.getElementById('board-table');
  let lastBoard = boardTable.rows[boardTable.rows.length-2];
  (boardTable.rows.length > 5) && lastBoard.parentNode.removeChild(lastBoard);
};