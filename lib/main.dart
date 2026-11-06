import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShopScreen(),
    );
  }
}

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  // Змінні для збереження даних
  String userName = '';
  String userEmail = '';
  List<String> products = [];
  List<String> orders = [];
  bool isLoading = true;

  // 1. Отримання юзера
  Future<void> getUser() async {
    await Future.delayed(const Duration(seconds: 2));
    userName = 'Тарас Кіт';
    userEmail = 'kit@gmail.com';
  }

  // 2. Отримання товарів
  Future<void> getProducts() async {
    await Future.delayed(const Duration(seconds: 3));
    products = [
      'Ноутбук - 30000 грн',
      'Телефон - 15000 грн',
      'Навушники - 2000 грн',
      'Мишка - 500 грн'
    ];
  }

  // 3. Отримання замовлень
  Future<void> getOrders() async {
    await Future.delayed(const Duration(seconds: 1));
    orders = [
      'Замовлення №1: Навушники',
      'Замовлення №2: Мишка'
    ];
  }

  // Головна функція завантаження (викликається при старті)
  void loadAllData() async {
    setState(() {
      isLoading = true;
    });

    // Викликаємо по черзі, як просили в лабі
    await getUser();
    await getProducts();
    await getOrders();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мій Магазин'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Завантаження... чекайте'),
          ],
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Інфа про юзера
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.blue[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Користувач: $userName', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Email: $userEmail'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Товари
            const Text('Список товарів:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            for (var item in products)
              Card(
                child: ListTile(
                  title: Text(item),
                  leading: const Icon(Icons.shopping_cart),
                ),
              ),
            const SizedBox(height: 20),

            // Замовлення
            const Text('Історія замовлень:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            for (var order in orders)
              Card(
                child: ListTile(
                  title: Text(order),
                  leading: const Icon(Icons.check),
                ),
              ),
          ],
        ),
      ),
    );
  }
}