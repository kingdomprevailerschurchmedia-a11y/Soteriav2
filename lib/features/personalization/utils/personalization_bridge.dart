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
      'Current Affairs': 'current_affairs',
      'General Knowledge': 'general_knowledge',
      'Programming': 'programming',
      'Mathematics': 'mathematics',
      'Engineering': 'engineering',
      'Languages': 'languages',
      'Law': 'law',
      'Finance': 'finance',
      'Psychology': 'psychology',
      'Design': 'design',
    };

    return mapping[label] ?? label.toLowerCase().replaceAll(' ', '_');
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
      'current_affairs': 'Current Affairs',
      'current-affairs': 'Current Affairs', // Legacy support
      'general_knowledge': 'General Knowledge',
      'general-knowledge': 'General Knowledge', // Legacy support
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
    return id.split('_').map((s) => s.isEmpty ? '' : '${s[0].toUpperCase()}${s.substring(1)}').join(' ');
  }

  /// Normalizes legacy Category IDs to canonical ones.
  static String normalizeCategoryId(String id) {
    if (id == 'current-affairs') return 'current_affairs';
    if (id == 'general-knowledge') return 'general_knowledge';
    return id;
  }
}
