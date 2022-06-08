pragma solidity ^0.8;

import "./racingCarFactory.sol";

contract RacingCarTuning is RacingCarFactory {

    modifier onlyOwnerOfCar(uint _carId) {
        require(msg.sender == racingCarToOwner[_carId]);
        _;
    }

    function _isReady(RacingCar storage _racingCar) internal view returns (bool) {
        return (_racingCar.readyTime <= block.timestamp);
    }

    function _triggerCooldown(RacingCar storage _racingCar) internal {
        _racingCar.readyTime = uint32(block.timestamp + cooldownTime);
    }

    function _tuningRacingCar(uint _carId) internal onlyOwnerOfCar(_carId) {
        RacingCar storage myCar = racingCars[_carId];
        require(_isReady(myCar));
        myCar.level++;
        _triggerCooldown(myCar);
    }
}