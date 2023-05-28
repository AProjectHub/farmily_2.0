import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../globals.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? profileData;
  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference();

  File? imageFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    databaseReference
        .child('user')
        .child(globalDatabaseKey)
        .once()
        .then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        setState(() {
          profileData =
          Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
        });
      }
    });
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 90,
            backgroundImage: imageFile != null ? FileImage(imageFile!) : null,
            child: imageFile == null ? Icon(Icons.person, size: 120) : null,
          ),
          FloatingActionButton(
            onPressed: () {
              _chooseImage();
            },
            tooltip: 'Choose Image',
            child: Icon(Icons.add_a_photo),
          ),
        ],
      ),
    );
  }

  void _chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  ElevatedButton _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        _saveProfileImage();
      },
      child: Text('Save'),
    );
  }

  void _saveProfileImage() async {
    if (imageFile == null) {
      // Handle case when no image is selected
      return;
    }

    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    UploadTask uploadTask = storageReference.putFile(imageFile!);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

    if (snapshot.state == TaskState.success) {
      // Image upload successful
      String downloadUrl = await storageReference.getDownloadURL();

      // Save the download URL to the user's profile data in Firebase Realtime Database
      databaseReference.child('user').child(globalDatabaseKey).update({
        'profileImageUrl': downloadUrl,
      });

      // Display a success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile image saved successfully!')),
      );
    } else {
      // Image upload failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save profile image. Please try again.')),
      );
    }
  }

  Widget _buildProfileInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.0),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Name: ${profileData!['name']}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Phone Number: ${profileData!['phoneNumber']}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Address: ${profileData!['address']}',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: profileData != null
          ? SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            _buildProfileImage(),
            SizedBox(height: 20.0),
            _buildProfileInfo(),
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: _buildSaveButton(),
    );
  }
}
