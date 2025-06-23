
//vulnerable 

mapping(address => uint256) public balances;

function withdraw() public {
    uint256 amount = balances[msg.sender];
    require(amount > 0, "Nothing to withdraw");

    // We didnot update the state here
    (bool success, ) = msg.sender.call{value: amount}("");
    require(success, "Transfer failed");

    //we update the state here which is wrong
    balances[msg.sender] = 0;
}

//CEI compiled
function withdraw() public {
    uint256 amount = balances[msg.sender];
    require(amount > 0, "Nothing to withdraw");

    // Effects: update state first
    balances[msg.sender] = 0;

    // Interactions: external call after state change
    (bool success, ) = msg.sender.call{value: amount}("");
    require(success, "Transfer failed");
}