// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

    contract MelodyGen{
        
        function getAudio() public pure returns (bytes memory) {

            uint sequence_len = 5;
            uint num_sequences = 100;
            uint file_len = sequence_len * num_sequences;

            bytes memory audio_bytes = new bytes(file_len);

            //bytes4 rand_int = 0x006E00BA;
            bytes5 rand_int = 0x6EBA0000BA;
            audio_bytes = abi.encodePacked(rand_int);

            for (uint i = 0; i < (num_sequences-1); i++) {
                audio_bytes = abi.encodePacked(audio_bytes, rand_int);
            }

            return audio_bytes;
        }
    }