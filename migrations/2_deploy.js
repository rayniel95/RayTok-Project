const raytok = artifacts.require("RayToken");

module.exports = async function (deployer) {
  await deployer.deploy(raytok);
};