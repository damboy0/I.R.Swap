// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.2.27;

contract InterestBasesSwap {

    // Constants 
    uint256 constant BPS = 10_000;
    uint256 constant YEAR = 365 days;

    enum State {
        Active,
        Settled ,
        Cancelled
    }

    struct Swap {
        // parties involved
        address fixedRatePayer; // address paying the fixed rate
        address floatingRatePayer; // address paying the floating rate
        //Terms Involved
        uint256 referenceAmount; // also notional . The reference number used purely for calculating interest.
        uint256 fixedRate;
        uint256 floatingRate;
        //Time Taken
        uint256 swapBegin; // when tje swap begins
        uint256 swapDuration; // Duration of the swap
        //
        State state;
    }

    uint256 public swapCount;

    mapping (uint256 => Swap) public swaps;
    mapping (uint256 => mapping (address => uint256)) public deposits;


    //Events
    event SwapCreated(uint256 indexed id, address fixedRatePayer, address floatingRatePayer);

    //Errors
    error insufficientCollateral();
    


    function createSwap(
        address floatingRatePayer, 
        uint256 referenceAmount,
        uint256 fixedRate,
        uint256 floatingRate,
        uint256 duration
    )  external payable returns (uint256 swapId) {
        if (msg.value == 0) revert insufficientCollateral();

        swapId = swapCount++;

        swaps[swapId] = Swap({
            fixedRatePayer : msg.sender,
            floatingRatePayer: floatingRatePayer,
            referenceAmount: referenceAmount,
            fixedRate: fixedRate,
            floatingRate: floatingRate,
            swapBegin: block.timestamp, 
            swapDuration: duration,
            state: State.Active
        });

        deposits[swapId][msg.sender] = msg.value; 

        emit SwapCreated( swapId , msg.sender, floatingRatePayer );

    }
}
