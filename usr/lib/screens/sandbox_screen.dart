import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shamswahaai/screens/home_screen.dart'; // For map update simulation

class SandboxScreen extends StatefulWidget {
  final bool isArabic;
  final Function(int) onScoreUpdate;

  const SandboxScreen({super.key, required this.isArabic, required this.onScoreUpdate});

  @override
  State<SandboxScreen> createState() => _SandboxScreenState();
}

class _SandboxScreenState extends State<SandboxScreen> {
  List<Map<String, dynamic>> _solutions = [
    {'name': widget.isArabic ? 'أشجار' : 'Trees', 'icon': Icons.nature, 'emoji': '🌳', 'effect': -2.0},
    {'name': widget.isArabic ? 'أسطح عاكسة' : 'Reflective Roofs', 'icon': Icons.roofing, 'emoji': '🧱', 'effect': -1.5},
    {'name': widget.isArabic ? 'نوافير ماء' : 'Water Fountains', 'icon': Icons.water_drop, 'emoji': '💧', 'effect': -1.0},
    {'name': widget.isArabic ? 'حدائق خضراء' : 'Green Parks', 'icon': Icons.park, 'emoji': '🏞️', 'effect': -3.0},
  ];
  Map<String, int> _appliedSolutions = {};
  double _tempReduction = 0;

  void _applySolution(String name) {
    setState(() {
      _appliedSolutions[name] = (_appliedSolutions[name] ?? 0) + 1;
      _tempReduction += _solutions.firstWhere((s) => s['name'] == name)['effect'];
    });
    widget.onScoreUpdate(10); // Award points
    // Simulate heatmap cooling animation (would update map in real app)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isArabic ? 'صندوق التخفيف' : 'Mitigation Sandbox')),
      body: Column(
        children: [
          Text(widget.isArabic ? 'اسحب الحلول للتطبيق' : 'Drag Solutions to Apply', style: Theme.of(context).textTheme.headlineSmall),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: _solutions.length,
              itemBuilder: (context, index) {
                final solution = _solutions[index];
                return Draggable<String>(
                  data: solution['name'],
                  feedback: Text(solution['emoji'], style: const TextStyle(fontSize: 50)),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(solution['icon'] as IconData, size: 40),
                        Text(solution['name']),
                        Text('${solution['emoji']} Effect: ${solution['effect']}°C'),
                      ],
                    ),
                  ).animate().bounce(duration: 800.ms),
                );
              },
            ),
          ),
          DragTarget<String>(
            onAccept: _applySolution,
            builder: (context, candidateData, rejectedData) {
              return Container(
                height: 100,
                color: Colors.green.withOpacity(0.3),
                child: Center(
                  child: Text(widget.isArabic ? 'أسقط هنا للتطبيق' : 'Drop Here to Apply'),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('${widget.isArabic ? 'تخفيض الحرارة' : 'Temp Reduction'}: ${_tempReduction.toStringAsFixed(1)}°C').animate().fadeIn(),
                Text('${widget.isArabic ? 'المناطق المطبقة' : 'Applied Solutions'}: ${_appliedSolutions}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}