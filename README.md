# simplechainbank
# 🏦 Simple In-Chain Bank

![Uploading Screenshot 2025-10-29 140150.png…]()


A beginner-friendly **Solidity smart contract** that demonstrates how to build a transparent, decentralized on-chain banking system.  
It allows anyone to **deposit**, **withdraw**, and **transfer** ETH directly through the blockchain — no intermediaries, full transparency.

---

## 📍 Contract Details

- **Contract Name:** `SimpleInChainBank`
- **Network:** Ethereum (or compatible EVM chain)
- **Deployed Address:** `0x154c40D7a81E934560A92b7D4459Fe5A3449EFFc`
- **Compiler Version:** `^0.8.19`
- **License:** MIT
- **Author:** Swarnadip Sarkar (via ChatGPT GPT-5 collaboration)
- **Purpose:** Educational demonstration of a decentralized bank logic

---

## 🚀 Features

✅ **Deposit ETH** directly to your account balance  
✅ **Withdraw ETH** safely using reentrancy protection  
✅ **Transfer funds** between users on-chain  
✅ **Check balances** (your own or others’)  
✅ **View total contract balance** for full transparency  
✅ **Event logs** for every action (Deposit, Withdraw, Transfer)  
✅ **Emergency rescue** function (admin-only, optional for demo)  
✅ **Fully viewable & verifiable** on Etherscan

---

## 💻 Smart Contract Functions

| Function | Visibility | Description |
|-----------|-------------|--------------|
| `deposit()` | `external payable` | Deposit ETH into your account |
| `withdraw(uint amount)` | `external` | Withdraw specified ETH amount |
| `transferTo(address to, uint amount)` | `external` | Transfer your balance to another address |
| `getBalance(address account)` | `view` | View any user’s stored balance |
| `myBalance()` | `view` | Quickly check your own balance |
| `getTotalBankBalance()` | `view` | See total ETH stored in the contract |
| `rescueEther(address to, uint amount)` | `onlyOwner` | (Admin) Rescue stuck ETH (use carefully) |
| `changeOwner(address newOwner)` | `onlyOwner` | Change contract owner |
| `receive()` | `external payable` | Allows direct ETH deposits |
| `fallback()` | `external payable` | Reverts on invalid function calls |

---

## ⚙️ How to Use

### Option 1 — Remix IDE
1. Visit [Remix IDE](https://remix.ethereum.org/)
2. Create a new file: `SimpleInChainBank.sol`
3. Paste the Solidity code of this contract
4. Compile with Solidity **v0.8.19** or higher
5. Deploy using:
   - **Injected Provider (MetaMask)** for testnets/mainnet  
   - **JavaScript VM** for quick local testing
6. Interact with functions via the Remix UI.

### Option 2 — Etherscan (if verified)
1. Visit [Etherscan](https://etherscan.io/address/0x154c40D7a81E934560A92b7D4459Fe5A3449EFFc)
2. Connect wallet → “Write Contract” tab
3. Interact with:
   - `deposit()` (send ETH)
   - `withdraw(amount)` (amount in wei)
   - `transferTo(address, amount)` to send to other users

---

## 🧾 Example Workflow

1. **Deposit ETH**  
   - Call `deposit()` and send 0.1 ETH.  
   - Your balance is recorded on-chain.  
   - A `Deposit` event is emitted.

2. **Check Balance**  
   - Call `myBalance()` or `getBalance(your_address)`.

3. **Transfer Funds**  
   - Call `transferTo(receiver_address, amount)`.

4. **Withdraw ETH**  
   - Call `withdraw(amount)` to send ETH back to your wallet.

---

## 🔐 Transparency & Security Notes

- Contract is **non-custodial**: users’ balances are stored on-chain.
- Includes a **simple reentrancy guard**.
- All actions emit on-chain **events** for transparency.
- **Admin “rescue” function** is included only for educational safety;  
  remove it for a truly decentralized version.
- Always test on **testnets** (like Sepolia or Goerli) before mainnet deployment.
- Not audited — for **educational/demo use only**.

---

## 🧩 Future Improvements

- ✅ Add **interest rewards** for deposits  
- ✅ Implement **ERC20 “bank token”** to represent deposits  
- ✅ Create **time-locked savings accounts**  
- ✅ Add **multi-signature** owner control  
- ✅ Integrate with **frontend DApp** using React + Web3.js or Ethers.js  

---

