// lib/pages/cart_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'payment_page.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.items.isEmpty) {
            return Center(child: Text('Your cart is empty!'));
          }

          return ListView.builder(
            itemCount: cartProvider.items.length,
            itemBuilder: (context, index) {
              final item = cartProvider.items[index];
              final TextEditingController quantityController =
                  TextEditingController(text: item.quantity.toString());

              return ListTile(
                title: Text(item.product.name),
                subtitle: Text(
                    '\$${(item.product.price * item.quantity).toStringAsFixed(2)}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildQuantityButton(
                      icon: Icons.remove,
                      onPressed: () {
                        final newQuantity = item.quantity - 1;
                        cartProvider.updateQuantity(item.product.id!,
                            newQuantity > 0 ? newQuantity : 1);
                        quantityController.text = newQuantity.toString();
                      },
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 6.0),
                        ),
                        onChanged: (value) {
                          final newQuantity = int.tryParse(value) ?? 1;
                          cartProvider.updateQuantity(item.product.id!,
                              newQuantity > 0 ? newQuantity : 1);
                        },
                      ),
                    ),
                    _buildQuantityButton(
                      icon: Icons.add,
                      onPressed: () {
                        final newQuantity = item.quantity + 1;
                        cartProvider.updateQuantity(
                            item.product.id!, newQuantity);
                        quantityController.text = newQuantity.toString();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_shopping_cart),
                      onPressed: () =>
                          cartProvider.removeFromCart(item.product.id!),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentPage()),
                );
              },
              child: Text(
                  'Proceed to Payment (\$${cartProvider.totalPrice.toStringAsFixed(2)})'),
            ),
          );
        },
      ),
    );
  }

  /// 수량 변경 버튼 생성 함수
  Widget _buildQuantityButton(
      {required IconData icon, required void Function() onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
