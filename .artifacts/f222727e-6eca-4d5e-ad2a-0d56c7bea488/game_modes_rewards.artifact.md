# Game Modes: Rewards, Costs, and Session Summaries

This document provides a comprehensive breakdown of the different game modes available in Soteria, outlining what users earn, what they must "pay" (in terms of entry fees or difficulty), and what information is provided in the post-game summary.

---

## 1. Mode Comparison Table

| Game Mode | Entry Fee | XP Reward (Base) | Coin Reward (Base) | Lives | Timer |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Practice** | Free | 10 XP / Correct | 2 Coins / Correct | Infinite | 60s / Q |
| **Pro** | 100 - 1000 Coins | 25 - 45 XP / Correct* | 10 - 20 Coins / Correct* | 3 Lives | 15s / Q |
| **Versus** | 50 Coins (Wager) | 20 XP / Correct | 100 Coins (Winner) | 3 Lives | 15s / Q |
| **Tournament** | 5 Tokens | 25 XP / Correct | Prize Pool Based | 3 Lives | 15s / Q |
| **Daily Quiz** | Free | 200 XP (Bonus) | 50 Coins (Bonus) | 1 Life | 20s / Q |

*\*Pro mode rewards vary significantly based on accuracy bonuses.*

---

## 2. Detailed Mode Breakdown

### 🎯 Practice Mode
*Ideal for learning and warming up without any risk.*
- **Cost**: Free
- **Reward Scaling**: 1.0x - 2.0x based on difficulty level selected.
- **Constraints**: 20 questions per session; users have infinite lives to encourage completion.
- **Summary Goal**: Accuracy and learning progress.

### 🔥 Pro Mode (High Stakes)
*The primary way to earn high XP and climb the competitive ladder. It requires high accuracy to be profitable.*

#### Entry Costs (Local Wallet)
- 10 Questions: **100 Coins**
- 20 Questions: **250 Coins**
- 30 Questions: **500 Coins**
- 50 Questions: **1000 Coins**

#### Coin Returns (The Risk/Reward)
- **Base Reward**: 10 Coins per correct answer.
- **Accuracy Bonuses**:
  - **Perfect Round (100%)**: **+100% of Entry Fee** as a bonus.
  - **Great Round (90%+)**: **+50% of Entry Fee** as a bonus.
- **Profitability Examples**:
  - **10 Questions (100 Coin Entry)**:
    - **10/10 Correct**: 100 (Base) + 100 (Bonus) = **200 Coins** (100 Coin Profit).
    - **9/10 Correct**: 90 (Base) + 50 (Bonus) = **140 Coins** (40 Coin Profit).
    - **8/10 Correct**: 80 (Base) + 0 (Bonus) = **80 Coins** (**20 Coin Loss**).
  - **20 Questions (250 Coin Entry)**:
    - **20/20 Correct**: 200 (Base) + 100 (Bonus) = **300 Coins** (50 Coin Profit).
    - **19/20 Correct**: 190 (Base) + 50 (Bonus) = **240 Coins** (**10 Coin Loss**).
    - **18/20 Correct**: 180 (Base) + 50 (Bonus) = **230 Coins** (**20 Coin Loss**).

#### XP & Scoring (Competitive Advantage)
- **XP Multiplier**: 1.5x (Base 15 XP per correct answer).
- **Scoring**: 2x streak bonuses and higher base points (up to 750 for Expert questions).
- **Summary Bonus**: An additional **5% of your final match score** is converted into Bonus XP.

### ⚔️ Versus Mode (Head-to-Head)
*Competitive 1v1 matches where you play against a live opponent in real-time.*

#### How it Works
1. **Matchmaking**: You enter the Versus Lobby and are matched with an opponent of similar rank.
2. **Synchronized Play**: Both players receive the same questions at the same time. You can see your opponent's score and progress live on your screen.
3. **Outcome**: The player with the highest score at the end wins. If scores are tied, the player with the fastest average response time is declared the winner.

#### The Wager & Rewards
- **Entry Fee (Wager)**: **50 Coins**.
- **The Prize Pool**: **100 Coins** awarded to the winner (Winner takes all).
- **XP Reward**: 20 XP per correct answer (Higher than Practice/Pro base).
- **Rank Points (RP)**:
  - **Victory**: Gain Rank Points to climb the global leaderboard.
  - **Defeat**: Lose Rank Points.

### 🏆 Tournament Mode
*High-stakes organized events with significant rewards.*
- **Cost**: Usually **5 Tokens** (default registration fee).
- **Reward Scaling**: Maximum XP base (2.5x multiplier for Pro subscribers).
- **Constraints**: No lifelines allowed. Strict 15s timer.
- **Summary Goal**: Prize pool qualification and global ranking.

---

## 3. Session Summary (What you see after playing)

Every session concludes with a **Game Result View**, providing the following data points so you can track your growth:

### Performance Stats
- **Final Score**: The cumulative points earned based on speed and accuracy.
- **Accuracy %**: Your correct answer ratio.
- **Max Streak**: The highest number of consecutive correct answers.
- **Total Duration**: How long the entire session lasted.

### Time Metrics
- **Average Response Time**: Your typical speed per question.
- **Fastest Answer**: Your best reaction time.
- **Slowest Answer**: Identifying where you hesitated.

### Economy Rewards
- **Total XP Earned**: Progress toward your next Level/Rank.
- **Coins Earned**: Premium currency added to your wallet.
- **Milestone Progress**: Any badges or long-term goals advanced during this session.

---

## 4. Earning Logic (The Formula)

Rewards are calculated using a base value scaled by difficulty and mode multipliers:

> **XP Earned** = (Base XP * Questions Correct * Difficulty Multiplier)
> **Coins Earned** = (Base Coins * Questions Correct * (Difficulty Multiplier * 0.8))

**Difficulty Multipliers:**
- **Foundation**: 1.0x
- **Intermediate**: 1.2x
- **Advanced**: 1.5x
- **Expert**: 2.0x
- **Adaptive**: 1.8x (Dynamically adjusts to your skill)
