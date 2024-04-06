import 'package:flutter/material.dart';
import 'package:ihp/widgets/chocolateCard.dart';
import 'package:ihp/screens/summary.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _grandTotal = 0.0;
  final Map<String, Map<String, int>> _selectedVariants = {};

  void _updateTotal(
      String productName, String variant, int quantity, double total) {
    setState(() {
      _grandTotal += total;
      if (quantity > 0) {
        if (!_selectedVariants.containsKey(productName)) {
          _selectedVariants[productName] = {};
        }
        _selectedVariants[productName]![variant] = quantity;
      } else {
        _selectedVariants[productName]?.remove(variant);
        if (_selectedVariants[productName]?.isEmpty ?? false) {
          _selectedVariants.remove(productName);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Chocolatey"),
          centerTitle: true,
          backgroundColor: const Color(0xFFEA7724),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              ChocolateCard(
                productName: 'Munch',
                imageUrl: 'assets/images/Munch.jpg',
                updateTotal: _updateTotal,
                selectedVariants: _selectedVariants,
              ),
              ChocolateCard(
                productName: 'Dairy Milk',
                imageUrl: 'assets/images/Dairy Milk.jpg',
                updateTotal: _updateTotal,
                selectedVariants: _selectedVariants,
              ),
              ChocolateCard(
                productName: 'KitKat',
                imageUrl: 'assets/images/KitKat.jpg',
                updateTotal: _updateTotal,
                selectedVariants: _selectedVariants,
              ),
              ChocolateCard(
                productName: 'Five Star',
                imageUrl: 'assets/images/Five Star.jpg',
                updateTotal: _updateTotal,
                selectedVariants: _selectedVariants,
              ),
              ChocolateCard(
                productName: 'Perk',
                imageUrl: 'assets/images/Perk.jpg',
                updateTotal: _updateTotal,
                selectedVariants: _selectedVariants,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 50,
          color: const Color(0xFFEA7724),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 70.0),
                  child: Text(
                    'Total: ₹$_grandTotal',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Summary(
                          grandTotal: _grandTotal,
                          allVariants: _selectedVariants,
                          variantPrices: const {
                            '10g': 5.0,
                            '35g': 25.0,
                            '80g': 50.0,
                            '120g': 90.0,
                          },
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Buy',
                    style: TextStyle(
                      color: Color(0xFFEA7724),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
