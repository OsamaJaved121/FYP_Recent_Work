import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ArScreen extends StatelessWidget {
  const ArScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AR Screen"),
        backgroundColor: Color(0xFF4C53A5),
      ),
      body: ModelViewer(
        src: 'lib/assets/Car_Cartoon/source/Car_cartoon.gltf',
        ar: true,
        arPlacement: ArPlacement.floor,
        cameraControls: true,
      ),
    );
  }
}
