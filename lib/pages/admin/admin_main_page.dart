// lib/pages/admin/admin_main_page.dart
import 'package:flutter/material.dart';
import 'admin_product_page.dart';
import 'admin_order_page.dart';
import 'admin_user_page.dart';

class AdminMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Product Management'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminProductPage()),
              );
            },
          ),
          ListTile(
            title: Text('Order Management'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminOrderPage()),
              );
            },
          ),
          ListTile(
            title: Text('User Management'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminUserPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}