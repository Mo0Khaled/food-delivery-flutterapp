import 'package:delivery_food/providers/order_provider.dart';
import 'package:delivery_food/widgets/order/order_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeId = '/order-screen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: orderProvider.fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasError ) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return Consumer<OrderProvider>(
              builder:(context,order,_) => ListView.builder(
                itemCount: order.orders.length,
                itemBuilder: (context, index) => OrderItemWidget(order.orders[index]),
              ),
            );
        },
      ),
    );
  }
}
