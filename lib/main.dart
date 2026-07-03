import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/api_client.dart';
import 'services/auth_service.dart';
import 'services/product_service.dart';
import 'services/category_service.dart';
import 'services/post_service.dart';
import 'services/order_service.dart';

import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';
import 'providers/category_provider.dart';
import 'providers/post_provider.dart';
import 'providers/order_provider.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

import 'providers/cart_provider.dart';
import 'screens/cart_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiClient = ApiClient();
  final authService = AuthService(apiClient);
  final productService = ProductService(apiClient);
  final categoryService = CategoryService(apiClient);
  final postService = PostService(apiClient);
  final orderService = OrderService(apiClient);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authService)..checkAuth(),
        ),
        ChangeNotifierProvider(create: (_) => ProductProvider(productService)),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(categoryService),
        ),
        ChangeNotifierProvider(create: (_) => PostProvider(postService)),
        ChangeNotifierProvider(create: (_) => OrderProvider(orderService)),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excavator Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E),
          primary: const Color(0xFF1A237E),
          secondary: const Color(0xFFFFC107),
        ),
        // ... keep other theme settings
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _initAuth();
  }

  Future<void> _initAuth() async {
    await context.read<AuthProvider>().checkAuth();
    if (mounted) {
      setState(() => _checked = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_checked) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // You can choose to always allow Home or force Login
    // For a shop app, Home is usually accessible without login
    return const HomeScreen();
  }
}
