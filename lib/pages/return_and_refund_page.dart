// lib/pages/return_and_refund_page.dart
import 'package:flutter/material.dart';

class ReturnAndRefundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Return and Refund')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Return and Refund Policy',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            Text(
              '1. You can request a return or refund within 30 days of purchase.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 8),
            Text(
              '2. To process a return or refund, please contact our customer service team.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 8),
            Text(
              '3. All returned items must be in their original condition.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 8),
            Text(
              '4. Refunds will be processed within 7-10 business days.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Return or Refund request submitted!')),
                );
              },
              child: Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }
}