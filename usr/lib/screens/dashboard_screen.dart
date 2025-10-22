import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DashboardScreen extends StatelessWidget {
  final bool isArabic;

  const DashboardScreen({super.key, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    // Mock data for metrics
    final metrics = [
      {'name': isArabic ? 'درجة الحرارة' : 'Temperature', 'value': 35.0, 'unit': '°C', 'icon': Icons.thermostat},
      {'name': isArabic ? 'ثاني أكسيد الكربون' : 'CO₂', 'value': 400.0, 'unit': 'ppm', 'icon': Icons.cloud},
      {'name': isArabic ? 'الطاقة' : 'Energy', 'value': 150.0, 'unit': 'kWh', 'icon': Icons.flash_on},
      {'name': isArabic ? 'المنطقة الخضراء' : 'Green Area', 'value': 25.0, 'unit': '%', 'icon': Icons.grass},
      {'name': isArabic ? 'التنوع البيولوجي' : 'Biodiversity', 'value': 80.0, 'unit': '%', 'icon': Icons.bug_report},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(isArabic ? 'لوحة التحكم' : 'Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(isArabic ? 'مقارنة الإمارات العالمية' : 'UAE vs Global Comparison', style: Theme.of(context).textTheme.headlineSmall),
            Expanded(
              child: ListView.builder(
                itemCount: metrics.length,
                itemBuilder: (context, index) {
                  final metric = metrics[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(metric['icon'] as IconData, color: Theme.of(context).colorScheme.primary),
                      title: Text(metric['name'] as String),
                      subtitle: Text('${metric['value']} ${metric['unit']}'),
                      trailing: SizedBox(
                        width: 100,
                        height: 50,
                        child: LineChart(
                          LineChartData(
                            lineBarsData: [
                              LineChartBarData(
                                spots: [const FlSpot(0, 30), FlSpot(1, metric['value'] as double)],
                                isCurved: true,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ).animate().scale(duration: 500.ms),
                    ),
                  ).animate().slideInFromBottom();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}