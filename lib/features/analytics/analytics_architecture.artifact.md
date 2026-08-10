# Personal Performance Analytics Architecture

Soteria's analytics system is built on **Real User Data**, transforming historical `QuizResult` entries into meaningful, actionable insights.

## Architecture Layers

### 1. Data Retrieval
The system consumes the existing `QuizHistoryRepository`. It retrieves results filtered by `TimePeriod` (7D, 30D, 90D, All Time) and optional Category/Mode filters.

### 2. Aggregation (`AnalyticsAggregator`)
A deterministic engine that processes a list of `QuizResult` objects. It calculates:
- **Totals**: Questions, Correct/Incorrect, XP, Bests.
- **Averages**: Accuracy, Score, Response Time.
- **Trends**: Multi-point data series for accuracy, score, speed, and XP.
- **Grouped Stats**: Performance broken down by Category and Difficulty.

### 3. Insight Generation
Rule-based logic detects patterns in the aggregated data:
- **Improvement**: Significant positive changes in accuracy or score.
- **Efficiency**: Faster response times while maintaining accuracy.
- **Opportunities**: Identifying weakest categories with supportive recommendations.
- **Challenges**: Detecting difficulties where accuracy falls below thresholds.

### 4. Presentation
A premium dashboard built with the Soteria Design System:
- **Glassmorphism**: Layered surfaces and subtle borders.
- **Data Visualization**: Smooth line charts, balanced bar charts, and circular progress indicators.
- **Responsive**: Adapts to mobile, tablet, and landscape orientations.

## Domain Models
- `PersonalPerformanceAnalytics`: Root container for all metrics.
- `PerformanceInsight`: Actionable rule-based statements.
- `PerformanceTrend`: Time-series data for charting.
- `CategoryPerformance` / `DifficultyPerformance`: Grouped metrics.

## Performance & Caching
Analytics are cached in-memory within the `PerformanceAnalyticsRepositoryImpl`. The cache is invalidated when filters change or data is refreshed. Aggregation is performed synchronously to ensure UI responsiveness.
