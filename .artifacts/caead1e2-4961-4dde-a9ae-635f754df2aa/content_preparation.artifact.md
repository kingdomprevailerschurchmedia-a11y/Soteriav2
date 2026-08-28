# Content Strategy & Bulk Upload Guide

This guide explains how to tag and upload questions for different game modes using the provided tools.

## 1. Mode-Based Tagging Strategy

Soteria uses the `tags` array to decide where a question appears. Use this strategy when creating your `bulk_questions.json`.

| Mode | Required Tag | Content Type Recommendation |
| :--- | :--- | :--- |
| **Practice** | `["practice"]` | Educational, long explanations, includes hints. |
| **Pro / Versus** | `["competitive"]` | High-quality, verified, no hints, strictly academic. |
| **General** | *Empty* | Used as a fallback for all modes if specific tags are missing. |

---

## 2. JSON Examples

### A. Practice Mode Question
```json
{
  "text": "What is 2 + 2?",
  "explanation": "Simple arithmetic: 2 plus 2 equals 4.",
  "difficulty": "easy",
  "categoryId": "mathematics",
  "type": "multipleChoice",
  "options": [
    { "id": "1", "text": "3" },
    { "id": "2", "text": "4" }
  ],
  "correctOptionIds": ["2"],
  "tags": ["practice"]
}
```

### B. Competitive Mode Question
```json
{
  "text": "Identify the primary law governing maritime trade in Nigeria.",
  "difficulty": "hard",
  "categoryId": "law",
  "type": "multipleChoice",
  "options": [
    { "id": "1", "text": "Merchant Shipping Act" },
    { "id": "2", "text": "Customs & Excise Act" }
  ],
  "correctOptionIds": ["1"],
  "tags": ["competitive"]
}
```

---

## 3. How to Upload

### Prerequisites
1.  **Service Account:** Get `serviceAccountKey.json` from Firebase Console.
2.  **Environment:** `pip install firebase-admin`

### Step-by-Step
1.  Place your `bulk_questions.json` and `serviceAccountKey.json` in the same folder as the script.
2.  **Dry Run First:** Set `DRY_RUN = True` in the script to verify your JSON format and see the summary stats without uploading.
3.  **Deploy:** Set `DRY_RUN = False` and run:
    ```bash
    python upload_questions.py
    ```

> [!TIP]
> **AI Prompt for 50 Questions:**
> "Generate 50 trivia questions for 'Science'. Tag 30 as 'practice' (Easy/Medium) and 20 as 'competitive' (Hard/Extreme). Return in the specified JSON format."
