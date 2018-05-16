import 'package:flutter/material.dart';
import 'package:flutter_app/StreamDemo/cart_provider.dart';
import 'package:flutter_app/model/cart_item.dart';
class BlocCartPage extends StatelessWidget {
  BlocCartPage();

  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cart = CartProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: StreamBuilder<List<CartItem>>(
          stream: cart.items,
          builder: (context, snapshot) => Text("Cart: ${snapshot.data}")),
    );
  }
}
