import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/billing_cycle.dart';

class AddSubscriptionScreen extends StatefulWidget {
  final Function(String name, double cost, BillingCycle cycle, String imageUrl) onSave;

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
  final _imageUrlController = TextEditingController();
  BillingCycle _selectedCycle = BillingCycle.monthly;

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final cost = double.parse(_costController.text);
      final imageUrl = _imageUrlController.text.isEmpty 
          ? 'https://via.placeholder.com/150' 
          : _imageUrlController.text;
      widget.onSave(name, cost, _selectedCycle, imageUrl);
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
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: 'https://cdn-icons-png.flaticon.com/512/1533/1533913.png',
                width: 28,
                height: 28,
                fit: BoxFit.cover,
                placeholder: (context, url) => const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.add_circle),
              ),
            ),
            const SizedBox(width: 12),
            const Text('Новая подписка'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Декоративное изображение
                Center(
                  child: CachedNetworkImage(
                    imageUrl: 'https://cdn-icons-png.flaticon.com/512/3176/3176366.png',
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const SizedBox(
                      width: 120,
                      height: 120,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.add_card,
                      size: 120,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
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
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'URL логотипа (опционально)',
                  border: OutlineInputBorder(),
                  hintText: 'https://logo.clearbit.com/domain.com',
                ),
                keyboardType: TextInputType.url,
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
    ),
    );
  }
}

