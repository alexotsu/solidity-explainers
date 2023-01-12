// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Inheritance.sol";

contract InheritanceTest is Test {
    Inherits1 public inherits1;
    Inherits2 public inherits2;
    InheritsExplicit public inheritsExplicit;

    function setUp() public {
        inherits1 = new Inherits1();
        inherits2 = new Inherits2();
        inheritsExplicit = new InheritsExplicit();
    }

    function testInheritance() public {
        assertEq(inherits1.returnString(), 'Returned from B');
        assertEq(inherits2.returnString(), 'Returned from A');
        assertEq(inheritsExplicit.returnString(), 'Returned from A');
    }
}
