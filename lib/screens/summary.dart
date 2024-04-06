import 'package:flutter/material.dart';
import 'package:ihp/services/generatePDF.dart';

class Summary extends StatelessWidget {
  final PDFService pdfService = PDFService();

  final double grandTotal;
  final Map<String, Map<String, int>> allVariants;
  final Map<String, double> variantPrices;

  Summary({
    Key? key,
    required this.grandTotal,
    required this.allVariants,
    required this.variantPrices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () async {
              final data = await pdfService.generatePDF(grandTotal, allVariants, variantPrices);
              pdfService.savePDF("Order_Summary", data);
            },
          ),
        ],
        title: const Text('Order Summary'),
        backgroundColor: const Color(0xFFEA7724),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
            child: Text(
              'Total: ₹$grandTotal',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
              child: ListView(
                shrinkWrap: true,
                children: allVariants.entries.map((entry) {
                  final chocolateName = entry.key;
                  final variants = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFEA7724),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/$chocolateName.jpg',
                                width: 80,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chocolateName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: variants.entries.map((variantEntry) {
                                      final variant = variantEntry.key;
                                      final quantity = variantEntry.value;
                                      final pricePerUnit = variantPrices[variant]!;
                                      final totalPrice = quantity * pricePerUnit;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        child: Text(
                                          '$quantity x $variant = ₹$totalPrice',
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
