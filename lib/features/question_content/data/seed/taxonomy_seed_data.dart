import '../../domain/entities/category.dart';
import '../../domain/entities/subcategory.dart';
import '../../domain/entities/topic.dart';

class TaxonomySeedData {
  static final List<Category> categories = [
    Category(
      id: 'general_knowledge',
      name: 'General Knowledge',
      description: 'Test your broad knowledge across various subjects.',
      slug: 'general-knowledge',
      icon: 'brain',
      displayOrder: 1,
      featured: true,
    ),
    Category(
      id: 'mathematics',
      name: 'Mathematics',
      description: 'From basic arithmetic to advanced calculus.',
      slug: 'mathematics',
      icon: 'calculate',
      displayOrder: 2,
    ),
    Category(
      id: 'science',
      name: 'Science',
      description: 'Explore the wonders of biology, chemistry, and physics.',
      slug: 'science',
      icon: 'science',
      displayOrder: 3,
      featured: true,
    ),
    Category(
      id: 'technology',
      name: 'Technology',
      description: 'Computing, gadgets, and the digital world.',
      slug: 'technology',
      icon: 'computer',
      displayOrder: 4,
    ),
    Category(
      id: 'history',
      name: 'History',
      description: 'Travel back in time and learn about our past.',
      slug: 'history',
      icon: 'history',
      displayOrder: 5,
    ),
    Category(
      id: 'geography',
      name: 'Geography',
      description: 'Continents, countries, and the features of Earth.',
      slug: 'geography',
      icon: 'public',
      displayOrder: 6,
    ),
    Category(
      id: 'business',
      name: 'Business',
      description: 'Economics, finance, and the corporate world.',
      slug: 'business',
      icon: 'business',
      displayOrder: 7,
    ),
    Category(
      id: 'literature',
      name: 'Literature',
      description: 'Books, authors, and literary masterpieces.',
      slug: 'literature',
      icon: 'menu_book',
      displayOrder: 8,
    ),
    Category(
      id: 'sports',
      name: 'Sports',
      description: 'Games, athletes, and sporting history.',
      slug: 'sports',
      icon: 'sports_basketball',
      displayOrder: 9,
    ),
    Category(
      id: 'current_affairs',
      name: 'Current Affairs',
      description: 'Stay updated with what\'s happening in the world today.',
      slug: 'current-affairs',
      icon: 'newspaper',
      displayOrder: 10,
    ),
  ];

  static final List<Subcategory> subcategories = [
    Subcategory(
      id: 'biology',
      categoryId: 'science',
      name: 'Biology',
      description: 'The study of living organisms.',
      slug: 'biology',
      displayOrder: 1,
    ),
    Subcategory(
      id: 'chemistry',
      categoryId: 'science',
      name: 'Chemistry',
      description: 'The study of matter and its properties.',
      slug: 'chemistry',
      displayOrder: 2,
    ),
    Subcategory(
      id: 'physics',
      categoryId: 'science',
      name: 'Physics',
      description: 'The study of energy and matter.',
      slug: 'physics',
      displayOrder: 3,
    ),
  ];

  static final List<Topic> topics = [
    Topic(
      id: 'genetics',
      subcategoryId: 'biology',
      name: 'Genetics',
      description: 'DNA, inheritance, and genes.',
      slug: 'genetics',
      displayOrder: 1,
    ),
    Topic(
      id: 'ecology',
      subcategoryId: 'biology',
      name: 'Ecology',
      description: 'Organisms and their environments.',
      slug: 'ecology',
      displayOrder: 2,
    ),
    Topic(
      id: 'organic_chemistry',
      subcategoryId: 'chemistry',
      name: 'Organic Chemistry',
      description: 'Carbon-based compounds.',
      slug: 'organic-chemistry',
      displayOrder: 1,
    ),
  ];
}
