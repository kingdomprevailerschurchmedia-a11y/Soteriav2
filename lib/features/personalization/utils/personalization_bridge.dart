class PersonalizationBridge {
  /// Maps interest labels from onboarding to canonical Category IDs (slugs).
  static String labelToCategoryId(String label) {
    // Current mapping is simply lowercase, but we use a map for robustness.
    final mapping = {
      'Science': 'science',
      'Technology': 'technology',
      'Business': 'business',
      'Medicine': 'medicine',
      'Arts': 'arts',
      'History': 'history',
      'Sports': 'sports',
      'Current Affairs': 'current-affairs',
      'Programming': 'programming',
      'Mathematics': 'mathematics',
      'Engineering': 'engineering',
      'Languages': 'languages',
      'Law': 'law',
      'Finance': 'finance',
      'Psychology': 'psychology',
      'Design': 'design',
    };

    return mapping[label] ?? label.toLowerCase().replaceAll(' ', '-');
  }

  /// Maps canonical Category IDs to readable labels.
  static String categoryIdToLabel(String id) {
    final reverseMapping = {
      'science': 'Science',
      'technology': 'Technology',
      'business': 'Business',
      'medicine': 'Medicine',
      'arts': 'Arts',
      'history': 'History',
      'sports': 'Sports',
      'current-affairs': 'Current Affairs',
      'programming': 'Programming',
      'mathematics': 'Mathematics',
      'engineering': 'Engineering',
      'languages': 'Languages',
      'law': 'Law',
      'finance': 'Finance',
      'psychology': 'Psychology',
      'design': 'Design',
    };

    if (reverseMapping.containsKey(id)) return reverseMapping[id]!;
    
    // Capitalize each word
    return id.split('-').map((s) => s.isEmpty ? '' : '${s[0].toUpperCase()}${s.substring(1)}').join(' ');
  }
}
