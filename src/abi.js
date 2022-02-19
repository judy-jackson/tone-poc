var request = new XMLHttpRequest();
request.open('GET', './files/contracts_Melody3_sol_MelodyGen.abi', false);
request.send();

var abi = request.responseText;

export default abi;