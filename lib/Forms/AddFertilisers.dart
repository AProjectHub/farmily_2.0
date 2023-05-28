import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddFertilisersScreen extends StatefulWidget {
  static const String screenId = 'fertiliserscreen';

  @override
  _AddFertilisersScreenState createState() => _AddFertilisersScreenState();
}

class _AddFertilisersScreenState extends State<AddFertilisersScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
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
            .child('fertilizer_images')
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
    FirebaseDatabase.instance.reference().child('fertilizers');

    try {
      DatabaseReference newFertilizerRef = databaseReference.push();
      await newFertilizerRef.set({
        'name': _nameController.text,
        'brand': _brandController.text,
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

  Widget _buildTextField(BuildContext context, String label,
      TextEditingController controller) {
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
      await _uploadImageToStorage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Fertilisers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 16.0),
                const Text(
                  'Fill out the details below:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                _buildImagePicker(context),
                const SizedBox(height: 16.0),
                _buildTextField(context, 'Name', _nameController),
                const SizedBox(height: 16.0),
                _buildTextField(context, 'Brand', _brandController),
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
