pragma solidity ^0.8;

import "@openzeppelin/contracts/access/Ownable.sol";

contract RacingCarFactory is Ownable {

    uint cooldownTime = 1 days;
    
    struct RacingCar {
        string name;
        uint32 level;
        uint32 readyTime;
    }

    RacingCar[] public racingCars;

    mapping(uint => address) racingCatToOwner;
    mapping(address => uint) ownerRacingCarsCount;

    function _createRacingCar(string memory _name) internal {
        racingCars.push(RacingCar(_name, 1, uint32(block.timestamp + cooldownTime)));
        uint id = racingCars.length - 1;
        racingCatToOwner[id] = msg.sender;
        ownerRacingCarsCount[msg.sender]++;
    }

    function createRacingCar(string memory _name) public {
        require(ownerRacingCarsCount[msg.sender] == 0);
        _createRacingCar(_name);
    }
}