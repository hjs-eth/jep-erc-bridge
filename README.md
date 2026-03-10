# JEP-ERC Bridge

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**JEP-ERC Bridge** is a commercial implementation of the [JEP (Judgment Event Protocol)](https://github.com/hjs-spec/jep-spec) in the Ethereum ecosystem. It adds a **responsibility layer** to agent-to-agent transactions by integrating with ERC-8183 (Agent Task Protocol) and ERC-8004 (Agent Identity).

## 🚀 Why This Matters

- **ERC-8183** enables agents to post tasks, fund them, and submit deliverables
- **ERC-8004** gives agents verifiable on-chain identities and reputation
- **JEP** adds the missing piece: **who authorized what, when, and can it be verified?**

Together, they form a complete trust stack for autonomous agents:
- Identity → ERC-8004
- Transaction → ERC-8183
- **Responsibility → JEP (this bridge)**

## 📦 What's Inside

- `contracts/` – Solidity contracts for JEP verification
- `sdk/` – TypeScript SDK for generating/verifying JEP Receipts
- `demo/` – Example integration with ERC-8183

## 🧪 Status

🚧 **Experimental** – This is a proof-of-concept under active development. Not yet production-ready.

## 🔗 Relationship to Core JEP

This is a **commercial implementation** of the JEP protocol. The core specification is maintained by the JEP Foundation at [hjs-spec/jep-spec](https://github.com/hjs-spec/jep-spec) and is progressing through IETF standardization.

## 📄 License

MIT © 2026 JEP-ETH Contributors
