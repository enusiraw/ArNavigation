// ignore_for_file: use_build_context_synchronously

import 'package:ar_navigation/pages/navigation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService extends StatefulWidget {
  const CameraService({super.key});

  @override
  State<CameraService> createState() => _CameraServiceState();
}

class _CameraServiceState extends State<CameraService> {
  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      if (await Permission.camera.request().isGranted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavigationPge()),
        );
      }
    } else if (status.isGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NavigationPge()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Requesting camera permission...'),
      ),
    );
  }
}
