const buff = '52494646262C010057415645666D74201000000001000100401F0000803E00000200100064617461022C0100';
const header_len = 44;

var valueArray = buff.match(/[\s\S]{1,2}/g) || [];
var rawBuffer = new ArrayBuffer(header_len);
var arrayView = new Uint8Array(rawBuffer);

for (var i=0; i<header_len; i++){
    arrayView[i] = parseInt(valueArray[i], 16);
}

//console.log("In header.js: " + rawBuffer.byteLength);
export default rawBuffer;

