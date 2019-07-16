const Migrations = artifacts.require("Migrations");
const BlockLab = artifacts.require("BlockLab");
const Job = artifacts.require("Job");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(BlockLab);
  deployer.deploy(Job);
};
