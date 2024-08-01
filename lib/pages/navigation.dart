import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class NavigationPge extends StatefulWidget {
const NavigationPge({super.key});

@override
State<NavigationPge> createState() => _NavigationPgeState();
}

class _NavigationPgeState extends State<NavigationPge> {
  CameraController? _cameraController;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      _cameraController = CameraController(
        cameras![0],
        ResolutionPreset.high,
      );
      await _cameraController!.initialize();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_cameraController!),
          CustomPaint(
            size: MediaQuery.of(context).size,
          ),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: _buildControls(context),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          items: <String>['Destination 1', 'Destination 2', 'Destination 3']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
          hint: const Text('Select Destination'),
        ),
        IconButton(
          icon: const Icon(Icons.my_location),
          onPressed: () {},
        ),
      ],
    );
  }
}