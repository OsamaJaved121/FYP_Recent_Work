// Flutter package imports:
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/item_page.dart';
import 'package:provider/provider.dart';

// Screen imports:
import './screens/cart_page.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/auth_screen.dart';
//import './screens/item_page.dart';

// Providers imports:
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders('', []),
          update: (context, auth, previousOrders) =>
              Orders(auth.token, previousOrders!.orders),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products('', []),
          update: (context, auth, previousProducts) =>
              Products(auth.token, previousProducts!.items),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Try IT!",
            theme: ThemeData(
              fontFamily: 'Lato',
              primaryColor: Color(0xFF4C53A5),
            ),
            home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartPage.routeName: (ctx) => CartPage(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
              ItemPageScreen.routeName: (ctx) => ItemPageScreen(),
            }),
      ),
    );
  }
}
