pragma solidity ^0.5.2;
pragma experimental ABIEncoderV2;

import "./SafeMath.sol";
import "./Job.sol";

contract BlockLab {
    // SafeMath is needed to avoid integer overflow
    using SafeMath for uint256;
    address payable owner;
    uint256 numJobs;
    mapping (uint256 => address) jobs;
    event JobCreated(address res);

    mapping(address=>bool) allowedUsers;

    constructor () public {
        numJobs = 0;
        owner = msg.sender;
        allowedUsers[owner] = true;
    }

    modifier onlyOwner() {
        require(msg.sender == owner,"User is not owner");
        _;
    }

    function addUser (address user) public onlyOwner {
        allowedUsers[user]=true;
    }

    modifier onlyUsers() {
        require(allowedUsers[msg.sender],"User has no priveleges");
        _;
    }

    function addJob(address payable _requestor, string memory _name, string memory _resourceName, string memory _userName) public onlyUsers returns(address res) {
        if(true) {
            bytes32 jobID = keccak256(abi.encode(_requestor, _name, now)); // Finish
            Job newJob = new Job(_name, _resourceName, _userName, jobID, _requestor);
            jobs[numJobs] = address(newJob);
            numJobs = numJobs.add(1);
            emit JobCreated(jobs[numJobs.sub(1)]);
            return(jobs[numJobs.sub(1)]);
        } else {
            return(address(0x0));
        }
    }

    /** @dev gets the address of a job at a specific index in a list
      * @param _index the index of the job
      * @return res the address of the job
    */
    function getJobAddress(uint256 _index) public view returns(address res) {
        if(_index < numJobs) {
            return(jobs[_index]);
        } else {
            return(address(0));
        }
    }

    /** @dev gets total number of jobs
      * @return res number of jobs
    */
    function getNumJobs() public view returns(uint256 res) {
        return(numJobs);
    }
}
