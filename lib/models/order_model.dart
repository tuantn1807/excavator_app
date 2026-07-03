import 'product_model.dart';

class OrderItemModel {
  final int id;
  final int? orderId;
  final int productId;
  final int quantity;
  final double price;
  final ProductModel? product;

  OrderItemModel({
    required this.id,
    this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    this.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      orderId: json['order_id'] != null
          ? int.tryParse(json['order_id'].toString())
          : null,
      productId: int.tryParse(json['product_id']?.toString() ?? '0') ?? 0,
      quantity: int.tryParse(json['quantity']?.toString() ?? '0') ?? 0,
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'order_id': orderId,
    'product_id': productId,
    'quantity': quantity,
    'price': price,
    'product': product?.toJson(),
  };
}

class OrderModel {
  final int id;
  final int? userId;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String? note;
  final double totalAmount;
  final String status;
  final List<OrderItemModel> items;
  final DateTime? createdAt;

  OrderModel({
    required this.id,
    this.userId,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    this.note,
    required this.totalAmount,
    required this.status,
    required this.items,
    this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is String) return DateTime.tryParse(value);
      return null;
    }

    return OrderModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      userId: json['user_id'] != null
          ? int.tryParse(json['user_id'].toString())
          : null,
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      note: json['note']?.toString(),
      totalAmount: double.tryParse(json['total_amount']?.toString() ?? '0') ?? 0.0,
      status: json['status']?.toString() ?? 'pending',
      items: json['items'] is List
          ? (json['items'] as List)
                .map((item) => OrderItemModel.fromJson(item))
                .toList()
          : [],
      createdAt: parseDate(json['created_at']),
    );
  }
}
