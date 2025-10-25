import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: 'https://cdn-icons-png.flaticon.com/512/2917/2917995.png',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                placeholder: (context, url) => const SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.subscriptions),
              ),
            ),
            const SizedBox(width: 12),
            const Text('Мои подписки'),
          ],
        ),
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

