import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:JobNex/core/common/constant/constant.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class SaveCertificate extends StatefulWidget {
  const SaveCertificate({super.key});

  @override
  State<SaveCertificate> createState() => _SaveCertificateState();
}

class _SaveCertificateState extends State<SaveCertificate> {
  Future<Uint8List> _loadBackgroundImage() async {
    final response = await http.get(Uri.parse(Constant.certificate));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load background image');
    }
  }

  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();
    final Uint8List backgroundImage = await _loadBackgroundImage();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.undefined,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Stack(
              alignment: pw.Alignment.center,
              children: [
                pw.Image(pw.MemoryImage(backgroundImage), fit: pw.BoxFit.cover),
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(
                      'Certificate of Completion',
                      style: pw.TextStyle(
                        fontSize: 120,
                        fontWeight: pw.FontWeight.bold,
                        color: const PdfColor.fromInt(0xff00626a),
                      ),
                    ),
                    pw.SizedBox(height: 60),
                    pw.Text(
                      'This is to certify that',
                      style: const pw.TextStyle(
                        fontSize: 72,
                        color: PdfColor.fromInt(0xff00626a),
                      ),
                    ),
                    pw.SizedBox(height: 30),
                    pw.Text(
                      'John Doe',
                      style: pw.TextStyle(
                        fontSize: 96,
                        fontWeight: pw.FontWeight.bold,
                        color: const PdfColor.fromInt(0xff00626a),
                      ),
                    ),
                    pw.SizedBox(height: 60),
                    pw.Text(
                      'has successfully completed the course',
                      style: const pw.TextStyle(
                        fontSize: 72,
                        color: PdfColor.fromInt(0xff00626a),
                      ),
                    ),
                    pw.SizedBox(height: 30),
                    pw.Text(
                      'Flutter Development',
                      style: pw.TextStyle(
                        fontSize: 96,
                        fontWeight: pw.FontWeight.bold,
                        color: const PdfColor.fromInt(0xff00626a),
                      ),
                    ),
                    pw.SizedBox(height: 120),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Date: 01/01/2024',
                          style: const pw.TextStyle(
                            fontSize: 60,
                            color: PdfColor.fromInt(0xff00626a),
                          ),
                        ),
                        pw.SizedBox(width: 600),
                        pw.Text(
                          'Signature',
                          style: const pw.TextStyle(
                            fontSize: 60,
                            color: PdfColor.fromInt(0xff00626a),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<void> saveAndLaunchFile(Uint8List bytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes);

    // Optionally, you can open the file using the printing package
    await Printing.sharePdf(bytes: bytes, filename: fileName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdfFile = await generatePdf();
            await saveAndLaunchFile(pdfFile, 'example.pdf');
          },
          child: const Text('Save as PDF'),
        ),
      ),
    );
  }
}
