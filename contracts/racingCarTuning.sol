pragma solidity ^0.8;

import "./racingCarFactory.sol";

contract RacingCarTuning is RacingCarFactory {
    function tuningRacingCar(uint _carId) public {
        require(msg.sender == racingCarToOwner[_carId]);
        racingCars[_carId].level++;
    }
}