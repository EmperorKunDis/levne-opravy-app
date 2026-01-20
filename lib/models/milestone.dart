import 'package:flutter/material.dart';

enum MilestoneStatus {
  pending,
  inProgress,
  completed,
  skipped,
}

extension MilestoneStatusExtension on MilestoneStatus {
  String get displayName {
    switch (this) {
      case MilestoneStatus.pending:
        return 'Čeká';
      case MilestoneStatus.inProgress:
        return 'Probíhá';
      case MilestoneStatus.completed:
        return 'Dokončeno';
      case MilestoneStatus.skipped:
        return 'Přeskočeno';
    }
  }

  Color get color {
    switch (this) {
      case MilestoneStatus.pending:
        return Colors.grey;
      case MilestoneStatus.inProgress:
        return const Color(0xFFE30613);
      case MilestoneStatus.completed:
        return const Color(0xFF4CAF50);
      case MilestoneStatus.skipped:
        return Colors.orange;
    }
  }

  IconData get icon {
    switch (this) {
      case MilestoneStatus.pending:
        return Icons.radio_button_unchecked;
      case MilestoneStatus.inProgress:
        return Icons.play_circle_outline;
      case MilestoneStatus.completed:
        return Icons.check_circle;
      case MilestoneStatus.skipped:
        return Icons.skip_next;
    }
  }
}

class Milestone {
  final String id;
  final String title;
  final String? description;
  final MilestoneStatus status;
  final DateTime? startDate;
  final DateTime? completedDate;
  final int order;
  final List<String> photoUrls;
  final String? note;

  const Milestone({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    this.startDate,
    this.completedDate,
    required this.order,
    this.photoUrls = const [],
    this.note,
  });

  bool get isCompleted => status == MilestoneStatus.completed;
  bool get isInProgress => status == MilestoneStatus.inProgress;
  bool get isPending => status == MilestoneStatus.pending;
}

class PhotoRecord {
  final String id;
  final String url;
  final String? thumbnailUrl;
  final String? description;
  final DateTime takenAt;
  final String? milestoneId;
  final String orderId;

  const PhotoRecord({
    required this.id,
    required this.url,
    this.thumbnailUrl,
    this.description,
    required this.takenAt,
    this.milestoneId,
    required this.orderId,
  });
}

class Document {
  final String id;
  final String title;
  final String type;
  final String? url;
  final DateTime createdAt;
  final String orderId;

  const Document({
    required this.id,
    required this.title,
    required this.type,
    this.url,
    required this.createdAt,
    required this.orderId,
  });

  IconData get icon {
    switch (type.toLowerCase()) {
      case 'smlouva':
      case 'contract':
        return Icons.description;
      case 'faktura':
      case 'invoice':
        return Icons.receipt_long;
      case 'protokol':
      case 'protocol':
        return Icons.assignment;
      case 'pdf':
        return Icons.picture_as_pdf;
      default:
        return Icons.insert_drive_file;
    }
  }
}
