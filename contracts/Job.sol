pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2;

import "./SafeMath.sol";

contract Job {
    // How should the data inputs and outputs be stored?
    using SafeMath for uint256;


    struct jobInfo {
        string jobName;
        string resoureName;
        string userName;
        bytes32 jobID;
        uint256 submittedDate;
        uint256 startTime;
        address requestor;
        uint256 endTime;
    }

    jobInfo info;

    event Killed(address requestor);

    constructor (address _requestor, bytes32 _jobID, string memory _name, string memory _date) public {
        addJobInfo(_requestor, _jobID, _name, _date);
    }

    /** @dev gets the address of the instantiated contract
     * @return the contract address
     */
    function getAddress() public view returns(address) {
        return(address(this));
    }

    function addJobInfo(address _requestor,  bytes32 _jobID, string memory _name, string memory _date) public {
        info.jobName = _name;
        info.resoureName = "SDSC Comet";
        //info.userName = _userName;
        info.jobID = _jobID;
        info.startTime = _date;
        info.requestor = _requestor;
    }

    function getJobInfo() public view returns(jobInfo memory) {
        return(info);
    }


    /** @dev assign a finished date to the job
    * @param _date date of the completed job
    */
    function updateEndTime(uint _date) public {
        info.endTime = _date;
    }

    /** @dev assign a finished date to the job
    * @param _date date of the completed job
    */
    function updateStartTime(uint _date) public {
        info.startTime = _date;
    }

    /** @dev get the creator of the Job contract
    * @return an address the requestor
    */
    function getRequestor() public view returns(address) {
        return(info.requestor);
    }

    /** @dev get the start date
    * @return return a string containing the submitted date
    */
    function getSubmittedDate() public view returns(uint) {
        return(info.submittedDate);
    }

    /** @dev get the date the job was completed
    * @return a string containing the finish date
    */
    function getFinishedDate() public view returns(uint) {
        return(info.endTime);
    }

    /** @dev get the job name
    * @return string containing the name of the job
    */
    function getJobName() public view returns(string memory) {
        return(info.jobName);
    }

}