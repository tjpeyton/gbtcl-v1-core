// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <=0.8.26;

contract Lottery {
    address public manager;
    address payable[] public players;
    address payable winner;
    bool public isComplete;
    uint public salesWindow;
    uint public ticketPrice;

    // change uint to array of erc27 tokens (representing lottery tickets)
    mapping (address => uint) ownerToTickets;

    constructor() {
        manager = msg.sender;
        isComplete = false;
    }

    modifier onlyManager() {
        require(msg.sender == manager);
        _;
    }

    function getManager() public view returns (address) {
        return manager;
    }

    function setTicketPrice(uint _price) public onlyManager {
        ticketPrice = _price;
    }

    function getTicketPrice() public view returns (uint) {
        return ticketPrice;
    }

    function setSalesWindow(uint _window) public onlyManager {
        salesWindow = block.timestamp + _window;
    }

    // public function to assign ownership of a lottery ticket to an address
    function purchaseTicket() public payable {
        require(msg.value >= ticketPrice);
        require(block.timestamp <= salesWindow);

        players.push(payable(msg.sender));
        // mint NFT ticket
        // map address to ticket
    }

    function drawWinner() public onlyManager {
        require(players.length > 0);
        require(block.timestamp >= salesWindow);

        // Generate a random number using Chainlink VRF
        // choose winner from players list
        // send money to winners address
        isComplete = true;
    }

}
