import 'package:datefruitnew/pages/widgets/preview_image.dart';
import 'package:datefruitnew/services/single_detect.dart';
import 'package:datefruitnew/services/image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  XFile? image;
  var tfcontroller = TensrFlowController();

  void camera() async {
    final value = await takeFromCamera();
    setState(() {
      image = value;
    });
  }

  void gallery() async {
    final value = await pickFromGallery();
    setState(() {
      image = value;
    });
  }

  Widget _buildImageWidget() {
    if (image != null) {
      var result = tfcontroller.runImage(image!.path);
      return Column(
        children: [
          SizedBox(height: 320, width: 300, child: previewImage(image!.path)),
          const SizedBox(height: 60),
          FutureBuilder(
              future: result,
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}',
                      style: Theme.of(context).textTheme.bodyLarge);
                } else {
                  return Text(
                      "Confidence: ${snapshot.data?[0]}\n\n Label: ${snapshot.data?[1]}",
                      style: Theme.of(context).textTheme.bodyLarge);
                }
              }),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Date Fruit Type Detector"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          _buildImageWidget(),
          const SizedBox(height: 28),
          Text("Detect Using", style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: camera,
                  child: const Text("Camera"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: gallery,
                  child: const Text("Gallery"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
