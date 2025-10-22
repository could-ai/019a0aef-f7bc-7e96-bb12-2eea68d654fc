import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shamswahaai/widgets/voice_assistant.dart';

class HomeScreen extends StatefulWidget {
  final bool isArabic;
  final int userScore;
  final VoidCallback onLanguageToggle;
  final Function(int) onScoreUpdate;

  const HomeScreen({
    super.key,
    required this.isArabic,
    required this.userScore,
    required this.onLanguageToggle,
    required this.onScoreUpdate,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MapboxMapController _mapController;
  // Mock heat data (replace with real API when Supabase connected)
  final List<Map<String, dynamic>> _heatZones = [
    {'lat': 24.4539, 'lng': 54.3773, 'intensity': 0.9}, // Abu Dhabi example
    {'lat': 24.1302, 'lng': 55.8023, 'intensity': 0.6}, // Al Ain example
  ];

  void _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
    _addHeatOverlay();
  }

  void _addHeatOverlay() {
    // Add custom heat circles (simplified; use Mapbox layers for real heatmaps)
    for (var zone in _heatZones) {
      _mapController.addCircle(
        CircleOptions(
          circleRadius: 20,
          circleColor: _getHeatColor(zone['intensity']),
          circleOpacity: 0.7,
          geometry: LatLng(zone['lat'], zone['lng']),
        ),
      );
    }
  }

  Color _getHeatColor(double intensity) {
    if (intensity > 0.8) return Colors.red;
    if (intensity > 0.6) return Colors.orange;
    if (intensity > 0.4) return Colors.yellow;
    if (intensity > 0.2) return Colors.green;
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isArabic ? 'شمس الواحة AI' : 'ShamsWahaAI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: widget.onLanguageToggle,
          ),
          Text('${widget.isArabic ? 'النقاط' : 'Score'}: ${widget.userScore}'),
        ],
      ),
      body: Stack(
        children: [
          MapboxMap(
            accessToken: 'YOUR_MAPBOX_ACCESS_TOKEN', // Replace with real token
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(24.4539, 54.3773), // Abu Dhabi
              zoom: 10,
            ),
          ).animate().fadeIn(duration: 1.seconds),
          Positioned(
            bottom: 80,
            left: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'dashboard',
                  child: const Icon(Icons.dashboard),
                  onPressed: () => Navigator.pushNamed(context, '/dashboard'),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'sandbox',
                  child: const Icon(Icons.build),
                  onPressed: () => Navigator.pushNamed(context, '/sandbox'),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'ar',
                  child: const Icon(Icons.camera),
                  onPressed: () => Navigator.pushNamed(context, '/ar'),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'reports',
                  child: const Icon(Icons.file_download),
                  onPressed: () => Navigator.pushNamed(context, '/reports'),
                ),
              ],
            ),
          ),
          const VoiceAssistant(),
        ],
      ),
    );
  }
}