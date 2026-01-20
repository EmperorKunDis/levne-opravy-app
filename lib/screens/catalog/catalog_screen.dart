import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/service.dart';
import '../../data/mock_data.dart';
import '../../widgets/service_card.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final TextEditingController _searchController = TextEditingController();
  ServiceCategory? _selectedCategory;
  String _searchQuery = '';
  bool _showCategories = true;

  List<Service> get _filteredServices {
    var services = MockData.services;

    if (_selectedCategory != null) {
      services = services.where((s) => s.category == _selectedCategory).toList();
    }

    if (_searchQuery.isNotEmpty) {
      services = services
          .where((s) =>
              s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              s.description.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return services;
  }

  Map<ServiceCategory, int> get _categoryServiceCounts {
    final counts = <ServiceCategory, int>{};
    for (final category in ServiceCategory.values) {
      counts[category] = MockData.services.where((s) => s.category == category).length;
    }
    return counts;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Katalog služeb'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            color: AppColors.primary,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                    if (value.isNotEmpty) {
                      _showCategories = false;
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Hledat služby...',
                  prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                              _showCategories = true;
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),

          // Category filter chips
          if (_selectedCategory != null || !_showCategories)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  if (_selectedCategory != null)
                    Chip(
                      label: Text(_selectedCategory!.displayName),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () {
                        setState(() {
                          _selectedCategory = null;
                          _showCategories = true;
                        });
                      },
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      labelStyle: const TextStyle(color: AppColors.primary),
                    ),
                  if (_selectedCategory != null) const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedCategory = null;
                        _showCategories = true;
                      });
                    },
                    icon: const Icon(Icons.grid_view, size: 18),
                    label: const Text('Kategorie'),
                  ),
                ],
              ),
            ),

          // Content
          Expanded(
            child: _showCategories && _searchQuery.isEmpty
                ? _buildCategoriesGrid()
                : _buildServicesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    final categories = ServiceCategory.values;
    final counts = _categoryServiceCounts;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryCard(
            category: category,
            serviceCount: counts[category] ?? 0,
            onTap: () {
              setState(() {
                _selectedCategory = category;
                _showCategories = false;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildServicesList() {
    final services = _filteredServices;

    if (services.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.textLight,
            ),
            const SizedBox(height: 16),
            Text(
              'Žádné služby nenalezeny',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                  _selectedCategory = null;
                  _showCategories = true;
                });
              },
              child: const Text('Zobrazit všechny kategorie'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ServiceCard(
            service: service,
            onTap: () {
              _showServiceDetail(context, service);
            },
          ),
        );
      },
    );
  }

  void _showServiceDetail(BuildContext context, Service service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        service.icon,
                        color: AppColors.primary,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              service.category.displayName,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  service.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Co je zahrnuto:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                ...service.features.map(
                  (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          feature,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Orientační cena:',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        service.priceRange,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/calculator');
                    },
                    child: const Text('Kalkulace ceny'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Kontaktujte nás pro více informací'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: const Text('Nezávazná poptávka'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
