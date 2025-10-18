import 'package:flutter/material.dart';
import '../models/subscription.dart';
import '../widgets/subscriptions_table.dart';

class SubscriptionsListScreen extends StatelessWidget {
  final List<Subscription> subscriptions;
  final double totalMonthlyCost;
  final VoidCallback onAdd;
  final ValueChanged<String> onDelete;

  const SubscriptionsListScreen({
    super.key,
    required this.subscriptions,
    required this.totalMonthlyCost,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои подписки'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Итого в месяц: ${totalMonthlyCost.toStringAsFixed(2)} ₽',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SubscriptionsTable(
        subscriptions: subscriptions,
        onDelete: onDelete,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}

