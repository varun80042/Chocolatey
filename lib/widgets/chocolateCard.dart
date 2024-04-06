import 'package:flutter/material.dart';

class ChocolateCard extends StatefulWidget {
  final String productName;
  final String imageUrl;
  final void Function(String, String, int, double) updateTotal;
  final Map<String, Map<String, int>> selectedVariants;

  const ChocolateCard({
    super.key,
    required this.productName,
    required this.imageUrl,
    required this.updateTotal,
    required this.selectedVariants,
  });

  @override
  _ChocolateCardState createState() => _ChocolateCardState();
}

class _ChocolateCardState extends State<ChocolateCard> {
  String _selectedVariant = '10g';

  final Map<String, int> _variantQuantities = {
    '10g': 0,
    '35g': 0,
    '80g': 0,
    '120g': 0,
  };

  final Map<String, double> _variantPrices = {
    '10g': 5.0,
    '35g': 25.0,
    '80g': 50.0,
    '120g': 90.0,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFEA7724),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 104,
                child: Column(
                  children: [
                    Image.asset(
                      widget.imageUrl,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEA7724),
                        border: Border.all(
                          color: const Color(0xFFEA7724),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (_variantQuantities[_selectedVariant]! >
                                      0) {
                                    _variantQuantities[_selectedVariant] =
                                        _variantQuantities[_selectedVariant]! -
                                            1;
                                    widget.updateTotal(
                                      widget.productName,
                                      _selectedVariant,
                                      _variantQuantities[_selectedVariant]!,
                                      -(_variantPrices[_selectedVariant]!),
                                    );
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: const Color(0xFFEA7724),
                                  shape: const StadiumBorder(),
                                  elevation: 0.0),
                              child: const Text('-',
                                  style: TextStyle(fontSize: 25)),
                            ),
                          ),
                          Container(
                            width: 40,
                            alignment: Alignment.center,
                            child: Text(
                              '${_variantQuantities[_selectedVariant] ?? 0}',
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _variantQuantities[_selectedVariant] =
                                      _variantQuantities[_selectedVariant]! + 1;
                                  widget.updateTotal(
                                    widget.productName,
                                    _selectedVariant,
                                    _variantQuantities[_selectedVariant]!,
                                    _variantPrices[_selectedVariant]!,
                                  );
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: const Color(0xFFEA7724),
                                  shape: const StadiumBorder(),
                                  elevation: 0.0),
                              child: const Text('+',
                                  style: TextStyle(fontSize: 25)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: ₹${_variantPrices[_selectedVariant]}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const Text("Variant"),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 40,
                        width: 85,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.brown),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: DropdownButton<String>(
                          value: _selectedVariant,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedVariant = newValue!;
                            });
                          },
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          underline: Container(),
                          icon: const Icon(Icons.arrow_drop_down),
                          iconDisabledColor: Colors.black,
                          iconEnabledColor: Colors.black,
                          elevation: 8,
                          items: _variantPrices.keys.map((String variant) {
                            return DropdownMenuItem<String>(
                              value: variant,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(variant),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
