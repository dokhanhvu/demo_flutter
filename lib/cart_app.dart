import 'package:flutter/material.dart';
import 'package:flutter_app/StreamDemo/bloc_cart_page.dart';
import 'package:flutter_app/StreamDemo/cart_provider.dart';
import 'package:flutter_app/StreamDemo/catalog.dart';
import 'package:flutter_app/StreamDemo/cart_button.dart';
import 'package:flutter_app/StreamDemo/product_square.dart';
import 'package:flutter_app/StreamDemo/cart_bloc.dart';

// cho xu de xuong nhat qua dat
//demo conflict

class CartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CartProvider(
      child: MaterialApp(
        title: 'Bloc',
        theme: ThemeData(
            primaryColor: Colors.white
        ),
        home: MyHomePage(),
        routes: <String, WidgetBuilder>{
          BlocCartPage.routeName: (context) => BlocCartPage()
        },
      ),
    );
  }
}

/// The sample app's main page
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartBloc = CartProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc"),
        actions: <Widget>[
          StreamBuilder<int>(
            stream: cartBloc.itemCount,
            initialData: 0,
            builder: (context, snapshot) => CartButton(
              itemCount: snapshot.data,
              onPressed: () {
                Navigator.of(context).pushNamed(BlocCartPage.routeName);
              },
            ),
          )
        ],
      ),
      body: ProductGrid(),
    );
  }
}

/// Displays a tappable grid of products
class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartBloc = CartProvider.of(context);
    return GridView.count(
      crossAxisCount: 2,
      children: catalog.products.map((product) {
        return ProductSquare(
          product: product,
          onTap: () {
            cartBloc.cartAddition.add(CartAddition(product));
          },
        );
      }).toList(),
    );
  }
}