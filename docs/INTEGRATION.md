# Integration Guide

## Integrating with ERC-8183

### Step 1: Deploy Contracts

```bash
npx hardhat run scripts/deploy.js --network sepolia
```

### Step 2: Configure Your DApp

```javascript
import { ethers } from 'ethers';
import { JEPVerifier, JEP8183Extension } from '@jep-eth/sdk';

// Initialize contracts
const verifier = new JEPVerifier(verifierAddress, provider);
const extension = new JEP8183Extension(extensionAddress, provider);
```

### Step 3: Generate JEP Receipt

```javascript
const receipt = {
  actor: agentAddress,
  decisionHash: ethers.utils.keccak256(taskDetails),
  authorityScope: 'erc-8183',
  valid: {
    from: Math.floor(Date.now() / 1000),
    until: Math.floor(Date.now() / 1000) + 3600
  }
};
