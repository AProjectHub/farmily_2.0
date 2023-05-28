import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class CropPrediction extends StatefulWidget {
  @override
  _CropPredictionState createState() => _CropPredictionState();
}

class _CropPredictionState extends State<CropPrediction> {
  final ImagePicker _imagePicker = ImagePicker();
  List<dynamic>? _recognitions = [];
  File? _imageFile;
  String? _predictedDisease;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  @override
  void dispose() {
    disposeModel();
    super.dispose();
  }

  void loadModel() async {
    String modelPath = 'assets/TFModels/model_unquant.tflite';
    String labelsPath = 'assets/TFModels/labels.txt';

    await Tflite.loadModel(
      model: modelPath,
      labels: labelsPath,
    );
  }

  void runInferenceOnImage(XFile? imageFile) async {
    if (imageFile == null) return;

    var recognitions = await Tflite.runModelOnImage(
      path: imageFile.path,
      numResults: 5,
      threshold: 0.2,
    );

    setState(() {
      _imageFile = File(imageFile.path);
      _recognitions = recognitions;
      if (recognitions != null && recognitions.isNotEmpty) {
        _predictedDisease = recognitions[0]['label'];
      } else {
        _predictedDisease = null;
      }
      print(_predictedDisease);
    });
  }

  void disposeModel() async {
    await Tflite.close();
  }

  Future<void> _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Image Source"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: Text("Camera"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: Text("Gallery"),
          ),
        ],
      ),
    );

    if (imageSource != null) {
      final imageFile = await _imagePicker.pickImage(source: imageSource);
      runInferenceOnImage(imageFile);
    }
  }

  String getCureMessage() {
    if (_predictedDisease == '2 Rust') {
      return "A weekly dusting of sulfur can prevent and treat rust fungus. Neem oil, a botanical fungicide and pesticide, also controls rust.";
    } else if (_predictedDisease == '0 Healthy') {
      return "Your plant is healthy";
    } else if (_predictedDisease == '1 Powdery') {
      return "Treat powdery mildew in plants with fungicides or organic remedies like neem oil or baking soda, while also improving plant hygiene to prevent further spread.";
    } else {
      return "No specific cure information available";
    }
  }
  Widget _buildImagePicker() {
    if (_imageFile != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          _imageFile!,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_a_photo,
            size: 50,
            color: Colors.grey,
          ),
          SizedBox(height: 32), // Modified box height to 32
          Text(
            "Click on the box to detect plant disease",
            style: TextStyle(color: Colors.black45),
          ),
        ],
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmily AI'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Click below to detect plant disease',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              margin: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.green,
                  width: 2.0,
                ),
              ),
              height: 200,
              width: double.infinity,
              child: _buildImagePicker(),
            ),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(
                'Disease: ${_recognitions?.isNotEmpty == true ? _recognitions![0]['label'] : 'Upload Image For Disease Detection'}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                'Confidence: ${_recognitions?.isNotEmpty == true ? _recognitions![0]['confidence'] : ''}',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.green,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Cure',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    _predictedDisease != null
                        ? getCureMessage()
                        : 'Upload Image For Disease Detection and Cure',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
