# JEP-ERC Bridge

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**JEP-ERC Bridge** is a commercial implementation of the [JEP (Judgment Event Protocol)](https://github.com/hjs-spec/jep-spec) in the Ethereum ecosystem. It adds a **responsibility layer** to agent-to-agent transactions by integrating with ERC-8183 (Agent Task Protocol).

---

## 🚀 The Problem

Agent-to-agent transactions are exploding:
- **$3M+** in agent-to-agent commerce tracked by aGDP
- **3,400+** agents hiring each other on-chain
- **Zero** responsibility tracking

Current stack:
- ✅ ERC-8004: Agent identity
- ✅ ERC-8183: Agent task posting/funding
- ❌ **Missing**: Who authorized what? When? Can it be verified?

---

## 💡 The Solution

JEP-ERC Bridge adds the missing **responsibility layer**:

| Layer | Protocol | Status |
|-------|----------|--------|
| Identity | ERC-8004 | ✅ Live |
| Transaction | ERC-8183 | ✅ Draft |
| **Responsibility** | **JEP-ERC Bridge** | 🚧 In Development |

---

## 📦 Components

### Smart Contracts

| Contract | Description |
|----------|-------------|
| `JEPVerifier.sol` | On-chain verification registry for JEP Receipts |
| `JEP8183Extension.sol` | ERC-8183 compatibility layer |

### SDK (Coming Soon)

```typescript
import { JEPVerifier } from '@jep-eth/sdk';

// Generate a JEP Receipt
const receipt = await JEPVerifier.createReceipt({
  actor: '0x...',
  decisionHash: '0x...',
  authorityScope: 'erc-8183',
  valid: { from: now, until: now + 3600 }
});
```

---

## 🧪 Quick Start

```bash
# Install dependencies
npm install

# Compile contracts
npx hardhat compile

# Run tests
npx hardhat test
```

---

## 📚 Documentation

- [Technical Specification](docs/SPEC.md)
- [Integration Guide](docs/INTEGRATION.md)

---

## 🔗 Relationship to Core JEP

This is a **commercial implementation** of the JEP protocol. The core specification is maintained by the JEP Foundation at [hjs-spec/jep-spec](https://github.com/hjs-spec) and is progressing through IETF standardization.

---

## 📄 License

MIT © 2026 JEP-ETH Contributors
