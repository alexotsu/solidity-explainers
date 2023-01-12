pragma solidity ^0.8.13;

abstract contract InheritedA {
    function returnString() public virtual pure returns(string memory str) {
        str = 'Returned from A';
    }
}

abstract contract InheritedB {
    function returnString() public virtual pure returns(string memory str) {
        str = 'Returned from B';
    }
}

contract Inherits1 is InheritedA, InheritedB { // returns 'Returned from B'
    function returnString() public override(InheritedA, InheritedB) pure returns(string memory str) {
        str = super.returnString();
    }
}

contract Inherits2 is InheritedB, InheritedA { // returns 'Returned from A'
    // override order doesn't make any difference, the below is equivalent to `override(InheritedB, InheritedA)`
    function returnString() public override(InheritedA, InheritedB) pure returns(string memory str) {
        str = super.returnString();
    }
}

contract InheritsExplicit is InheritedA, InheritedB { // returns 'Returned from A'
    function returnString() public override(InheritedA, InheritedB) pure returns(string memory str) {
        str = InheritedA.returnString(); // explicitly specifying the function from a parent contract works
    }
}