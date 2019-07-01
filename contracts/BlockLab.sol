pragma solidity ^0.5.2;

import "./SafeMath.sol";
import "./Job.sol";

contract BlockLab {
    // SafeMath is needed to avoid integer overflow
    using SafeMath for uint256;
    address payable owner;
    uint256 numJobs;
    mapping (uint256 => Job) jobs;
    constructor () public {
        numJobs = 0;
        owner = msg.sender;
    }

      /** @dev checks the Job name.
      * @param _name name of the job you are checking
      * @return res whether or not the name exists
      */
    function checkJobName(string memory _name) private view returns(bool res) {
        uint256 index;
        for(index = 0; index < numJobs; index.add(1)) {
            if(keccak256(abi.encode(jobs[index].getJobName())) == keccak256(abi.encode(_name))) {
                return(false);
            }
        }
        return(true);
    }
    /** @dev adds a job to the queue
      * @param _requestor the address that is requesting the job
      * @param _name of the job you are checking
      * @param _date when the job is started
      * @return res whether or not the name exists
    */
    function addJob(address payable _requestor, string memory _name, string memory _date) public returns(address res) {
        if(checkJobName(_name)) {
            jobs[numJobs] = new Job(_requestor, _name, _date);
            numJobs = numJobs.add(1);
            return(address(jobs[numJobs.sub(1)]));
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
            return(jobs[_index].getAddress());
        } else {
            return(address(0));
        }
    }

    /** @dev returns the index of an inputted job name
      * @param _name of the job you are checking
      * @return res the index of the job name specified
    */
    function findJobByName(string memory _name) public view returns(int256 res) {
        uint256 index;

        for(index = 0; index < numJobs; index = index.add(1)) {
            if(keccak256(abi.encode(jobs[index].getJobName())) == keccak256(abi.encode(_name))) {
                return(int256(index));
            }
        }
        return(-1);
    }

    /** @dev gets total number of jobs
      * @return res number of jobs
    */
    function getNumJobs() public view returns(uint256 res) {
        return(numJobs.sub(1));
    }

    /** @dev kills the job of a specific index
      * @param _index the index of the job
      * @return res a bool saying wether the deletion was sucessful or not
    */
    function killJob(uint256 _index) public returns(bool) {
        if(_index < numJobs) {
            jobs[_index].kill();
            return(true);
        } else {
            return(false);
        }
    }

    /** @dev kills the owner address
    */
    function kill() public {
        if (msg.sender == owner) {
            selfdestruct(owner);
        }
    }
}
