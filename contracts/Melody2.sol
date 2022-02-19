// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

    contract MelodyGen{
        
        function getAudio() public pure returns (bytes memory) {

            uint file_len = 400;

            bytes memory audio_bytes = new bytes(file_len);

            bytes4 rand_int = 0x006E00BA;
            audio_bytes = abi.encodePacked(rand_int);

            for (uint i = 0; i < ((file_len/4)-1); i++) {
                audio_bytes = abi.encodePacked(audio_bytes, rand_int);
            }

            return audio_bytes;
        }
    }