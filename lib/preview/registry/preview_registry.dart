import '../models/preview_item.dart';
import '../models/preview_category.dart';

class PreviewRegistry {
  PreviewRegistry._();
  static final instance = PreviewRegistry._();

  final List<PreviewItem> _items = [];

  List<PreviewItem> get items => List.unmodifiable(_items);

  void registerPreview(PreviewItem item) {
    if (_items.any((i) => i.id == item.id)) {
      return;
    }
    _items.add(item);
  }

  List<PreviewItem> getByCategory(PreviewCategory category) {
    return _items.where((item) => item.category == category).toList();
  }

  List<PreviewItem> search(String query) {
    final q = query.toLowerCase();
    return _items.where((item) {
      return item.title.toLowerCase().contains(q) ||
          item.description.toLowerCase().contains(q) ||
          item.tags.any((t) => t.toLowerCase().contains(q));
    }).toList();
  }
}
