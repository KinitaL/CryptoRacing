pragma solidity ^0.8;

import "./racingCarTuning.sol";

contract RacingCarHelper is RacingCarTuning {
    function getCar() external view returns (RacingCar memory _racingCar) {
        RacingCar memory result;
        for (uint i = 0; i < racingCars.length; i++) {
            if (racingCarToOwner[i] == msg.sender) {
                result = racingCars[i];
            }
        }
        return result;
    }
}