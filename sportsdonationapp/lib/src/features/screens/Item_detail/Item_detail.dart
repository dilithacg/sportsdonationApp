import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';

class ItemDetails extends StatefulWidget {
  final String itemName;
  final List<String> itemImages;
  final String uploadedTime;
  final String province;
  final String contactNumber;
  final String description;


  const ItemDetails({
    required this.itemName,
    required this.itemImages,
    required this.uploadedTime,
    required this.province,
    required this.contactNumber,
    required this.description,

  });

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  final ImagePicker _picker = ImagePicker();

  // Method to handle requesting the item
  void requestItem() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Here you can send the request with the picked image to the admin
      // You can implement the logic to send the request and handle the approval
      // For now, we'll just print a message
      print('Item requested with evidence: ${pickedFile.path}');
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: false,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: widget.itemImages.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Item Name: ${widget.itemName}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Uploaded Time: ${widget.uploadedTime}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Province: ${widget.province}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Contact Number: ${widget.contactNumber}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Description: ${widget.description}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: requestItem,
                    child: Text('Request Item'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
