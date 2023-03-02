//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

abstract contract RoleControl is AccessControl {
    constructor(address addr) {
        _setupRole(DEFAULT_ADMIN_ROLE, addr);
    }

    modifier onlyAdmin() {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "CALLER_NOT_ADMIN");
        _;
    }

    function isAdmin(address addr) external view returns (bool) {
        return hasRole(DEFAULT_ADMIN_ROLE, addr);
    }

    function grantAdmin(address addr) external {
        grantRole(DEFAULT_ADMIN_ROLE, addr);
    }

    function revokeAdmin(address addr) external {
        revokeRole(DEFAULT_ADMIN_ROLE, addr);
    }
}
