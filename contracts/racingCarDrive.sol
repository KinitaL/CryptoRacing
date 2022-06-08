pragma solidity ^0.8;

import "./racingCarHelper.sol";

contract RacingCarDrive is RacingCarHelper {
    function race(uint _racingCarId, uint _targetId) external onlyOwnerOfCar(_racingCarId) {
        RacingCar storage car = racingCars[_racingCarId];
        RacingCar storage targetCar = racingCars[_targetId];
        require(_isReady(car));
        if ((car.level + car.winCount/10 - car.lossCount/10) > (targetCar.level + targetCar.winCount/10 - targetCar.lossCount/10)) {
            car.winCount++;
            targetCar.lossCount++;
            _tuningRacingCar(_racingCarId);
        } else {
            car.lossCount++;
            targetCar.winCount++;
            _triggerCooldown(car);
        }
    }
}