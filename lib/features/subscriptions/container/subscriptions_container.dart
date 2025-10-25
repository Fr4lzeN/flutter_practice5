import 'package:flutter/material.dart';
import '../models/billing_cycle.dart';
import '../models/subscription.dart';
import '../screens/subscriptions_list_screen.dart';
import '../screens/add_subscription_screen.dart';

enum Screen { list, form }

class SubscriptionsContainer extends StatefulWidget {
  const SubscriptionsContainer({super.key});

  @override
  State<SubscriptionsContainer> createState() => _SubscriptionsContainerState();
}

class _SubscriptionsContainerState extends State<SubscriptionsContainer> {
  Screen _currentScreen = Screen.list;
  List<Subscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    // Начальные данные для демонстрации
    _subscriptions = [
      Subscription(
        id: '1',
        name: 'Netflix',
        cost: 799.0,
        billingCycle: BillingCycle.monthly,
        createdAt: DateTime.now(),
        imageUrl: 'https://logo.clearbit.com/netflix.com',
      ),
      Subscription(
        id: '2',
        name: 'Yandex Plus',
        cost: 299.0,
        billingCycle: BillingCycle.monthly,
        createdAt: DateTime.now(),
        imageUrl: 'https://logo.clearbit.com/plus.yandex.ru',
      ),
      Subscription(
        id: '3',
        name: 'Office 365',
        cost: 4399.0,
        billingCycle: BillingCycle.yearly,
        createdAt: DateTime.now(),
        imageUrl: 'https://logo.clearbit.com/office.com',
      ),
      Subscription(
        id: '4',
        name: 'Spotify',
        cost: 169.0,
        billingCycle: BillingCycle.monthly,
        createdAt: DateTime.now(),
        imageUrl: 'https://logo.clearbit.com/spotify.com',
      ),
      Subscription(
        id: '5',
        name: 'YouTube Premium',
        cost: 299.0,
        billingCycle: BillingCycle.monthly,
        createdAt: DateTime.now(),
        imageUrl: 'https://logo.clearbit.com/youtube.com',
      ),
      Subscription(
        id: '6',
        name: 'Apple Music',
        cost: 199.0,
        billingCycle: BillingCycle.monthly,
        createdAt: DateTime.now(),
        imageUrl: 'https://logo.clearbit.com/apple.com',
      ),
      Subscription(
        id: '7',
        name: 'Discord Nitro',
        cost: 599.0,
        billingCycle: BillingCycle.monthly,
        createdAt: DateTime.now(),
        imageUrl: 'https://logo.clearbit.com/discord.com',
      ),
      Subscription(
        id: '8',
        name: 'Adobe Creative Cloud',
        cost: 2990.0,
        billingCycle: BillingCycle.monthly,
        createdAt: DateTime.now(),
        imageUrl: 'https://logo.clearbit.com/adobe.com',
      ),
    ];
  }

  void _showForm() {
    setState(() {
      _currentScreen = Screen.form;
    });
  }

  void _showList() {
    setState(() {
      _currentScreen = Screen.list;
    });
  }

  void _addSubscription(String name, double cost, BillingCycle cycle, String imageUrl) {
    final newSubscription = Subscription(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      cost: cost,
      billingCycle: cycle,
      createdAt: DateTime.now(),
      imageUrl: imageUrl,
    );

    setState(() {
      _subscriptions.add(newSubscription);
      _currentScreen = Screen.list;
    });
  }

  void _deleteSubscription(String id) {
    final index = _subscriptions.indexWhere((sub) => sub.id == id);
    if (index == -1) return;

    final deletedSubscription = _subscriptions[index];

    setState(() {
      _subscriptions.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${deletedSubscription.name} удалена'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () {
            setState(() {
              _subscriptions.insert(index, deletedSubscription);
            });
          },
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  double _calculateTotalMonthlyCost() {
    double total = 0.0;
    for (final subscription in _subscriptions) {
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
    Widget body;

    switch (_currentScreen) {
      case Screen.list:
        body = SubscriptionsListScreen(
          subscriptions: _subscriptions,
          totalMonthlyCost: _calculateTotalMonthlyCost(),
          onAdd: _showForm,
          onDelete: _deleteSubscription,
        );
        break;
      case Screen.form:
        body = AddSubscriptionScreen(
          onSave: _addSubscription,
        );
        break;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: body,
    );
  }
}

