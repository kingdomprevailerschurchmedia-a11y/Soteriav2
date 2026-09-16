# SOTERIA — FINANCIAL / WALLET ARCHITECTURE RULES

These rules are NON-NEGOTIABLE for all current and future Soteria wallet, coin economy, payment, reward, tournament-entry, and withdrawal features.

Soteria contains a virtual economic system involving coins/tokens and potentially real-money purchases through Paystack.

**Treat all economic operations as FINANCIAL-GRADE operations.**

---

## 1. SERVER-AUTHORITATIVE ECONOMY

The Flutter/mobile client is NEVER the authority for economic state.

The client must NEVER independently:
- Increase wallet balance
- Decrease wallet balance
- Confirm a payment as valid
- Grant purchased coins
- Grant tournament rewards
- Grant refunds
- Approve withdrawals
- Decide whether a user has sufficient funds
- Mark a financial transaction as successful

The backend/database is the authoritative source of truth.
The client may REQUEST an economic operation.
The backend must VALIDATE and EXECUTE that operation.

**Architecture:**
Flutter → Repository / API → Backend → Validation → Atomic database transaction → Wallet + Ledger → Result returned to Flutter

---

## 2. ATOMIC WALLET OPERATIONS

Every wallet mutation MUST be atomic.

For any debit or credit operation, the following must be treated as one indivisible transaction:
1. Validate authenticated user
2. Validate operation
3. Check current wallet state
4. Validate sufficient balance where applicable
5. Create the wallet ledger transaction
6. Update wallet balance/current state
7. Record the operation/reference
8. Commit

If any step fails, the entire operation must fail/rollback.
Never implement financial operations as: `READ BALANCE → calculate new balance → WRITE BALANCE` outside a transaction. That architecture is vulnerable to race conditions.

---

## 3. CONCURRENCY SAFETY

All wallet operations must remain correct under concurrency. Assume users can:
- Log in on multiple devices
- Tap buttons repeatedly
- Send requests simultaneously
- Lose network connectivity
- Retry requests
- Receive duplicate callbacks
- Trigger requests from multiple sessions

**Example:**
User balance = 1,000 coins.
Two simultaneous requests attempt to spend 700 coins each.
Only ONE request may succeed. The second must fail after re-evaluating the latest balance inside the atomic transaction.

---

## 4. WALLET LEDGER

Do NOT rely on a single mutable balance field as the only source of economic truth. Soteria must maintain a wallet transaction ledger.

**Conceptually:**
- **Wallet:** `currentBalance`
- **WalletLedger:** `transactionId`, `userId`, `type`, `direction`, `amount`, `balanceBefore`, `balanceAfter`, `referenceId`, `idempotencyKey`, `status`, `metadata`, `createdAt`, `processedAt`

Every economic movement MUST produce a ledger entry (e.g., `COIN_PURCHASE`, `TOURNAMENT_ENTRY`, `REFUND`, etc.).

---

## 5. IDEMPOTENCY

Every economic operation must be idempotent. The same operation processed multiple times must NOT create multiple economic effects.

Use a unique transaction/reference/idempotency key. If a Paystack reference `PSK_ABC123` has already resulted in a successful coin credit, a second processing attempt MUST NOT credit the coins again.

---

## 6. PAYSTACK INTEGRATION

Paystack must NEVER be trusted solely through the Flutter client.

**Flow:**
Flutter → Create payment intent → Backend creates Paystack transaction → Flutter opens checkout → User completes payment → Paystack calls backend → Backend verifies transaction → Backend checks idempotency → Atomic wallet transaction → Create payment record → Create coin ledger entry → Credit wallet → Mark payment as processed → Return authoritative wallet state.

- Flutter success callback is NOT proof of payment.
- Only server-verified Paystack transactions may trigger credits.
- **Never put Paystack secret keys in Flutter code.**

---

## 7. PAYMENT RECORDS

Maintain a separate payment record from the wallet ledger.
- `Payment`: `paymentId`, `userId`, `provider`, `providerReference`, `amount`, `currency`, `coinPackage`, `status`, `verifiedAt`, `createdAt`, `metadata`

A successful Paystack payment must map to exactly one economic coin-credit operation.

---

## 8. NEVER TRUST CLIENT-SUPPLIED ECONOMIC VALUES

Do not trust the client for coin amounts, prices, balances, or eligibility.
The client sends a package identifier (e.g., `packageId: "coins_1000"`). The backend determines the price, currency, and coin amount.

---

## 9. ECONOMIC OPERATIONS MUST HAVE TYPES

Every wallet mutation must explicitly identify its business reason using a strongly typed enum (e.g., `CoinPurchase`, `TournamentEntry`). Avoid generic `updateBalance` calls.

---

## 10. BALANCE + LEDGER CONSISTENCY

Whenever the wallet balance changes, the `currentBalance` and `WalletLedger` transaction must be updated within the SAME atomic transaction.

---

## 11. REWARDS MUST ALSO BE IDEMPOTENT

Non-payment rewards (e.g., tournament winner) must be idempotent using a Reward ID (e.g., `tournament_123:user_456:winner`) to prevent duplicate granting.

---

## 12. TRANSACTION STATES

Financial operations should have explicit states (e.g., `pending`, `successful`, `failed`, `reversed`). Do not use simple booleans.

---

## 13. FIRESTORE / DATABASE RULE

If Firestore is used, use **Firestore transactions** for atomic mutations. Enforce Firestore Security Rules so clients cannot directly mutate authoritative fields.

---

## 14. ARCHITECTURAL SEPARATION

**Wallet:** `WalletModel`, `WalletRepository`, `WalletService`, `WalletLedger`, `WalletTransaction`, `WalletTransactionType`
**Payments:** `PaymentModel`, `PaymentRepository`, `PaymentService`, `PaystackService`
**Security:** `IdempotencyService`, `TransactionIntegrity`, `EconomicOperationGuard`

---

## 15. UI RESPONSIBILITY

**Flutter UI:** Displaying balance, history, selecting packages, starting flows, showing loading/success/failure states.
**NOT Flutter UI:** Calculating balance, crediting/deducting coins, verifying payments, granting rewards, authorizing withdrawals.

---

## 16. FAILURE / RETRY BEHAVIOR

Design for failure at any point. The system must recover safely without duplicate credits, lost payments, or negative balances.

---

## 17. SECURITY PRINCIPLE

> "THE CLIENT REQUESTS. THE SERVER VALIDATES. THE DATABASE ATOMICALLY COMMITS. THE LEDGER RECORDS. IDEMPOTENCY PREVENTS DUPLICATION."

---

## 18. BEFORE IMPLEMENTING

1. Inspect existing Soteria architecture.
2. Reuse existing transaction/integrity abstractions.
3. Identify where authoritative backend logic belongs.
4. Define Wallet, Ledger, and Payment models.

---

## 19. REQUIRED IMPLEMENTATION REVIEW

- [ ] Client cannot directly manipulate balance
- [ ] Balance mutations are atomic
- [ ] Concurrent requests are safe
- [ ] Negative balances are impossible
- [ ] Every mutation creates a ledger record
- [ ] Every operation has an idempotency key
- [ ] Paystack payments verified server-side
- [ ] Paystack secret keys are not exposed
- [ ] Rewards are idempotent
- [ ] Security rules prevent unauthorized mutations

---

## 20. CORE SOTERIA PRINCIPLE

Soteria's virtual economy must be treated as a financial system. Correctness is more important than convenience. Never optimize away atomicity, concurrency protection, idempotency, or auditability.
