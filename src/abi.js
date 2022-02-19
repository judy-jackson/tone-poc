var request = new XMLHttpRequest();
request.open('GET', './files/contracts_Melody2_sol_MelodyGen.abi', false);
request.send();

var abi = request.responseText;

export default abi;