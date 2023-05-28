import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddFarmingToolsScreen extends StatefulWidget {
  static const String screenId = 'add_farming_tools_screen';

  @override
  _AddFarmingToolsScreenState createState() => _AddFarmingToolsScreenState();
}

class _AddFarmingToolsScreenState extends State<AddFarmingToolsScreen> {
  File? _image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String? _selectedEquipment;
  String? _selectedOption;

  List<String> _equipmentList = [
    'Tractor',
    'Plough',
    'Hoe',
    'Harvester',
    'Seeder',
  ];

  List<String> _optionList = [
    'Buy',
    'Rent',
  ];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery, // or ImageSource.camera
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Widget _buildDropDownField(BuildContext context, List<String> options, String label, String? value) {
    return DropdownButtonFormField<String>(
      value: value,
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onChanged: (String? value) {
        setState(() {
          if (label == 'Equipment') {
            _selectedEquipment = value;
          } else if (label == 'Option') {
            _selectedOption = value;
          }
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an option';
        }
        return null;
      },
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          'Select an image:',
          style: TextStyle(fontSize: 16.0),
        ),
        const SizedBox(height: 8.0),
        InkWell(
          onTap: _pickImage,
          child: Container(
            height: 150.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: _image == null
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo,
                    size: 40.0,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Tap to select image'),
                ],
              ),
            )
                : Image.file(_image!),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(BuildContext context, String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      DatabaseReference database = FirebaseDatabase.instance.reference();
      DatabaseReference farmingToolsRef = database.child('farming_tools').push();

      farmingToolsRef.set({
        'equipment': _selectedEquipment,
        'option': _selectedOption,
        'price': _priceController.text,
        'description': _descriptionController.text,
      });

      if (_image != null) {
        // Upload the image to Firebase Storage
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        DatabaseReference imageRef = farmingToolsRef.child('image');

        imageRef.set(imageName);

        Reference storageRef = FirebaseStorage.instance.ref().child('images').child(imageName);

        // Read the file
        List<int> imageBytes = await _image!.readAsBytes();
        String base64Image = base64Encode(imageBytes);

        storageRef.putData(base64Decode(base64Image));
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted')),
      );
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Farming Tools'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildImagePicker(context),
                const SizedBox(height: 16.0),
                const Text(
                  'Fill out the details below:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                _buildDropDownField(context, _equipmentList, 'Equipment', _selectedEquipment),
                const SizedBox(height: 16.0),
                _buildDropDownField(context, _optionList, 'Option', _selectedOption),
                const SizedBox(height: 16.0),
                _buildTextField(context, 'Price', _priceController),
                const SizedBox(height: 16.0),
                _buildTextField(context, 'Description', _descriptionController),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
