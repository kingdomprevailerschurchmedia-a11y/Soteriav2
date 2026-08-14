# Question Taxonomy Architecture

This document describes the foundational taxonomy system for Soteria's question bank.

## Hierarchy

The taxonomy follows a three-level hierarchy, though levels can be optional:

1.  **Category**: The broadest classification (e.g., Science, History).
2.  **Subcategory**: A more specific grouping within a category (e.g., Biology within Science).
3.  **Topic**: The most granular level (e.g., Genetics within Biology).

## Domain Entities

### Category
- `id`: Stable unique identifier (e.g., `science`).
- `name`: User-facing display name (e.g., "Science").
- `slug`: URL-friendly identifier.
- `icon`: Reference to a design system icon.
- `displayOrder`: Deterministic ordering.
- `active`: Lifecycle status.
- `featured`: Whether to highlight in the UI.

### Subcategory
- `id`: Unique identifier.
- `categoryId`: Reference to the parent category.
- `name`: Display name.
- `slug`: URL-friendly identifier.

### Topic
- `id`: Unique identifier.
- `subcategoryId`: Reference to the parent subcategory.
- `name`: Display name.

## Difficulty

Difficulty is a property of the **Question**, not the Category. It is represented by a centralized enumeration:

- `easy`
- `medium`
- `hard`
- `expert`
- `adaptive`

## Firestore Structure

Taxonomy data is stored in flat collections for efficient querying:

- `categories/{categoryId}`
- `subcategories/{subcategoryId}`
- `topics/{topicId}`

Every subcategory document contains a `categoryId` field.
Every topic document contains a `subcategoryId` field.

## Caching & Performance

- Categories are metadata and are cached locally using Firestore's persistence.
- Providers watch the streams to ensure the UI stays in sync with any remote updates (e.g., marking a category inactive).
- Seed data is used for development and previews but is not embedded in production widgets.

## Onboarding Compatibility

The stable Category IDs (e.g., `science`) are designed to map directly from the user's selected interests during onboarding, allowing for personalized content delivery in future stories.
