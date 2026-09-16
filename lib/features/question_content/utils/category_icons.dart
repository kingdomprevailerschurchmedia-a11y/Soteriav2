import 'package:flutter/material.dart';

class CategoryIcons {
  static IconData getIcon(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'security':
        return Icons.security_rounded;
      case 'cloud':
      case 'technology':
        return Icons.cloud_rounded;
      case 'code':
      case 'programming':
        return Icons.code_rounded;
      case 'network':
        return Icons.router_rounded;
      case 'science':
        return Icons.science_rounded;
      case 'business':
        return Icons.business_rounded;
      case 'history':
        return Icons.history_rounded;
      case 'calculate':
      case 'mathematics':
        return Icons.calculate_rounded;
      case 'palette':
      case 'arts':
        return Icons.palette_rounded;
      case 'sports_basketball':
      case 'sports':
        return Icons.sports_basketball_rounded;
      case 'gavel':
      case 'law':
        return Icons.gavel_rounded;
      case 'brush':
      case 'design':
        return Icons.brush_rounded;
      case 'payments':
      case 'finance':
        return Icons.payments_rounded;
      case 'medical_services':
      case 'medicine':
        return Icons.medical_services_rounded;
      case 'public':
      case 'geography':
        return Icons.public_rounded;
      case 'language':
      case 'languages':
        return Icons.language_rounded;
      case 'menu_book':
      case 'literature':
        return Icons.menu_book_rounded;
      case 'psychology':
        return Icons.psychology_rounded;
      case 'engineering':
        return Icons.engineering_rounded;
      case 'newspaper':
      case 'current_affairs':
      case 'current-affairs':
        return Icons.newspaper_rounded;
      case 'category':
      case 'general_knowledge':
      case 'general-knowledge':
        return Icons.category_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  static IconData getIconOutlined(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'security':
        return Icons.security_outlined;
      case 'cloud':
      case 'technology':
        return Icons.cloud_outlined;
      case 'code':
      case 'programming':
        return Icons.code_outlined;
      case 'network':
        return Icons.router_outlined;
      case 'science':
        return Icons.science_outlined;
      case 'business':
        return Icons.business_center_outlined;
      case 'history':
        return Icons.account_balance_outlined;
      case 'calculate':
      case 'mathematics':
        return Icons.calculate_outlined;
      case 'palette':
      case 'arts':
        return Icons.palette_outlined;
      case 'sports_basketball':
      case 'sports':
        return Icons.sports_basketball_outlined;
      case 'gavel':
      case 'law':
        return Icons.gavel_rounded;
      case 'brush':
      case 'design':
        return Icons.brush_outlined;
      case 'payments':
      case 'finance':
        return Icons.payments_outlined;
      case 'medical_services':
      case 'medicine':
        return Icons.medical_services_outlined;
      case 'public':
      case 'geography':
        return Icons.public_outlined;
      case 'language':
      case 'languages':
        return Icons.chat_bubble_outline_rounded;
      case 'menu_book':
      case 'literature':
        return Icons.menu_book_outlined;
      case 'psychology':
        return Icons.psychology_outlined;
      case 'engineering':
        return Icons.settings_outlined;
      case 'newspaper':
      case 'current_affairs':
      case 'current-affairs':
        return Icons.newspaper_outlined;
      case 'category':
      case 'general_knowledge':
      case 'general-knowledge':
        return Icons.category_outlined;
      default:
        return Icons.category_outlined;
    }
  }
}
