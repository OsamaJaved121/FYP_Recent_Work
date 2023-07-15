import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    // });
      Provider.of<Orders>(context,listen: false).fetchAndSetOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> fut =
        Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
    //final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4C53A5),
        title: Text('Orders'),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            iconSize: 25.0,
          );
        }),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: fut,
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            Center(
              child: Text(dataSnapshot.hasData.toString()),
            );
            if (dataSnapshot.error != null) {
              return Center(
                child: Text(dataSnapshot.error.toString()),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                ),
              );
              // } else {
              //   return Center(
              //     child: Text(dataSnapshot.hasError.toString()),
              //   );
              // }
            }
          }
        },
      ),
    );
  }
}
