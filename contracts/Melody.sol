// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

    contract MelodyGen{

        struct Melody{
            uint _numTones;
            uint16[2][] _tones;
            uint _numSamples;
        }

        Melody melody;

        constructor(){
            uint numTones = 3;
            uint16[2][] memory tones = new uint16[2][](numTones);
            tones[0] = [261, 800];
            tones[1] = [294, 800];
            tones[2] = [330, 800];
            uint numSamples = 800 + 800 + 800;
            melody = Melody(numTones, tones, numSamples);
        }

        function createMelody() public view returns (bytes memory){
            uint numSamples = melody._numSamples;
            uint numTones = melody._numTones;
            uint16[2][] memory tones = melody._tones;
            bytes memory buffer = new bytes(numSamples + 1); //add one for beginning byte

            //bytes1 startSample = 0x00;
            //buffer = abi.encodePacked(startSample);
            buffer = abi.encodePacked(genTone(tones[0][0], tones[0][1]));
            bytes memory temp = new bytes(numSamples);

            for (uint i=1; i<numTones; i++){
                uint toneFreq = tones[i][0];
                uint toneDur = tones[i][1];
                temp = abi.encodePacked(buffer, genTone(toneFreq, toneDur));
                buffer = temp;
            }
            return buffer;

        }

        function genTone(uint _freq, uint _dur) public pure returns (bytes memory){
            bytes memory tone = new bytes(_dur);
            bytes1 high = 0xFF;
            bytes1 low = 0x00;

            tone = abi.encodePacked(high);

            uint srate = 8000;
            uint cycle_len = srate/_freq;
            uint midpoint = cycle_len/2;

            uint i = 0;
            uint sample_inc = 0;
            while (i<(_dur-1)){
                if (sample_inc<=midpoint){
                    tone = abi.encodePacked(tone, high);
                }
                else {
                    tone = abi.encodePacked(tone, low);
                }
                sample_inc++;
                i++;
                if (sample_inc == cycle_len){
                    sample_inc = 0;
                }
                
            }
            return tone;
        }

        function getTone() public pure returns (bytes memory){
            bytes memory buf = new bytes(1600);
            buf = abi.encodePacked(genTone(400, 800), genTone(500, 800));
            return buf;
        }

        function getNumTones() public view returns (uint){
            return melody._numTones;
        }
    }