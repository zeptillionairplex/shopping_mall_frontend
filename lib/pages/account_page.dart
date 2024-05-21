// lib/pages/account_page.dart
import 'package:flutter/material.dart';
import 'order_confirmation_page.dart';
import 'return_and_refund_page.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Order and Delivery Confirmation'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderConfirmationPage()),
              );
            },
          ),
          ListTile(
            title: Text('Return and Refund'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReturnAndRefundPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}