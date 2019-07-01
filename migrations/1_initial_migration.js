const Migrations = artifacts.require("Migrations");
const BlockLab = artifacts.require("BlockLab");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(BlockLab);
};
