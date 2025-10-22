import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';

class ARScreen extends StatefulWidget {
  final bool isArabic;

  const ARScreen({super.key, required this.isArabic});

  @override
  State<ARScreen> createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;

  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.isArabic ? 'عرض الواقع المعزز' : 'AR Visualization')),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: _onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              onPressed: _addVirtualTree,
              child: Text(widget.isArabic ? 'أضف شجرة افتراضية' : 'Add Virtual Tree'),
            ),
          ),
        ],
      ),
    );
  }

  void _onARViewCreated(ARSessionManager sessionManager, ARObjectManager objectManager, ARAnchorManager anchorManager, ARLocationManager locationManager) {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;
    // Configure AR session
  }

  void _addVirtualTree() async {
    // Add a virtual tree model (placeholder; use real 3D model)
    final node = ARNode(
      type: NodeType.localGLTF2,
      uri: 'assets/models/tree.gltf', // Add asset
      scale: Vector3(0.1, 0.1, 0.1),
      position: Vector3(0, 0, -1),
    );
    await arObjectManager.addNode(node);
  }
}