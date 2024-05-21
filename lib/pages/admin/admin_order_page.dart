// lib/pages/admin/admin_order_page.dart
import 'package:flutter/material.dart';

class AdminOrderPage extends StatelessWidget {
  final List<Map<String, dynamic>> _orders = [
    {'id': 1, 'status': 'Delivered', 'items': 3, 'total': 120.00},
    {'id': 2, 'status': 'Pending', 'items': 1, 'total': 50.00},
    {'id': 3, 'status': 'Cancelled', 'items': 2, 'total': 80.00},
  ];

  void _changeOrderStatus(BuildContext context, int orderId, String newStatus) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order #$orderId status changed to $newStatus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Management')),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return ListTile(
            title: Text('Order #${order['id']}'),
            subtitle: Text('Status: ${order['status']} | Items: ${order['items']} | Total: \$${order['total']}'),
            trailing: PopupMenuButton<String>(
              onSelected: (value) => _changeOrderStatus(context, order['id'], value),
              itemBuilder: (context) => [
                PopupMenuItem(value: 'Delivered', child: Text('Delivered')),
                PopupMenuItem(value: 'Pending', child: Text('Pending')),
                PopupMenuItem(value: 'Cancelled', child: Text('Cancelled')),
              ],
            ),
          );
        },
      ),
    );
  }
}