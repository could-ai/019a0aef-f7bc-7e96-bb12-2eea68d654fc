import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ReportsScreen extends StatelessWidget {
  final bool isArabic;

  const ReportsScreen({super.key, required this.isArabic});

  void _generateReport() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text(isArabic ? 'تقرير الاستدامة' : 'Sustainability Report', style: pw.TextStyle(fontSize: 24)),
            pw.Text('${isArabic ? 'مصادر البيانات الحرارية' : 'Thermal Data Sources'}: UAE Environment Agency, Satellite Data'),
            pw.Text('${isArabic ? 'تكلفة التنفيذ المقدرة' : 'Estimated Implementation Cost'}: 500,000 AED'),
            pw.Text('${isArabic ? 'التأثير التبريدي المتوقع' : 'Predicted Cooling Impact'}: 15% reduction, 20% energy savings'),
          ],
        ),
      ),
    );
    final output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/report.pdf');
    await file.writeAsBytes(await pdf.save());
    // Show download message
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isArabic ? 'التقارير' : 'Reports')),
      body: Center(
        child: ElevatedButton(
          onPressed: _generateReport,
          child: Text(isArabic ? 'إنشاء تقرير PDF' : 'Generate PDF Report'),
        ),
      ),
    );
  }
}