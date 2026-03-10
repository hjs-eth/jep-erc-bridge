// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract JEPVerifier {
    mapping(bytes32 => bool) public verifiedReceipts;
    mapping(address => bool) public authorizedVerifiers;
    mapping(bytes32 => uint256) public verificationTimestamps;
    
    event ReceiptVerified(bytes32 indexed receiptHash, bool isValid, address indexed verifier, uint256 timestamp);
    event VerifierAdded(address indexed verifier, address indexed addedBy);
    event VerifierRemoved(address indexed verifier, address indexed removedBy);
    
    modifier onlyAuthorized() {
        require(authorizedVerifiers[msg.sender], "JEPVerifier: not authorized");
        _;
    }
    
    constructor() {
        authorizedVerifiers[msg.sender] = true;
        emit VerifierAdded(msg.sender, msg.sender);
    }
    
    function recordVerification(bytes32 receiptHash, bool isValid) external onlyAuthorized {
        verifiedReceipts[receiptHash] = isValid;
        verificationTimestamps[receiptHash] = block.timestamp;
        emit ReceiptVerified(receiptHash, isValid, msg.sender, block.timestamp);
    }
    
    function batchRecordVerification(bytes32[] calldata receiptHashes, bool[] calldata isValid) external onlyAuthorized {
        require(receiptHashes.length == isValid.length, "JEPVerifier: array length mismatch");
        
        for (uint i = 0; i < receiptHashes.length; i++) {
            verifiedReceipts[receiptHashes[i]] = isValid[i];
            verificationTimestamps[receiptHashes[i]] = block.timestamp;
            emit ReceiptVerified(receiptHashes[i], isValid[i], msg.sender, block.timestamp);
        }
    }
    
    function isReceiptValid(bytes32 receiptHash) external view returns (bool) {
        return verifiedReceipts[receiptHash];
    }
    
    function getVerificationTimestamp(bytes32 receiptHash) external view returns (uint256) {
        return verificationTimestamps[receiptHash];
    }
    
    function addVerifier(address verifier) external onlyAuthorized {
        require(verifier != address(0), "JEPVerifier: zero address");
        require(!authorizedVerifiers[verifier], "JEPVerifier: already authorized");
        
        authorizedVerifiers[verifier] = true;
        emit VerifierAdded(verifier, msg.sender);
    }
    
    function removeVerifier(address verifier) external onlyAuthorized {
        require(authorizedVerifiers[verifier], "JEPVerifier: not authorized");
        require(verifier != msg.sender, "JEPVerifier: cannot remove self");
        
        delete authorizedVerifiers[verifier];
        emit VerifierRemoved(verifier, msg.sender);
    }
    
    function isAuthorized(address verifier) external view returns (bool) {
        return authorizedVerifiers[verifier];
    }
}
