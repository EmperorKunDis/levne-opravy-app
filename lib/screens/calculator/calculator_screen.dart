import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String? _selectedWorkType;
  String _selectedQuality = 'Standard';
  double _area = 10;
  bool _includeDemolition = false;
  bool _includeMaterials = false;
  bool _includeCleanup = true;

  double get _estimatedPriceMin {
    if (_selectedWorkType == null) return 0;
    final basePrice = MockData.priceMatrix[_selectedWorkType]?[_selectedQuality] ?? 0;
    double total = basePrice * _area;

    if (_includeDemolition) total += _area * 200;
    if (_includeMaterials) total += _area * 500;
    if (_includeCleanup) total += 1500;

    return total * 0.9; // 10% lower bound
  }

  double get _estimatedPriceMax {
    if (_selectedWorkType == null) return 0;
    final basePrice = MockData.priceMatrix[_selectedWorkType]?[_selectedQuality] ?? 0;
    double total = basePrice * _area;

    if (_includeDemolition) total += _area * 200;
    if (_includeMaterials) total += _area * 500;
    if (_includeCleanup) total += 1500;

    return total * 1.1; // 10% upper bound
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Kalkulátor ceny'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppColors.primary,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Orientační kalkulace. Konečná cena bude stanovena po zaměření.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Work type selection
                  _buildSectionTitle('Typ práce'),
                  const SizedBox(height: 12),
                  _buildWorkTypeSelector(),

                  const SizedBox(height: 24),

                  // Area input
                  _buildSectionTitle('Plocha (m²)'),
                  const SizedBox(height: 12),
                  _buildAreaInput(),

                  const SizedBox(height: 24),

                  // Quality selection
                  _buildSectionTitle('Kvalita provedení'),
                  const SizedBox(height: 12),
                  _buildQualitySelector(),

                  const SizedBox(height: 24),

                  // Additional options
                  _buildSectionTitle('Doplňkové služby'),
                  const SizedBox(height: 12),
                  _buildAdditionalOptions(),

                  const SizedBox(height: 32),

                  // Price result
                  _buildPriceResult(),

                  const SizedBox(height: 24),

                  // Action buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _selectedWorkType != null
                          ? () {
                              _showQuoteRequestDialog(context);
                            }
                          : null,
                      child: const Text('Nezávazná poptávka'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _selectedWorkType = null;
                          _selectedQuality = 'Standard';
                          _area = 10;
                          _includeDemolition = false;
                          _includeMaterials = false;
                          _includeCleanup = true;
                        });
                      },
                      child: const Text('Vymazat vše'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildWorkTypeSelector() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: MockData.workTypes.map((type) {
            final isSelected = _selectedWorkType == type;
            return InkWell(
              onTap: () => setState(() => _selectedWorkType = type),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withOpacity(0.1) : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                      color: isSelected ? AppColors.primary : AppColors.textLight,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 15,
                        color: isSelected ? AppColors.primary : AppColors.textPrimary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAreaInput() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _area > 1
                      ? () => setState(() => _area = (_area - 1).clamp(1, 500))
                      : null,
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.remove, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 100,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${_area.toInt()} m²',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: _area < 500
                      ? () => setState(() => _area = (_area + 1).clamp(1, 500))
                      : null,
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.add, color: AppColors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Slider(
              value: _area,
              min: 1,
              max: 500,
              divisions: 499,
              activeColor: AppColors.primary,
              onChanged: (value) => setState(() => _area = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQualitySelector() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: MockData.qualityLevels.map((quality) {
            final isSelected = _selectedQuality == quality;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: InkWell(
                  onTap: () => setState(() => _selectedQuality = quality),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.background,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          quality == 'Premium' ? Icons.star : Icons.star_border,
                          color: isSelected ? Colors.white : AppColors.textLight,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          quality,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          quality == 'Premium' ? 'Prémiové materiály' : 'Standardní materiály',
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected ? Colors.white70 : AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAdditionalOptions() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildOptionTile(
            'Bourání a demolice',
            'Odstranění staré konstrukce',
            _includeDemolition,
            (value) => setState(() => _includeDemolition = value),
          ),
          const Divider(height: 1),
          _buildOptionTile(
            'Dodávka materiálu',
            'Nákup a dovoz materiálu',
            _includeMaterials,
            (value) => setState(() => _includeMaterials = value),
          ),
          const Divider(height: 1),
          _buildOptionTile(
            'Úklid po práci',
            'Odvoz odpadu a úklid',
            _includeCleanup,
            (value) => setState(() => _includeCleanup = value),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          color: AppColors.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.textLight,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildPriceResult() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Orientační cena',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            if (_selectedWorkType != null) ...[
              Text(
                '${_formatPrice(_estimatedPriceMin)} - ${_formatPrice(_estimatedPriceMax)} Kč',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_area.toInt()} m² • $_selectedQuality',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ] else
              const Text(
                'Vyberte typ práce',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]} ',
        );
  }

  void _showQuoteRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Nezávazná poptávka'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Pro přesnou kalkulaci vás budeme kontaktovat a domluvíme nezávazné zaměření.',
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildSummaryRow('Typ práce:', _selectedWorkType ?? ''),
                  _buildSummaryRow('Plocha:', '${_area.toInt()} m²'),
                  _buildSummaryRow('Kvalita:', _selectedQuality),
                  _buildSummaryRow(
                    'Odhad ceny:',
                    '${_formatPrice(_estimatedPriceMin)} - ${_formatPrice(_estimatedPriceMax)} Kč',
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Zrušit'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Poptávka byla odeslána'),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Odeslat'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
