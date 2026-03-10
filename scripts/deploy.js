const hre = require("hardhat");

async function main() {
  console.log("Deploying JEP-ERC Bridge contracts...");

  // Deploy JEPVerifier
  console.log("Deploying JEPVerifier...");
  const JEPVerifier = await hre.ethers.getContractFactory("JEPVerifier");
  const verifier = await JEPVerifier.deploy();
  await verifier.deployed();
  console.log(`JEPVerifier deployed to: ${verifier.address}`);

  // Deploy ERC8183Mock
  console.log("Deploying ERC8183Mock...");
  const ERC8183Mock = await hre.ethers.getContractFactory("ERC8183Mock");
  const mock = await ERC8183Mock.deploy();
  await mock.deployed();
  console.log(`ERC8183Mock deployed to: ${mock.address}`);

  // Deploy JEP8183Extension
  console.log("Deploying JEP8183Extension...");
  const JEP8183Extension = await hre.ethers.getContractFactory("JEP8183Extension");
  const extension = await JEP8183Extension.deploy(verifier.address, mock.address);
  await extension.deployed();
  console.log(`JEP8183Extension deployed to: ${extension.address}`);

  console.log("\nDeployment complete!");
  console.log("----------------------");
  console.log("JEPVerifier:", verifier.address);
  console.log("ERC8183Mock:", mock.address);
  console.log("JEP8183Extension:", extension.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
