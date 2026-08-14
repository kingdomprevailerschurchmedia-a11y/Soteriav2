# Question Bank & Content Pipeline

This document describes the canonical Question Bank system in Soteria, implemented as part of Story 10.1 and 10.2.

## Overview
The Question Bank is the authoritative source for all question content across all game modes (Quiz, Pro, Tournaments, etc.). It resides in `lib/features/question_content`.

## Data Model

### Question Entity
Uses `freezed` for immutability and JSON serialization.
- `id`: Unique identifier (Firestore document ID).
- `text`: The question text.
- `difficulty`: Enum (`easy`, `medium`, `hard`, `expert`, `adaptive`).
- `categoryId`, `subcategoryId`, `topicId`: 3-level taxonomy.
- `type`: `QuestionType` (Multiple Choice, Multiple Select, etc.).
- `options`: List of `Answer` entities.
- `correctOptionIds`: List of correct answer IDs (stripped in competitive payloads).
- `status`: `QuestionStatus` (Draft -> Review -> Approved -> Published -> Archived).

### Taxonomy
- **Category**: High-level grouping (e.g., Cybersecurity).
- **Subcategory**: Mid-level (e.g., Network Security).
- **Topic**: Specific subject (e.g., TLS/SSL).

## Security
- Correct answers must NEVER be served to clients in competitive modes before the result is revealed.
- `QuestionMapper.stripCorrectAnswers` is used to sanitize entities.
- Firestore rules enforce that normal users can only read `published` questions.

## Repository & Data Sources
- `QuestionRepository`: Main interface for fetching and watching questions.
- `FirestoreQuestionDataSource`: Implements paginated and hierarchical queries.
- `QuestionRepositoryImpl`: Adds local caching and validation logic.

## Usage in Game Modes
Game modes should depend on `QuestionRepository` and use the providers in `question_bank_providers.dart`.
- `questionBankProvider`: FutureProvider for list queries.
- `questionByIdProvider`: StreamProvider for real-time single question monitoring.

## Seed Data
Demo questions and taxonomy are available in `lib/features/question_content/data/seed/question_seed_data.dart`.
