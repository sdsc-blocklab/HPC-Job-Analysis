const BlockLab = artifacts.require("BlockLab");
const Job = artifacts.require("Job");

// Set up your variables
let blocklabInstance;
let jobContract;

contract('BlockLab', (accounts) => {
  
  describe('Basic Instatiation', async () => {
    before(async function(){
        const blocklabInstance = await BlockLab.deployed();
    });
  
    it('BlockLab contract is properly deployed', async () => {
      const blocklabInstance = await BlockLab.deployed();
      const blAddress = blocklabInstance.address; 
      assert(blAddress, "BlockLab contract does not exist");
	});
    
    it('BlockLab is instantiated with zero jobs', async () => {
        const blocklabInstance = await BlockLab.deployed();
		const numJobs = await blocklabInstance.getNumJobs();
		assert.equal(numJobs,0,"There should be no jobs active here");
    });
      
    it('Add a Job to BlockLab', async () => {
		const blockLabInstance = await BlockLab.deployed();
		await blockLabInstance.addJob(accounts[0],"a job","sdsc","atmartorana");
		const numJobs = await blockLabInstance.getNumJobs();
		assert.equal(numJobs,1,"There should be one active job here");
	});

    it('Get the Job Address of the created Job', async () => {
        const blocklabInstance = await BlockLab.deployed();
        const myJob = await blocklabInstance.addJob(accounts[0], "a job", "sdsc", "atmartorana");
        jobAddress = myJob.logs[0].args.res
        //console.log(jobAddress);
		assert(jobAddress,"There should be an address");
    });
});
	describe('Job Getters', async () => {
		before(async function(){
			blocklabInstance = await BlockLab.deployed();
			const myJob = await blocklabInstance.addJob(accounts[0], "a job", "sdsc", "atmartorana");
			const jobAddress = myJob.logs[0].args.res;
			jobContract = await Job.at(jobAddress);
		});

		// All the Job Getters --> Before this you will need to instantiate an instance of the Job Contract ... Job.at(<Address>) something like that
		it('Get the Job name', async () => {
			const name = await jobContract.getJobName();
			assert.equal(name,"a job","Job names should be equal");
		});

		it('Get the Job requestor', async () => {
			const requestor = await jobContract.getRequestor();
			assert.equal(accounts[0],requestor,"Job names should be equal");
		});

		it('Get the Job submit date', async () => {
			const submitDate = await jobContract.getSubmittedDate();
			assert(submitDate,"a job","Job names should be equal");
		});

		/*
		//Determined by another factor
		it('Get the Job finish time', async () => {
			const finishDate = jobContract.getFinishedDate();
			assert.equal(name,"a job","Job names should be equal");
		});
		
		//Unsure how to go about this without just testing each individual component
		it('Get the Job info', async () => {
			const name = jobContract.getJobInfo();
			assert.equal(name,"a job","Job names should be equal");
		});
		*/
	});

});