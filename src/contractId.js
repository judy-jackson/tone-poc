var request = new XMLHttpRequest();
request.open('GET', './files/contractId.txt', false);
request.send();

var contractId = request.responseText

export default contractId;