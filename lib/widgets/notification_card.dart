import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum NotificationType {
  warning,
  info,
  success,
  error,
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final NotificationType type;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;
  final String? actionLabel;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    this.type = NotificationType.info,
    this.onTap,
    this.onDismiss,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _getBorderColor(),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _getBackgroundColor().withOpacity(0.1),
                _getBackgroundColor().withOpacity(0.05),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _getBackgroundColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getIcon(),
                    color: _getIconColor(),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _getIconColor(),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (actionLabel != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          actionLabel!,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: _getIconColor(),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (onDismiss != null)
                  IconButton(
                    onPressed: onDismiss,
                    icon: const Icon(Icons.close, size: 20),
                    color: AppColors.textLight,
                  )
                else
                  Icon(
                    Icons.chevron_right,
                    color: _getIconColor(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case NotificationType.warning:
        return AppColors.warning;
      case NotificationType.info:
        return AppColors.info;
      case NotificationType.success:
        return AppColors.success;
      case NotificationType.error:
        return AppColors.error;
    }
  }

  Color _getBorderColor() {
    switch (type) {
      case NotificationType.warning:
        return AppColors.warning.withOpacity(0.3);
      case NotificationType.info:
        return AppColors.info.withOpacity(0.3);
      case NotificationType.success:
        return AppColors.success.withOpacity(0.3);
      case NotificationType.error:
        return AppColors.error.withOpacity(0.3);
    }
  }

  Color _getIconColor() {
    switch (type) {
      case NotificationType.warning:
        return AppColors.warning;
      case NotificationType.info:
        return AppColors.info;
      case NotificationType.success:
        return AppColors.success;
      case NotificationType.error:
        return AppColors.error;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case NotificationType.warning:
        return Icons.warning_amber_rounded;
      case NotificationType.info:
        return Icons.info_outline;
      case NotificationType.success:
        return Icons.check_circle_outline;
      case NotificationType.error:
        return Icons.error_outline;
    }
  }
}

class AttentionRequiredCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int count;
  final VoidCallback? onTap;

  const AttentionRequiredCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.count = 1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.warning.withOpacity(0.15),
                AppColors.warning.withOpacity(0.05),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.notification_important,
                        color: AppColors.warning,
                        size: 28,
                      ),
                    ),
                    if (count > 0)
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            count.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.warning,
                    size: 20,
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
