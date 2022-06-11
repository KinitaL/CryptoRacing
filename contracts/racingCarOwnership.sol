pragma solidity ^0.8;

import "./racingCarDrive.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract RacingCarOwnership is RacingCarDrive, ERC721("RacingCar","RC") {

    mapping (uint => address) racingCarApprovals;

    modifier addressesNotZero(address from, address to){
        require(address(from) != address(0));
        require(address(from) != address(0));   
        _;
    }

    function balanceOf(address owner) public override virtual view returns (uint256) {
        require(owner != address(0), "ERC721: balance query for the zero address");
        return ownerRacingCarsCount[owner];
    }

    function ownerOf(uint256 tokenId) public override virtual view returns (address) {
        address owner = racingCarToOwner[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }

    function _transfer(address _from, address _to, uint256 _tokenId) internal override  {
        ownerRacingCarsCount[_to]++;
        ownerRacingCarsCount[msg.sender]--;
        racingCarToOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) public override addressesNotZero(from, to) {
        require (racingCarToOwner[tokenId] == msg.sender || racingCarApprovals[tokenId] == msg.sender);
        _transfer(from, to, tokenId);
    }

    function approve(address approved, uint256 tokenId) public override  onlyOwnerOfCar(tokenId) {
        racingCarApprovals[tokenId] = approved;
        emit Approval(msg.sender, approved, tokenId);
    }
}

