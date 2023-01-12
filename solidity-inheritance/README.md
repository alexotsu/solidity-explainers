# Inheritance, Inheritance Order, and the `super` Keyword in Solidity
Whenever you see the `super` keyword in Solidity code, it is telling you that the function is being **inherited** from another contract. In short, this means making the functions of the inherited contract available to the inheriting contract. The result is that smart contracts can be more _modular_. As a demonstration, consider the simple example below:

```
abstract contract Inherited {
    function returnString() public virtual pure returns(string memory str) {
        str = 'Returned from Inherited';
    }
}

contract Inherits is Inherited { // returns 'Returned from Inherited'
    function returnStr() public override pure returns(string memory str) {
        str = super.returnString();
    }
}
```

The contract **Inherited** contains the aptly-named `returnString()` function, which returns the text "Returned from Inherited". The contract **Inherits** _inherits_ **Inherited** using the `is` keyword.

Note the keywords `abstract` on the contract and `virtual` in the function call. While those are not strictly required for this demonstration, they are often seen in the context of inheritance because they both serve as signals that the contract and its functions are designed to be inherited. The `abstract` keyword on a contract means the functions contained therein and all their logic will be inherited. The `virtual` keyword on a function means that an inheriting contract can use a function by the same name, but override its logic using the `override` keyword.

(In this particular example, **Inherits** does not strictly need to override the inherited function since since its `returnStr()` function only serves to call the function by the same name on **Inherited**. However, it is useful to see how overriding works for demonstration purposes).

Putting it all together, the `super` keyword means **Inherits** is calling the `returnString()` function from **Inherited**.

## Multiple Inheritance with Identical Function Names
Inheritance can get more complicated when there are multiple contracts involved. In the below code, **Inherits1** inherits two smart contracts, both of which have identically named functions:

```
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
```

Based on the fact that the `returnString()` function on **Inherits1** returns "Returned from B", we can deduce that the `super` refers to the function living in **InheritedB**. The reason for this is that Solidity inheritance is _linearized_ from right to left. Put differently, it will first search the right-most contract for a `returnString()` function, then the next to the left, stopping when it finds one.

You can confirm this behavior by switching the order in which inheritance is declared:

```
contract Inherits2 is InheritedB, InheritedA { // returns 'Returned from A'
    // override order doesn't make any difference, the below is equivalent to `override(InheritedB, InheritedA)`
    function returnString() public override(InheritedA, InheritedB) pure returns(string memory str) {
        str = super.returnString();
    }
}
```

Lastly, in situations like this, you can be explicit about where you want your contract to inherit from:

```
contract InheritsExplicit is InheritedA, InheritedB { // returns 'Returned from A'
    function returnString() public override(InheritedA, InheritedB) pure returns(string memory str) {
        str = InheritedA.returnString(); // explicitly specifying the function from a parent contract works
    }
}
```