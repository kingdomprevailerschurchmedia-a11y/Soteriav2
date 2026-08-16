# Soteria Question Bank — Working Directory

This directory is the dedicated local workspace for authoring Soteria production question content.

## Working Schema

Each question added to the JSON files in this directory must follow the working structure below:

```json
{
  "question": "...",
  "options": [
    "...",
    "...",
    "...",
    "..."
  ],
  "correctAnswer": "...",
  "explanation": "...",
  "categoryId": "...",
  "difficulty": "easy|medium|hard",
  "source": "..."
}
```

## Category Consistency Rules

Each category file is strictly restricted to its corresponding `categoryId`. The mapping is as follows:

- **general_knowledge.json** → `categoryId`: "general_knowledge"
- **mathematics.json** → `categoryId`: "mathematics"
- **science.json** → `categoryId`: "science"
- **technology.json** → `categoryId`: "technology"
- **history.json** → `categoryId`: "history"
- **geography.json** → `categoryId`: "geography"
- **business.json** → `categoryId`: "business"
- **literature.json** → `categoryId`: "literature"
- **sports.json** → `categoryId`: "sports"
- **current_affairs.json** → `categoryId`: "current_affairs"
- **medicine.json** → `categoryId`: "medicine"
- **arts.json** → `categoryId`: "arts"
- **programming.json** → `categoryId`: "programming"
- **engineering.json** → `categoryId`: "engineering"
- **languages.json** → `categoryId`: "languages"
- **law.json** → `categoryId`: "law"
- **finance.json** → `categoryId`: "finance"
- **psychology.json** → `categoryId`: "psychology"
- **design.json** → `categoryId`: "design"

## Important Notes

- This is the **WORKING** content format only. It may differ from the final import or Firestore schema.
- Reconcile with the Soteria question importer and Firestore structure before final publishing.
- Do NOT modify `tools/question_import/data/first_production_batch_v1.json`.
