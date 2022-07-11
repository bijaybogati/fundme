// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    uint256  favoriteNumber;
    //sending value to struct
    // People public person = People({favoriteNumber: 2, name: "Bijay"});

    mapping(string => uint256) public nameToFavoriteNumber;
    struct People{
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;


    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }
    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public{
        //other option
        // People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        // people.push(newPerson);

        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }


}

 