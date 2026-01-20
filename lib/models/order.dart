import 'milestone.dart';

enum OrderStatus {
  draft,
  confirmed,
  inProgress,
  completed,
  cancelled,
}

extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.draft:
        return 'Návrh';
      case OrderStatus.confirmed:
        return 'Potvrzeno';
      case OrderStatus.inProgress:
        return 'Probíhá';
      case OrderStatus.completed:
        return 'Dokončeno';
      case OrderStatus.cancelled:
        return 'Zrušeno';
    }
  }
}

class Order {
  final String id;
  final String title;
  final String description;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? startDate;
  final DateTime? estimatedEndDate;
  final double totalPrice;
  final double? paidAmount;
  final List<Milestone> milestones;
  final String? address;
  final String? clientName;
  final int pendingExtraWorks;

  const Order({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    this.startDate,
    this.estimatedEndDate,
    required this.totalPrice,
    this.paidAmount,
    this.milestones = const [],
    this.address,
    this.clientName,
    this.pendingExtraWorks = 0,
  });

  double get progressPercentage {
    if (milestones.isEmpty) return 0;
    final completed = milestones.where((m) => m.status == MilestoneStatus.completed).length;
    return completed / milestones.length;
  }

  Milestone? get currentMilestone {
    try {
      return milestones.firstWhere((m) => m.status == MilestoneStatus.inProgress);
    } catch (_) {
      return null;
    }
  }

  Milestone? get nextMilestone {
    try {
      return milestones.firstWhere((m) => m.status == MilestoneStatus.pending);
    } catch (_) {
      return null;
    }
  }
}

class ExtraWork {
  final String id;
  final String orderId;
  final String title;
  final String description;
  final double originalPrice;
  final double newPrice;
  final String? imageUrl;
  final DateTime createdAt;
  final bool isApproved;

  const ExtraWork({
    required this.id,
    required this.orderId,
    required this.title,
    required this.description,
    required this.originalPrice,
    required this.newPrice,
    this.imageUrl,
    required this.createdAt,
    this.isApproved = false,
  });

  double get priceDifference => newPrice - originalPrice;
}
