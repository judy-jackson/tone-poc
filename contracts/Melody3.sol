// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract MelodyGen{

    uint[] sequence_lens = [2, 4, 8];
    uint[] num_sequences = [8, 64, 128];

    bytes2 sequence_len_2_1 = 0x0001;
    bytes2 sequence_len_2_2 = 0xFF08;

    bytes4 sequence_len_4_1 = 0x12F10000;
    bytes4 sequence_len_4_2 = 0x0015AB20;

    bytes8 sequence_len_8_1 = 0x000000FF004506AB;
    bytes8 sequence_len_8_2 = 0x12345678FFAA0001;

    struct MelodyObject {
        uint256 sequence1_len;
        uint256 num_sequence1;

        uint256 sequence2_len;
        uint256 num_sequence2;
        
        bytes sequence1;
        bytes sequence2;
    }

    function random(string memory seed) internal pure returns (uint256){
        return uint256(keccak256(abi.encodePacked(seed)));
    }

    function toString(uint256 value) internal pure returns (string memory){
        if (value==0){
            return "0";
        }
        uint256 temp = value;
        uint256 digits = 0;
        while (temp!=0){
            digits++;
            temp/=10;
        }
        bytes memory buffer = new bytes(digits);
        while (value!=0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    function randomMelody(uint256 tokenId) internal view returns (MelodyObject memory){

        uint256 len_s1 = getSequence1Length(tokenId);
        bytes memory sequence1 = new bytes(len_s1);
        sequence1 = getSequence1(tokenId, len_s1);
        uint256 num_s1 = 128;

        uint256 len_s2 = getSequence2Length(tokenId);
        bytes memory sequence2 = new bytes(len_s2);
        sequence2 = getSequence2(tokenId, len_s2);
        uint256 num_s2 = 64;

        return MelodyObject(len_s1, num_s1, len_s2, num_s2, sequence1, sequence2);
    }

    function getSequence1Length(uint256 tokenId ) public pure returns (uint256){
        uint256 rand = random(string(abi.encodePacked("SEQUENCE1LENGTH", toString(tokenId)))) % 170;
        
        if (rand < 64) { return 2; }
        if (rand >= 64 && rand < 88) { return 4;}
        if (rand > 88) { return 8; }
        return 4;
    }

    function getSequence1(uint256 tokenId, uint256 len) public view returns (bytes memory){
        uint256 rand = random(string(abi.encodePacked("SEQUENCE1LENGTH", toString(tokenId)))) % 500;
        if (len==2){
            if (rand < 200){ return abi.encodePacked(sequence_len_2_1); }
            if (rand >= 200){ return abi.encodePacked(sequence_len_2_2); }
        }
        if (len==4){
            if (rand < 200){ return abi.encodePacked(sequence_len_4_1); }
            if (rand >= 200){ return abi.encodePacked(sequence_len_4_2); }
        }
        if (len==8){
            if (rand < 200){ return abi.encodePacked(sequence_len_8_1); }
            if (rand >= 200){ return abi.encodePacked(sequence_len_8_2); }
        }
        return abi.encodePacked(sequence_len_4_1);
    }

    function getSequence2Length(uint256 tokenId ) public pure returns (uint256){
        uint256 rand = random(string(abi.encodePacked("SEQUENCE2LENGTH", toString(tokenId)))) % 170;
        
        if (rand < 50) { return 2; }
        if (rand >= 50 && rand < 98) { return 4;}
        if (rand >= 98) { return 8; }
        return 4;
    }

    function getSequence2(uint256 tokenId, uint256 len) public view returns (bytes memory){
        uint256 rand = random(string(abi.encodePacked("SEQUENCE1LENGTH", toString(tokenId)))) % 240;
        if (len==2){
            if (rand < 60){ return abi.encodePacked(sequence_len_2_1); }
            if (rand >= 60){ return abi.encodePacked(sequence_len_2_2); }
        }
        if (len==4){
            if (rand < 60){ return abi.encodePacked(sequence_len_4_1); }
            if (rand >= 60){ return abi.encodePacked(sequence_len_4_2); }
        }
        if (len==8){
            if (rand < 60){ return abi.encodePacked(sequence_len_8_1); }
            if (rand >= 60){ return abi.encodePacked(sequence_len_8_2); }
        }
        return abi.encodePacked(sequence_len_4_1);

    }

    function tokenUri(uint256 tokenId) public view returns (bytes memory){
        MelodyObject memory melody = randomMelody(tokenId);
        return getAudio(melody);
    }

    function getAudio(MelodyObject memory melody) internal pure returns (bytes memory){
            uint sequence1_len = melody.sequence1_len;
            uint num_sequence1 = melody.num_sequence1;

            uint sequence2_len = melody.sequence2_len;
            uint num_sequence2 = melody.num_sequence2;
            uint file_len = (sequence1_len * num_sequence1) + (sequence2_len * num_sequence2);

            bytes memory audio_bytes = new bytes(file_len);

            bytes memory sequence1 = melody.sequence1;
            bytes memory sequence2 = melody.sequence2;

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