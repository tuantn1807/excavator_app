import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/product_model.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    return FutureBuilder<ProductModel>(
      future: context.read<ProductProvider>().getProductDetail(productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text('Lỗi: ${snapshot.error}')),
          );
        }

        final product = snapshot.data!;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400.0,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Consumer<CartProvider>(
                        builder: (context, cart, child) {
                          return Badge(
                            isLabelVisible: cart.itemCount > 0,
                            label: Text(cart.itemCount.toString()),
                            child: const Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.black87,
                            ),
                          );
                        },
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/cart'),
                    ),
                  ),
                ],
                leading: Container(
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.0),
                              Colors.black.withOpacity(0.2),
                            ],
                            stops: const [0.0, 0.3, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                height: 1.2,
                              ),
                            ),
                          ),
                          _buildInfoBadge(
                            product.isActive ? 'Sẵn hàng' : 'Liên hệ',
                            product.isActive ? Colors.green : Colors.orange,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        currencyFormat.format(product.price),
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Thông số kỹ thuật',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSpecsTable(product),
                      const SizedBox(height: 32),
                      const Text(
                        'Mô tả chi tiết',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        product.description ?? 'Đang cập nhật nội dung mô tả...',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.8,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: _buildBottomAction(context, product),
        );
      },
    );
  }

  Widget _buildInfoBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _buildSpecsTable(ProductModel product) {
    final specs = {
      'Model': product.model,
      'Trọng lượng': product.weight,
      'Sức nâng': product.liftingCapacity,
      'Dung tích gầu': product.bucketCapacity,
      'Chiều cao đổ lớn nhất': product.maxDumpHeight,
      'Động cơ': product.engineModel,
      'Công suất động cơ': product.enginePower,
      'Loại truyền động': product.transmissionType,
      'Kích thước lốp': product.tireSize,
      'Kích thước tổng thể': product.overallDimensions,
      'Chu kỳ làm việc': product.workCycle,
      'Tốc độ tối đa': product.maxSpeed,
      'Khả năng leo dốc': product.gradeability,
    };

    final validSpecs = specs.entries.where((e) => e.value != null && e.value!.isNotEmpty).toList();

    if (validSpecs.isEmpty) {
      return const Text('Thông số đang được cập nhật...');
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: validSpecs.map((e) => _buildSpecRow(e.key, e.value!)).toList(),
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context, ProductModel product) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0068FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                onPressed: () async {
                  final url = Uri.parse('https://zalo.me/0912345678');
                  try {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Không thể mở Zalo')),
                    );
                  }
                },
                icon: const Icon(Icons.chat, color: Color(0xFF0068FF)),
                tooltip: 'Tư vấn qua Zalo',
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                ),
                onPressed: () {
                  context.read<CartProvider>().addItem(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã thêm vào giỏ hàng')),
                  );
                },
                icon: const Icon(Icons.shopping_cart_checkout),
                label: const Text(
                  'THÊM VÀO GIỎ HÀNG',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
