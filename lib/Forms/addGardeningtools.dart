import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddGardeningToolsScreen extends StatefulWidget {
  static const String screenId = 'add_gardening_tools_screen';

  @override
  _AddGardeningToolsScreenState createState() => _AddGardeningToolsScreenState();
}

class _AddGardeningToolsScreenState extends State<AddGardeningToolsScreen> {
  File? _image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _selectedEquipment;
  String? _selectedOption;
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  List<String> _equipmentList = [
    'Lawn Mower',
    'Hedge Trimmer',
    'Pruner',
    'Rake',
    'Shovel',
  ];

  List<String> _optionList = [
    'Buy',
    'Rent',
  ];

  @override
  void dispose() {
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _uploadImageToStorage() async {
    if (_image != null) {
      try {
        firebase_storage.Reference storageReference = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('gardening_tool_images')
            .child(DateTime.now().millisecondsSinceEpoch.toString());

        await storageReference.putFile(_image!);
        String downloadURL = await storageReference.getDownloadURL();

        _saveDataToDatabase(downloadURL);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload image')),
        );
      }
    } else {
      _saveDataToDatabase(null);
    }
  }

  void _saveDataToDatabase(String? imageUrl) async {
    DatabaseReference databaseReference =
    FirebaseDatabase.instance.reference().child('gardening_tools');

    try {
      DatabaseReference newToolRef = databaseReference.push();
      await newToolRef.set({
        'equipment': _selectedEquipment,
        'option': _selectedOption,
        'price': _priceController.text,
        'description': _descriptionController.text,
        'imageUrl': imageUrl ?? '', // Store the image URL if available
        // Add other fields as needed
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to submit form')),
      );
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
          onTap: () async {
            final pickedFile = await ImagePicker().getImage(
              source: ImageSource.gallery, // or ImageSource.camera
            );
            if (pickedFile != null) {
              setState(() {
                _image = File(pickedFile.path);
              });
            }
          },
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

  Widget _buildTextField(BuildContext context, String label) {
    return TextFormField(
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
      controller: label == 'Price' ? _priceController : _descriptionController,
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await _uploadImageToStorage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Gardening Tools'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                _buildTextField(context, 'Price'),
                const SizedBox(height: 16.0),
                _buildTextField(context, 'Description'),
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
