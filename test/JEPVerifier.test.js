const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("JEPVerifier", function () {
  let verifier;
  let owner, verifier1, user;

  beforeEach(async function () {
    [owner, verifier1, user] = await ethers.getSigners();
    
    const JEPVerifier = await ethers.getContractFactory("JEPVerifier");
    verifier = await JEPVerifier.deploy();
    await verifier.deployed();
  });

  it("should set deployer as first verifier", async function () {
    expect(await verifier.isAuthorized(owner.address)).to.be.true;
  });

  it("should allow authorized verifiers to add new verifiers", async function () {
    await verifier.addVerifier(verifier1.address);
    expect(await verifier.isAuthorized(verifier1.address)).to.be.true;
  });

  it("should not allow unauthorized to add verifiers", async function () {
    await expect(
      verifier.connect(user).addVerifier(verifier1.address)
    ).to.be.revertedWith("JEPVerifier: not authorized");
  });

  it("should record verification results", async function () {
    const receiptHash = ethers.utils.keccak256(ethers.utils.toUtf8Bytes("test-receipt"));
    
    await verifier.recordVerification(receiptHash, true);
    
    expect(await verifier.isReceiptValid(receiptHash)).to.be.true;
    expect(await verifier.getVerificationTimestamp(receiptHash)).to.not.equal(0);
  });
});
