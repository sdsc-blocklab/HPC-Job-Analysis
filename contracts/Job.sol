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

    constructor (address payable _requestor, string memory _name, string memory _date) public {
        requestor = _requestor;
        jobName = _name;
        submittedDate = _date;
        finishedDate = "N/A";
    }


    function getAddress() public view returns(address) {
        return(address(this));
    }

    function addDataInput(uint256 _inputAddr) public {
        dataInputs[numDataInputs] = _inputAddr;
        numDataInputs = numDataInputs.add(1);
    }

    function getDataInput(uint index) public view returns(uint256) {
        if(index < numDataInputs) {
            return(dataInputs[index]);
        } else {
            return(0);
        }
    }

    function addAnalyticSP(uint256 _anaSPAddr) public {
        analyticSP[numAnalyticSP] = _anaSPAddr;
        numAnalyticSP = numAnalyticSP.add(1);
    }

    function getDataOutput (uint _index) public view returns(uint256) {
        if(_index < numDataOutputs) {
            return(dataOutputs[_index]);
        } else {
            return(0);
        }
    }

    function getAnalyticSP(uint _index) public view returns(uint256) {
        if(_index < numAnalyticSP) {
            return(analyticSP[_index]);
        } else {
            return(0);
        }
    }

    function addDataOutputs(uint256 _outputAddr) public {
        dataOutputs[numDataOutputs] = _outputAddr;
        numDataOutputs = numDataOutputs.add(1);
    }

    function updateFinishedDate(string memory _date) public {
        finishedDate = _date;
    }

    function getRequestor() public view returns(address) {
        return(requestor);
    }

    function getSubmittedDate() public view returns(string memory) {
        return(submittedDate);
    }

    function getFinishedDate() public view returns(string memory) {
        return(finishedDate);
    }

    function getJobName() public view returns(string memory) {
        return(jobName);
    }

    function kill() public {
        if (msg.sender == requestor) {
            emit Killed(requestor);
            selfdestruct(requestor);
        }
    }
}