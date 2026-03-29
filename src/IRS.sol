contract InterestBasesSwap {

    enum State {
        
    }

    // parties involved
    address fixedRatePayer; // address paying the fixed rate 
    address floatingRatePayer; // address paying the floating rate 

    //Terms Involved
    uint256 referenceAmount;
    uint256 fixedRate;
    uint256 floatingRate;

    //Time Taken 
    uint256 swapBegin; // when tje swap begins
    uint256 swapDuration; // Duration of the swap  

    //
    State 



    constructor() {
        
    }
}