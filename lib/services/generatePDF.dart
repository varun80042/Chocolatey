import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:open_file/open_file.dart';

class PDFService {
  Future<Uint8List> generatePDF(double grandTotal, Map<String, Map<String, int>> allVariants, Map<String, double> variantPrices) async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      build: (pw.Context context) => [
        pw.Center(
          child: pw.Text(
            'Order Summary',
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
        ),
        pw.SizedBox(height: 20),

        for (var entry in allVariants.entries)
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(entry.key, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                for (var variantEntry in entry.value.entries)
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                    child: pw.Text(
                      '${variantEntry.value} x ${variantEntry.key} = Rs. ${variantEntry.value * variantPrices[variantEntry.key]!}',
                      style: const pw.TextStyle(fontSize: 16),
                    ),
                  ),
              ],
            ),
          ),

        pw.Container(
          alignment: pw.Alignment.centerRight,
          padding: const pw.EdgeInsets.only(top: 20, right: 20),
          child: pw.Text('Total: Rs. $grandTotal', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
        ),
    ],
    ));

    return pdf.save();
  }

  Future<void> savePDF(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }
}
