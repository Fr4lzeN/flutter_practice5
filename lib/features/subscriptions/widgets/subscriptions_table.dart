import 'package:flutter/material.dart';
import '../models/subscription.dart';
import '../models/billing_cycle.dart';
import 'subscription_row.dart';

class SubscriptionsTable extends StatelessWidget {
  final List<Subscription> subscriptions;
  final ValueChanged<String> onDelete;

  const SubscriptionsTable({
    super.key,
    required this.subscriptions,
    required this.onDelete,
  });

  double _calculateTotalMonthlyCost() {
    double total = 0.0;
    for (final subscription in subscriptions) {
      if (subscription.billingCycle == BillingCycle.yearly) {
        total += subscription.cost / 12;
      } else {
        total += subscription.cost;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    if (subscriptions.isEmpty) {
      return const Center(
        child: Text('У вас пока нет подписок.'),
      );
    }

    return ListView.builder(
      itemCount: subscriptions.length + 1, // +1 для итоговой карточки
      itemBuilder: (context, index) {
        if (index < subscriptions.length) {
          return SubscriptionRow(
            subscription: subscriptions[index],
            onDelete: onDelete,
          );
        } else {
          // Итоговая карточка в конце списка
          return Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Всего подписок',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${subscriptions.length} шт.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer
                            .withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Итого в месяц',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_calculateTotalMonthlyCost().toStringAsFixed(2)} ₽',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

