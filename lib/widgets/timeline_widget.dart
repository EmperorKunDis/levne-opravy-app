import 'package:flutter/material.dart';
import '../models/milestone.dart';
import '../theme/app_theme.dart';

class TimelineWidget extends StatelessWidget {
  final List<Milestone> milestones;
  final Function(Milestone)? onMilestoneTap;

  const TimelineWidget({
    super.key,
    required this.milestones,
    this.onMilestoneTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(milestones.length, (index) {
        final milestone = milestones[index];
        final isLast = index == milestones.length - 1;

        return _TimelineItem(
          milestone: milestone,
          isLast: isLast,
          onTap: onMilestoneTap != null ? () => onMilestoneTap!(milestone) : null,
        );
      }),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final Milestone milestone;
  final bool isLast;
  final VoidCallback? onTap;

  const _TimelineItem({
    required this.milestone,
    required this.isLast,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline indicator column
            SizedBox(
              width: 40,
              child: Column(
                children: [
                  _StatusIndicator(status: milestone.status),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: milestone.isCompleted
                            ? AppColors.timelineCompleted
                            : AppColors.timelinePending,
                      ),
                    ),
                ],
              ),
            ),
            // Content column
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (milestone.isInProgress)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Probíhá',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            milestone.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: milestone.isInProgress
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: milestone.isPending
                                  ? AppColors.textLight
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (milestone.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        milestone.description!,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                    if (milestone.completedDate != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 14,
                            color: AppColors.success,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDate(milestone.completedDate!),
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year}';
  }
}

class _StatusIndicator extends StatelessWidget {
  final MilestoneStatus status;

  const _StatusIndicator({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getBackgroundColor(),
        border: Border.all(
          color: _getBorderColor(),
          width: 2,
        ),
      ),
      child: Icon(
        _getIcon(),
        size: 14,
        color: _getIconColor(),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (status) {
      case MilestoneStatus.completed:
        return AppColors.timelineCompleted;
      case MilestoneStatus.inProgress:
        return Colors.white;
      case MilestoneStatus.pending:
        return Colors.white;
      case MilestoneStatus.skipped:
        return Colors.orange.withOpacity(0.2);
    }
  }

  Color _getBorderColor() {
    switch (status) {
      case MilestoneStatus.completed:
        return AppColors.timelineCompleted;
      case MilestoneStatus.inProgress:
        return AppColors.timelineActive;
      case MilestoneStatus.pending:
        return AppColors.timelinePending;
      case MilestoneStatus.skipped:
        return Colors.orange;
    }
  }

  Color _getIconColor() {
    switch (status) {
      case MilestoneStatus.completed:
        return Colors.white;
      case MilestoneStatus.inProgress:
        return AppColors.timelineActive;
      case MilestoneStatus.pending:
        return AppColors.timelinePending;
      case MilestoneStatus.skipped:
        return Colors.orange;
    }
  }

  IconData _getIcon() {
    switch (status) {
      case MilestoneStatus.completed:
        return Icons.check;
      case MilestoneStatus.inProgress:
        return Icons.more_horiz;
      case MilestoneStatus.pending:
        return Icons.circle;
      case MilestoneStatus.skipped:
        return Icons.skip_next;
    }
  }
}

class CompactTimelineWidget extends StatelessWidget {
  final List<Milestone> milestones;
  final Milestone? currentMilestone;
  final Milestone? nextMilestone;

  const CompactTimelineWidget({
    super.key,
    required this.milestones,
    this.currentMilestone,
    this.nextMilestone,
  });

  @override
  Widget build(BuildContext context) {
    final completedCount =
        milestones.where((m) => m.status == MilestoneStatus.completed).length;
    final progress = milestones.isNotEmpty ? completedCount / milestones.length : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress bar
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: AppColors.divider,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '$completedCount/${milestones.length}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Current milestone
        if (currentMilestone != null)
          _CompactMilestoneItem(
            label: 'Probíhá',
            title: currentMilestone!.title,
            color: AppColors.primary,
            icon: Icons.play_circle_filled,
          ),
        if (currentMilestone != null && nextMilestone != null)
          const SizedBox(height: 12),
        // Next milestone
        if (nextMilestone != null)
          _CompactMilestoneItem(
            label: 'Další krok',
            title: nextMilestone!.title,
            color: AppColors.textLight,
            icon: Icons.arrow_forward_ios,
          ),
      ],
    );
  }
}

class _CompactMilestoneItem extends StatelessWidget {
  final String label;
  final String title;
  final Color color;
  final IconData icon;

  const _CompactMilestoneItem({
    required this.label,
    required this.title,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textLight,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color == AppColors.textLight ? AppColors.textSecondary : color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
