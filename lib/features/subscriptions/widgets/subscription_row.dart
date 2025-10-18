import 'package:flutter/material.dart';
import '../models/subscription.dart';
import '../models/billing_cycle.dart';

class SubscriptionRow extends StatelessWidget {
  final Subscription subscription;
  final ValueChanged<String> onDelete;

  const SubscriptionRow({
    super.key,
    required this.subscription,
    required this.onDelete,
  });

  String _getBillingCycleText(BillingCycle cycle) {
    switch (cycle) {
      case BillingCycle.monthly:
        return 'мес.';
      case BillingCycle.yearly:
        return 'год';
    }
  }

  double _getMonthlyCost(Subscription subscription) {
    if (subscription.billingCycle == BillingCycle.yearly) {
      return subscription.cost / 12;
    }
    return subscription.cost;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(subscription.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(subscription.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 32,
        ),
      ),
      child: ListTile(
        leading: const Icon(Icons.credit_card),
        title: Text(subscription.name),
        subtitle: Text(
          '${subscription.cost.toStringAsFixed(2)} ₽ / ${_getBillingCycleText(subscription.billingCycle)}',
        ),
        trailing: Text(
          '${_getMonthlyCost(subscription).toStringAsFixed(2)} ₽/мес.',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

