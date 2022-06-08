pragma solidity ^0.8;

import "./racingCarTuning.sol";

contract RacingCarHelper is RacingCarTuning {
    uint levelUpFee = 0.0005 ether;

    modifier aboveLevel(uint _carId, uint _level) {
        require(racingCars[_carId].level >= _level);
        _;
    }

    function withdraw() external onlyOwner {
        address  _owner = owner();
        payable(_owner).transfer(address(this).balance);
    }

    function setLevelUpFee(uint _fee) external onlyOwner {
        levelUpFee = _fee;
    }

    
    function levelUp(uint _carId) external payable {
        require(msg.value == levelUpFee);
        racingCars[_carId].level++;
    }

    function changeName(uint _carId, string memory _newName) external aboveLevel(_carId, 2) onlyOwnerOfCar(_carId) {
        racingCars[_carId].name = _newName;
    }

    function getRacingCarByOwner(address _owner) external view returns(uint) {
        uint result;
        for (uint i = 0; i < racingCars.length; i++) {
            if (racingCarToOwner[i] == _owner) {
                result = i;
            }
        }
        return result;
    }
}