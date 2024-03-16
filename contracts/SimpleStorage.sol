// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract SimpleStorage {
    // boolean uint int address bytes
    // 定义的变量 默认值为0
    uint256 FavoriteNumber;
    People public person = People({FavoriteNumber: 2, name: "yxj"});
    struct People {
        uint256 FavoriteNumber;
        string name;
    }
    uint256[] public FavoriteNumberList;
    People[] public peopelList;

    uint256 hasFavoriteNumber = 123;
    string Text = "wdwd";
    address mm = 0x2011862879eE9F98F593C79e5c14bB5325306d75;
    bytes32 bb = "cat";

    function store(uint256 _favoriteNumber) public {
        FavoriteNumber = _favoriteNumber;
        // retrieve();
    }

    // view pure 函数不用消耗gas;
    function retrieve() public view returns (uint256) {
        return FavoriteNumber;
    }

    function add() public pure returns (uint256) {
        return 1 + 1;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        People memory newPerson = People(_favoriteNumber, _name);
        peopelList.push(newPerson);
    }
}
//0xd9145CCE52D386f254917e481eB44e9943F39138
