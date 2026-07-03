import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderProvider>().fetchMyOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lịch sử đơn hàng')),
      body: Consumer<OrderProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading)
            return const Center(child: CircularProgressIndicator());
          if (provider.orders.isEmpty)
            return const Center(child: Text('Chưa có đơn hàng nào'));

          return ListView.builder(
            itemCount: provider.orders.length,
            itemBuilder: (context, index) {
              final order = provider.orders[index];
              return ListTile(
                title: Text('Đơn hàng #${order.id}'),
                subtitle: Text(
                  'Tổng tiền: ${order.totalAmount} VNĐ - Trạng thái: ${order.status}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
