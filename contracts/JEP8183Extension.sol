// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./JEPVerifier.sol";
import "./mocks/ERC8183Mock.sol";

contract JEP8183Extension {
    JEPVerifier public verifier;
    ERC8183Mock public erc8183;
    
    mapping(uint256 => bytes32) public taskReceipts;
    mapping(uint256 => bytes32) public providerProofs;
    
    event TaskFundedWithResponsibility(uint256 indexed taskId, address indexed provider, bytes32 receiptHash, bool verified);
    event TaskSubmittedWithProof(uint256 indexed taskId, bytes32 proofHash);
    
    constructor(address _verifier, address _erc8183) {
        verifier = JEPVerifier(_verifier);
        erc8183 = ERC8183Mock(_erc8183);
    }
    
    function fundTaskWithResponsibility(uint256 taskId, bytes32 receiptHash, bool isValid) external payable {
        taskReceipts[taskId] = receiptHash;
        erc8183.fundTask{value: msg.value}(taskId);
        emit TaskFundedWithResponsibility(taskId, msg.sender, receiptHash, isValid);
    }
    
    function submitTaskWithProof(uint256 taskId, bytes calldata deliveryProof, bytes32 responsibilityProof) external {
        providerProofs[taskId] = responsibilityProof;
        erc8183.submitTask(taskId, deliveryProof);
        emit TaskSubmittedWithProof(taskId, responsibilityProof);
    }
    
    function getTaskResponsibility(uint256 taskId) external view returns (bytes32 receiptHash, bytes32 proofHash) {
        return (taskReceipts[taskId], providerProofs[taskId]);
    }
}
