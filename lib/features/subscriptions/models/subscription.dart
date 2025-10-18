import 'billing_cycle.dart';

class Subscription {
  final String id;
  final String name;
  final double cost;
  final BillingCycle billingCycle;
  final DateTime createdAt;

  Subscription({
    required this.id,
    required this.name,
    required this.cost,
    required this.billingCycle,
    required this.createdAt,
  });
}

