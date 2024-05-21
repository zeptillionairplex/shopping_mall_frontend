// lib/pages/admin/admin_user_page.dart
import 'package:flutter/material.dart';

class AdminUserPage extends StatelessWidget {
  final List<Map<String, dynamic>> _users = [
    {'id': 1, 'name': 'Admin User', 'role': 'Admin'},
    {'id': 2, 'name': 'Regular User', 'role': 'Customer'},
  ];

  void _changeUserRole(BuildContext context, int userId, String newRole) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User #$userId role changed to $newRole')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Management')),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user['name']),
            subtitle: Text('Role: ${user['role']}'),
            trailing: PopupMenuButton<String>(
              onSelected: (value) => _changeUserRole(context, user['id'], value),
              itemBuilder: (context) => [
                PopupMenuItem(value: 'Admin', child: Text('Admin')),
                PopupMenuItem(value: 'Customer', child: Text('Customer')),
                PopupMenuItem(value: 'Moderator', child: Text('Moderator')),
              ],
            ),
          );
        },
      ),
    );
  }
}