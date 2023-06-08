import 'package:flutter_tflite/flutter_tflite.dart';

class TensrFlowController {
  TensrFlowController() {
    loadmodel();
  }
  Future<List<String>> runImage(String imagePath) async {
    var recognitions = await Tflite.runModelOnImage(
        path: imagePath, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 2, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    var confidence = recognitions![0]["confidence"];
    var label = recognitions![0]["label"];
    return [confidence.toString(), label.toString()];
  }

  void loadmodel() async {
    await Tflite.loadModel(
        model: "assets/datefruit.tflite",
        labels: "assets/datefruit.txt",
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }

  void dispose() async {
    await Tflite.close();
  }
}
