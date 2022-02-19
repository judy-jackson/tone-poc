// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

    contract MelodyGen{
        
        function getAudio() public pure returns (bytes memory) {

            uint sequence1_len = 4;
            uint num_sequence1 = 124;

            uint sequence2_len = 2;
            uint num_sequence2 = 124;
            uint file_len = (sequence1_len * num_sequence1) + (sequence2_len * num_sequence2);

            bytes memory audio_bytes = new bytes(file_len);

            //bytes10 sequence1 = 0x1200002300FFAA100000;
            bytes4 sequence1 = 0x006E00BA;
            //bytes3 sequence1 = 0x13FF22;
            //bytes5 sequence2 = 0x1060600A00;
            bytes2 sequence2 = 0x01FF;
            audio_bytes = abi.encodePacked(sequence1);

            for (uint i = 0; i < (num_sequence1-1); i++) {
                audio_bytes = abi.encodePacked(audio_bytes, sequence1);
            }

            for (uint i=0; i<num_sequence2; i++){
                audio_bytes = abi.encodePacked(audio_bytes, sequence2);
            }

            return audio_bytes;
        }
    }
