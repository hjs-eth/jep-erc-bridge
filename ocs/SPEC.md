# JEP-ERC Bridge Technical Specification

## Overview

This document specifies the technical design of the JEP-ERC Bridge, which integrates the JEP (Judgment Event Protocol) with Ethereum's ERC-8183 Agent Task Protocol.

## Core Components

### JEPVerifier Contract

The JEPVerifier contract serves as an on-chain registry for JEP Receipt verification results.

#### Key Functions
- `recordVerification(bytes32 receiptHash, bool isValid)`: Records the verification result of a JEP Receipt
- `isReceiptValid(bytes32 receiptHash)`: Returns the verification status
- `addVerifier(address verifier)`: Adds a new authorized verifier

### JEP8183Extension Contract

Extends ERC-8183 to include JEP responsibility verification.

#### Key Functions
- `fundTaskWithResponsibility(uint256 taskId, bytes32 receiptHash, bool isValid)`: Funds a task with responsibility proof
- `submitTaskWithProof(uint256 taskId, bytes deliveryProof, bytes32 responsibilityProof)`: Submits task completion with proof
