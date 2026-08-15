# Soteria: Production Question Content Specification

This document defines the exact contract for all production questions in the Soteria Question Bank.

## 1. Question Schema (Domain)

| Field | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `id` | String | Yes | Unique identifier (e.g., UUID or stable slug). |
| `text` | String | Yes | The actual question text. |
| `explanation` | String? | No | Text explaining the correct answer/context. |
| `difficulty` | Difficulty | Yes | Enum: `easy`, `medium`, `hard`, `expert`, `adaptive`. |
| `categoryId` | String | Yes | Reference to Category ID (e.g., `science`). |
| `subcategoryId` | String? | No | Reference to Subcategory ID. |
| `topicId` | String? | No | Reference to Topic ID. |
| `type` | QuestionType | Yes | Enum: `multipleChoice`, `trueFalse`, etc. |
| `options` | List<Answer> | Yes | List of possible answers. |
| `correctOptionIds`| List<String> | Yes | Authoritative IDs of correct options. |
| `tags` | List<String> | No | Metadata tags for searching/filtering. |
| `language` | String | Yes | ISO 639-1 code (default: `en`). |
| `estimatedTime` | Duration | Yes | Expected time to solve (default: 30s). |
| `xpValue` | int | Yes | XP awarded for correct answer (default: 10). |
| `coinValue` | int | Yes | Coins awarded for correct answer (default: 5). |
| `status` | Status | Yes | Enum: `draft`, `review`, `approved`, `published`, `archived`. |
| `version` | String | Yes | Semantic version (e.g., `1.0.0`). |
| `source` | String | Yes | Attribution source (e.g., "Internal", "Wikipedia"). |
| `author` | String? | No | Identifier of the author. |
| `createdAt` | DateTime | Yes | Timestamp of creation. |
| `updatedAt` | DateTime | Yes | Timestamp of last update. |
| `schemaVersion` | int | Yes | Version of the data structure (current: 1). |

---

## 2. Firestore Storage Contract

- **Collection Path**: `questions`
- **Document ID**: Mapped to `id`.
- **Enum Storage**: Stored as lowercase strings (e.g., `"published"`, `"easy"`).
- **Date Storage**: Stored as ISO 8601 strings in DTO/Firestore (converted to `DateTime` in domain).
- **Correct Answers**: `correctOptionIds` must match `id` values in the `options` list.

---

## 3. Validation Rules

A question is considered **VALID** if:
1.  `text` is not empty.
2.  `categoryId` is not empty and matches a valid Category ID.
3.  `type` is supported by the `QuestionType` enum.
4.  `options` contains at least 2 unique items for `multipleChoice`.
5.  `correctOptionIds` contains at least one ID that exists in `options`.
6.  For `multipleChoice`, exactly one correct option is allowed.
7.  Option texts are unique within the question.
8.  Option IDs are unique within the question.
9.  `xpValue` is non-negative.

---

## 4. Category Taxonomy (Current)

Current stable Category IDs:
- `general_knowledge`
- `mathematics`
- `science` (Sub: `biology`, `chemistry`, `physics`)
- `technology`
- `history`
- `geography`
- `business`
- `literature`
- `sports`
- `current_affairs`

---

## 5. Question Status Lifecycle

1.  **Draft**: Work in progress.
2.  **Review**: Awaiting validation and editorial check.
3.  **Approved**: Passed validation, ready to be scheduled.
4.  **Published**: Available to end-users in Practice and Pro modes.
5.  **Archived**: Removed from active rotation (stats preserved).
6.  **Rejected**: Failed review, requires changes.

---

## 6. Question Versioning

- Questions use a `version` string (e.g., `1.1.0`).
- Any material change to `text` or `options` should trigger a version bump.
- Analytics should eventually track performance per version to detect if changes improve clarity.

---

## 7. Import & Safety Process

### Authoring Format
The recommended format is **JSON** for complex structures (options/ids) or a **Master Spreadsheet** with a conversion script.

### Import Pipeline
1.  **Local Validation**: Run `QuestionValidator` on the batch.
2.  **Duplicate Check**: Ensure IDs do not conflict with existing Firestore documents.
3.  **Dry Run**: Output expected changes (New: X, Updates: Y, Errors: Z).
4.  **Batch Write**: Upload to Firestore using an Admin SDK or a controlled script.
5.  **Final Review**: Manually inspect a random sample in the `Question Administration` UI.

---

## 8. Analytics Requirements

To support Story 10.11, the following fields are critical:
- `id` and `version` (for tracking performance shifts).
- `difficulty` (to verify actual vs. perceived difficulty).
- `categoryId` (for subject-specific mastery).
- `metadata` (can store "tags" or "source" for deeper analysis).

**CRITICAL GAP**: The current `QuestionResult` model lacks the `version` field. This must be added before production import to ensure version-level analytics.
