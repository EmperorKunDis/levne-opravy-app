import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';

class ExtraWorkScreen extends StatefulWidget {
  const ExtraWorkScreen({super.key});

  @override
  State<ExtraWorkScreen> createState() => _ExtraWorkScreenState();
}

class _ExtraWorkScreenState extends State<ExtraWorkScreen> {
  bool _isApproved = false;

  @override
  Widget build(BuildContext context) {
    final extraWork = MockData.pendingExtraWork;
    final priceDiff = extraWork.priceDifference;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Schválení víceprací'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warning header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: AppColors.warning.withOpacity(0.1),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.warning_amber_rounded,
                      color: AppColors.warning,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Vyžaduje vaše schválení',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.warning,
                          ),
                        ),
                        Text(
                          'Před pokračováním je nutné schválit změnu',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.edit_note,
                                  color: AppColors.primary,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      extraWork.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _formatDate(extraWork.createdAt),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textLight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Description card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Popis změny',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            extraWork.description,
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.textSecondary,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Photo evidence
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Fotodokumentace',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            height: 180,
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.divider),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.photo_library_outlined,
                                  size: 48,
                                  color: AppColors.textLight,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Stav rozvodů - nutná výměna',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/photos');
                                  },
                                  child: const Text('Zobrazit fotky'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Price comparison card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Změna ceny',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: _buildPriceColumn(
                                  'Původní cena',
                                  extraWork.originalPrice,
                                  AppColors.textSecondary,
                                  Icons.remove_circle_outline,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.textLight,
                                  size: 20,
                                ),
                              ),
                              Expanded(
                                child: _buildPriceColumn(
                                  'Nová cena',
                                  extraWork.newPrice,
                                  AppColors.primary,
                                  Icons.add_circle_outline,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: priceDiff > 0
                                  ? AppColors.error.withOpacity(0.1)
                                  : AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: priceDiff > 0
                                    ? AppColors.error.withOpacity(0.3)
                                    : AppColors.success.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  priceDiff > 0
                                      ? Icons.trending_up
                                      : Icons.trending_down,
                                  color: priceDiff > 0
                                      ? AppColors.error
                                      : AppColors.success,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  priceDiff > 0
                                      ? '+${_formatPrice(priceDiff)} Kč'
                                      : '${_formatPrice(priceDiff)} Kč',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: priceDiff > 0
                                        ? AppColors.error
                                        : AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Agreement checkbox
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CheckboxListTile(
                      value: _isApproved,
                      onChanged: (value) {
                        setState(() => _isApproved = value ?? false);
                      },
                      title: const Text(
                        'Souhlasím se změnou',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: const Text(
                        'Schvaluji navýšení ceny a pokračování prací',
                        style: TextStyle(fontSize: 13),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Action buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isApproved
                          ? () => _showApprovalConfirmation(context, extraWork)
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: AppColors.success,
                      ),
                      child: Text(
                        'Závazně schválit změnu (+${_formatPrice(priceDiff)} Kč)',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        _showRejectDialog(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                      ),
                      child: const Text(
                        'Odmítnout změnu',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Voláme...'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: const Text('Potřebuji poradit - zavolejte mi'),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceColumn(
    String label,
    double price,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textLight,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${_formatPrice(price)} Kč',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  void _showApprovalConfirmation(BuildContext context, extraWork) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppColors.success,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Potvrdit schválení'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Opravdu chcete schválit tuto změnu?',
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
                  _buildConfirmRow('Změna:', extraWork.title),
                  _buildConfirmRow(
                    'Navýšení:',
                    '+${_formatPrice(extraWork.priceDifference)} Kč',
                  ),
                  _buildConfirmRow(
                    'Nová celková cena:',
                    '${_formatPrice(extraWork.newPrice)} Kč',
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
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Změna byla schválena'),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
            ),
            child: const Text('Schválit'),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.cancel,
                color: AppColors.error,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Odmítnout změnu'),
          ],
        ),
        content: const Text(
          'Pokud změnu odmítnete, budeme vás kontaktovat pro další postup. '
          'Práce budou pozastaveny do vyřešení situace.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Zpět'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Změna byla odmítnuta. Budeme vás kontaktovat.'),
                  backgroundColor: AppColors.warning,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Odmítnout'),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]} ',
        );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}
