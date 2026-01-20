import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../models/milestone.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  String? _selectedMilestoneId;

  List<PhotoRecord> get _filteredPhotos {
    if (_selectedMilestoneId == null) {
      return MockData.photos;
    }
    return MockData.photos.where((p) => p.milestoneId == _selectedMilestoneId).toList();
  }

  Map<String, List<PhotoRecord>> get _photosByDate {
    final grouped = <String, List<PhotoRecord>>{};
    for (final photo in _filteredPhotos) {
      final dateKey = _formatDateKey(photo.takenAt);
      grouped.putIfAbsent(dateKey, () => []).add(photo);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final milestones = MockData.activeOrder.milestones;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Fotodokumentace'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _showFilterSheet(context, milestones);
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          // Milestone filter chips
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _FilterChip(
                    label: 'Vše',
                    isSelected: _selectedMilestoneId == null,
                    onTap: () => setState(() => _selectedMilestoneId = null),
                  ),
                  const SizedBox(width: 8),
                  ...milestones
                      .where((m) =>
                          MockData.photos.any((p) => p.milestoneId == m.id))
                      .map((m) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _FilterChip(
                              label: m.title,
                              isSelected: _selectedMilestoneId == m.id,
                              onTap: () =>
                                  setState(() => _selectedMilestoneId = m.id),
                            ),
                          )),
                ],
              ),
            ),
          ),

          // Photo count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredPhotos.length} fotek',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Stahování všech fotek...'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('Stáhnout vše'),
                ),
              ],
            ),
          ),

          // Photo grid by date
          Expanded(
            child: _filteredPhotos.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _photosByDate.length,
                    itemBuilder: (context, index) {
                      final dateKey = _photosByDate.keys.elementAt(index);
                      final photos = _photosByDate[dateKey]!;
                      return _buildDateSection(dateKey, photos);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 64,
            color: AppColors.textLight,
          ),
          const SizedBox(height: 16),
          const Text(
            'Žádné fotky',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pro tento milník zatím nejsou žádné fotky',
            style: TextStyle(
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(String dateKey, List<PhotoRecord> photos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  dateKey,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${photos.length} fotek',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: photos.length,
          itemBuilder: (context, index) {
            final photo = photos[index];
            return _buildPhotoCard(photo);
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildPhotoCard(PhotoRecord photo) {
    return GestureDetector(
      onTap: () => _showPhotoDetail(context, photo),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Placeholder image
            Container(
              color: AppColors.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    size: 48,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      photo.description ?? 'Fotka',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Gradient overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
                child: Text(
                  _formatTime(photo.takenAt),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPhotoDetail(BuildContext context, PhotoRecord photo) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Photo placeholder
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 80,
                          color: AppColors.textLight,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          photo.description ?? 'Fotka',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Info section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (photo.description != null) ...[
                          Text(
                            photo.description!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: AppColors.textLight,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatFullDate(photo.takenAt),
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Stahování...'),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.download, size: 18),
                                label: const Text('Stáhnout'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Zavřít'),
                              ),
                            ),
                          ],
                        ),
                      ],
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

  void _showFilterSheet(BuildContext context, List<Milestone> milestones) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            const Text(
              'Filtrovat podle milníku',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Radio<String?>(
                value: null,
                groupValue: _selectedMilestoneId,
                onChanged: (value) {
                  setState(() => _selectedMilestoneId = null);
                  Navigator.pop(context);
                },
              ),
              title: const Text('Všechny fotky'),
              onTap: () {
                setState(() => _selectedMilestoneId = null);
                Navigator.pop(context);
              },
            ),
            ...milestones
                .where((m) => MockData.photos.any((p) => p.milestoneId == m.id))
                .map((m) => ListTile(
                      leading: Radio<String?>(
                        value: m.id,
                        groupValue: _selectedMilestoneId,
                        onChanged: (value) {
                          setState(() => _selectedMilestoneId = value);
                          Navigator.pop(context);
                        },
                      ),
                      title: Text(m.title),
                      subtitle: Text(
                        '${MockData.photos.where((p) => p.milestoneId == m.id).length} fotek',
                        style: const TextStyle(fontSize: 12),
                      ),
                      onTap: () {
                        setState(() => _selectedMilestoneId = m.id);
                        Navigator.pop(context);
                      },
                    )),
          ],
        ),
      ),
    );
  }

  String _formatDateKey(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final photoDate = DateTime(date.year, date.month, date.day);

    if (photoDate == today) {
      return 'Dnes';
    } else if (photoDate == today.subtract(const Duration(days: 1))) {
      return 'Včera';
    } else {
      return '${date.day}.${date.month}.${date.year}';
    }
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String _formatFullDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year} v ${_formatTime(date)}';
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
