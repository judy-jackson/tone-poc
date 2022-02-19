// let contractId = "";
// fetch('.')
//   .then(response => response.text())
//   .then(text => contractId = text);

//   export default contractId;
var request = new XMLHttpRequest();
request.open('GET', './files/contractId.txt', false);
request.send();

var contractId = request.responseText

export default contractId;