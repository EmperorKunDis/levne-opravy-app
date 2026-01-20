import 'package:flutter/material.dart';

enum ServiceCategory {
  montaze,
  instalaterstvi,
  elektro,
  rekonstrukce,
  zahrada,
  ostatni,
}

extension ServiceCategoryExtension on ServiceCategory {
  String get displayName {
    switch (this) {
      case ServiceCategory.montaze:
        return 'Montáže';
      case ServiceCategory.instalaterstvi:
        return 'Instalatérství';
      case ServiceCategory.elektro:
        return 'Elektro';
      case ServiceCategory.rekonstrukce:
        return 'Rekonstrukce';
      case ServiceCategory.zahrada:
        return 'Zahrada';
      case ServiceCategory.ostatni:
        return 'Ostatní';
    }
  }

  IconData get icon {
    switch (this) {
      case ServiceCategory.montaze:
        return Icons.build;
      case ServiceCategory.instalaterstvi:
        return Icons.plumbing;
      case ServiceCategory.elektro:
        return Icons.electrical_services;
      case ServiceCategory.rekonstrukce:
        return Icons.home_repair_service;
      case ServiceCategory.zahrada:
        return Icons.grass;
      case ServiceCategory.ostatni:
        return Icons.handyman;
    }
  }
}

class Service {
  final String id;
  final String name;
  final String description;
  final ServiceCategory category;
  final double priceFrom;
  final double? priceTo;
  final String unit;
  final IconData icon;
  final List<String> features;

  const Service({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.priceFrom,
    this.priceTo,
    required this.unit,
    required this.icon,
    this.features = const [],
  });

  String get priceRange {
    if (priceTo != null) {
      return '${priceFrom.toInt()} - ${priceTo!.toInt()} Kč/$unit';
    }
    return 'od ${priceFrom.toInt()} Kč/$unit';
  }
}
