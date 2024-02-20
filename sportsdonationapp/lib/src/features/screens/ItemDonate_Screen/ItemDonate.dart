import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CricketItemData {
  final String itemName;
  final List<String> itemImages;
  final String uploadedTime;
  final String sportsCategory;
  final bool approved; // New field for approval status

  CricketItemData({
    required this.itemName,
    required this.itemImages,
    required this.uploadedTime,
    required this.sportsCategory,
    this.approved = false, // Set the initial value to false
  });
}

class ItemDonate extends StatefulWidget {
  const ItemDonate({Key? key}) : super(key: key);

  @override
  _ItemDonateState createState() => _ItemDonateState();
}

class _ItemDonateState extends State<ItemDonate> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  int itemCount = 1; // Initial item count
  String? selectedProvince;
  String? selectedSportsCategory;
  List<String> provinces = [
    'Western',
    'Central',
    'Southern',
    'Northern',
    'Eastern',
    'North Western',
    'North Central',
    'Uva',
    'Sabaragamuwa',
  ];

  List<String> sportsCategories = [
    'Cricket',
    'Football',
    'Rugby',
    'Netball',
    'Volleyball',
    'Other',
  ];

  List<XFile> selectedImages = [];
  final ImagePicker _imagePicker = ImagePicker();

  bool _isLoading = false; // Added

  Future<void> _pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        if (selectedImages.length < 3) {
          selectedImages.add(image);
        } else {
          // Handle maximum image selection
        }
      });
    }
  }

  Future<void> _uploadDataToFirebase(CricketItemData itemData, int itemCount) async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      CollectionReference itemsCollection = FirebaseFirestore.instance.collection('items');

      List<String> imageUrls = await _uploadImagesToStorage(selectedImages);

      await itemsCollection.add({
        'itemName': itemData.itemName,
        'itemImages': imageUrls,
        'uploadedTime': itemData.uploadedTime,
        'province': selectedProvince,
        'sportsCategory': itemData.sportsCategory,
        'description': descriptionController.text,
        'contactNumber': contactNumberController.text,
        'approved': itemData.approved, // Include the 'approved' field
        'itemCount': itemCount, // Store the selected item count
      });

      print('Data uploaded successfully!');
    } catch (e) {
      print('Error uploading data: $e');
    }

    setState(() {
      _isLoading = false; // Hide loading indicator
    });
  }

  Future<List<String>> _uploadImagesToStorage(List<XFile> images) async {
    List<String> imageUrls = [];

    for (XFile image in images) {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference reference = FirebaseStorage.instance.ref().child('images/$fileName.jpg');
        await reference.putFile(File(image.path));
        String downloadURL = await reference.getDownloadURL();
        imageUrls.add(downloadURL);
      } catch (e) {
        print('Error uploading image: $e');
      }
    }

    return imageUrls;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate Item'),
        centerTitle: true,
      ),
      body: _isLoading // Show loading indicator if uploading data
          ? Center(child: CircularProgressIndicator())
          : Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image from Gallery'),
              ),
              if (selectedImages.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var image in selectedImages)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.file(
                            File(image.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                ),
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                style: const TextStyle(color: Colors.white70),
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Description'),
                style: const TextStyle(color: Colors.white70),
              ),
              DropdownButtonFormField(
                value: selectedProvince,
                items: provinces.map((province) {
                  return DropdownMenuItem(
                    value: province,
                    child: Text(
                      province,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedProvince = value as String?;
                  });
                },
                decoration: const InputDecoration(labelText: 'Province'),
              ),
              DropdownButtonFormField(
                value: selectedSportsCategory,
                items: sportsCategories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: Colors.white70, // Change the text color here
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSportsCategory = value as String?;
                  });
                },
                decoration: const InputDecoration(labelText: 'Sports Category'),
              ),
              TextFormField(
                controller: contactNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Contact Number'),
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (itemCount > 1) {
                        setState(() {
                          itemCount--; // Decrease item count
                        });
                      }
                    },
                    icon: Icon(Icons.remove),
                  ),
                  Text(
                    '$itemCount', // Display current item count
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      if (itemCount < 50) {
                        setState(() {
                          itemCount++; // Increase item count
                        });
                      }
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  if (selectedImages.isEmpty || selectedSportsCategory == null) {
                    // Show an error message for no selected images or sports category
                    return;
                  }

                  String title = titleController.text.trim();
                  if (title.isEmpty) {
                    // Show an error message for empty title
                    return;
                  }

                  try {
                    CricketItemData itemData = CricketItemData(
                      itemName: title,
                      itemImages: selectedImages.map((image) => image.path).toList(),
                      uploadedTime: DateTime.now().toString(),
                      sportsCategory: selectedSportsCategory!,
                    );

                    await _uploadDataToFirebase(itemData, itemCount); // Pass itemCount to the method
                    // Optionally, reset form fields and selected images here

                    Navigator.pop(context, itemData);
                  } catch (e) {
                    // Handle other errors
                    print('Error: $e');
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
