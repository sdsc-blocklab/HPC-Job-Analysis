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

    constructor (string memory _name, string memory _resourceName, string memory _userName, bytes32 _jobID, address _requestor) public {
        addJobInfo(_name,_resourceName,_userName,_jobID,now,_requestor);
    }

    /** @dev gets the address of the instantiated contract
     * @return the contract address
     */
    function getAddress() public view returns(address) {
        return(address(this));
    }

    function addJobInfo(string memory _name, string memory _resourceName, string memory _userName, bytes32 _jobID,
    uint256 _startTime, address _requestor) public {
        info.jobName = _name;
        info.resoureName = _resourceName;
        info.userName = _userName;
        info.jobID = _jobID;
        info.startTime = _startTime;
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