pragma solidity ^0.5.2;

import "./SafeMath.sol";

contract Job {
    address payable requestor;

    mapping (uint => uint256) dataInputs;
    mapping (uint => uint256) dataOutputs;
    mapping (uint => uint256) analyticSP;

    uint256 numDataInputs;
    uint256 numDataOutputs;
    uint256 numAnalyticSP;
    string public jobName;
    string submittedDate;
    string finishedDate;

    using SafeMath for uint256;

    event Killed(address requestor);

    /** @dev instantiates a Job contract
     * @param _requestor the instantiator of the Job contract
     * @param _name name of the Job
     * @param _date date the Job was created
     */
    constructor (address payable _requestor, string memory _name, string memory _date) public {
        requestor = _requestor;
        jobName = _name;
        submittedDate = _date;
        finishedDate = "N/A";
    }

    /** @dev gets the address of the instantiated contract
     * @return the contract address 
     */
    function getAddress() public view returns(address) {
        return(address(this));
    }

    /** @dev store input information
    * @param _inputAddr the data to be stored
    */
    function addDataInput(uint256 _inputAddr) public {
        dataInputs[numDataInputs] = _inputAddr;
        numDataInputs = numDataInputs.add(1);
    }

    /** @dev get data from the corresponding index in the mapping
    * @param index the index of the corresponding input data
    * @return either returns the input data if the index is valid otherwise 0
    */
    function getDataInput(uint index) public view returns(uint256) {
        require(index < numDataInputs);
        return(dataInputs[index]);
    }


    /** @dev store an analyticSP
    * @param _anaSPAddr address of the analyticSP
    */
    function addAnalyticSP(uint256 _anaSPAddr) public {
        analyticSP[numAnalyticSP] = _anaSPAddr;
        numAnalyticSP = numAnalyticSP.add(1);
    }

    /** @dev get the data output
    * @param _index the index of the output
    * @return integer of the output if the index is valid otherwise 0
    */
    function getDataOutput (uint _index) public view returns(uint256) {
        require(_index < numDataOutputs);
        return(dataOutputs[_index]);
    }

    /** @dev get an analyticSP
    * @param _index the index of the analyticSP
    * @return return the analyticSP if index is valid otherwise 0
    */
    function getAnalyticSP(uint _index) public view returns(uint256) {
        require(_index < numAnalyticSP);
        return(analyticSP[_index]);
    }

    /** @dev add data output
    * @param _outputAddr the address of the output
    */
    function addDataOutputs(uint256 _outputAddr) public {
        dataOutputs[numDataOutputs] = _outputAddr;
        numDataOutputs = numDataOutputs.add(1);
    }

    /** @dev assign a finished date to the job
    * @param _date date of the completed job
    */
    function updateFinishedDate(string memory _date) public {
        finishedDate = _date;
    }

    /** @dev get the creator of the Job contract
    * @return an address the requestor
    */
    function getRequestor() public view returns(address) {
        return(requestor);
    }

    /** @dev get the start date
    * @return return a string containing the submitted date
    */
    function getSubmittedDate() public view returns(string memory) {
        return(submittedDate);
    }

    /** @dev get the date the job was completed
    * @return a string containing the finish date
    */
    function getFinishedDate() public view returns(string memory) {
        return(finishedDate);
    }

    /** @dev get the job name
    * @return string containing the name of the job
    */
    function getJobName() public view returns(string memory) {
        return(jobName);
    }

    /** @dev delete the instance of the contract and send the contract's balance 
    * to the owner of the contract
    */
    function kill() public {
        require(msg.sender == requestor);
        emit Killed(requestor);
        selfdestruct(requestor);
    }
}