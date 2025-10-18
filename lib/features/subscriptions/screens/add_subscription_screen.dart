import 'package:flutter/material.dart';
import '../models/billing_cycle.dart';

class AddSubscriptionScreen extends StatefulWidget {
  final Function(String name, double cost, BillingCycle cycle) onSave;

  const AddSubscriptionScreen({
    super.key,
    required this.onSave,
  });

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _costController = TextEditingController();
  BillingCycle _selectedCycle = BillingCycle.monthly;

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final cost = double.parse(_costController.text);
      widget.onSave(name, cost, _selectedCycle);
    }
  }

  String _getCycleLabel(BillingCycle cycle) {
    switch (cycle) {
      case BillingCycle.monthly:
        return 'Ежемесячно';
      case BillingCycle.yearly:
        return 'Ежегодно';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая подписка'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Название',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите название';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(
                  labelText: 'Стоимость (₽)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите стоимость';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Пожалуйста, введите корректное число';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<BillingCycle>(
                value: _selectedCycle,
                decoration: const InputDecoration(
                  labelText: 'Период оплаты',
                  border: OutlineInputBorder(),
                ),
                items: BillingCycle.values.map((cycle) {
                  return DropdownMenuItem(
                    value: cycle,
                    child: Text(_getCycleLabel(cycle)),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCycle = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _handleSave,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: const Text(
                  'Сохранить',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

