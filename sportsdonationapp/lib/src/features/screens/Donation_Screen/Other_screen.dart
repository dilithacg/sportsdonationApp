import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportsdonationapp/src/constants/colors.dart';

import '../Item_detail/Item_detail.dart';

class OtherItemsList extends StatefulWidget {
  const OtherItemsList({Key? key}) : super(key: key);

  @override
  _OtherItemsListState createState() => _OtherItemsListState();
}

class _OtherItemsListState extends State<OtherItemsList> {
  List<OtherItemData> otherItems = [];

  @override
  void initState() {
    super.initState();
    // Fetch data from Firestore when the widget is initialized
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('items')
          .where('sportsCategory', isEqualTo: 'Other') // Filter by sports category
          .orderBy('uploadedTime', descending: true)
          .get();

      List<OtherItemData> items = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return OtherItemData(
          itemName: data['itemName'] ?? 'Other Item',
          itemImages: List<String>.from(data['itemImages'] ?? []),
          uploadedTime: data['uploadedTime'] ?? '',
          province: data['province'] ?? '',
          contactNumber: data['contactNumber'] ?? '',
          description: data['description'] ?? '',
          approved: data['approved'] ?? false,
        );
      }).toList();

      setState(() {
        otherItems = items;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Other Items List'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: otherItems.length,
          itemBuilder: (context, index) {
            return OtherItem(
              itemName: otherItems[index].itemName,
              itemImages: otherItems[index].itemImages,
              uploadedTime: otherItems[index].uploadedTime,
              province: otherItems[index].province,
              contactNumber: otherItems[index].contactNumber,
              description: otherItems[index].description,
              onTap: () {
                // Navigate to the ItemDetails screen when an item is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetails(
                      itemName: otherItems[index].itemName,
                      itemImages: otherItems[index].itemImages,
                      uploadedTime: otherItems[index].uploadedTime,
                      province: otherItems[index].province,
                      contactNumber: otherItems[index].contactNumber,
                      description: otherItems[index].description,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class OtherItem extends StatelessWidget {
  final String itemName;
  final List<String> itemImages;
  final String uploadedTime;
  final String province;
  final String contactNumber;
  final String description;
  final VoidCallback onTap;

  const OtherItem({
    required this.itemName,
    required this.itemImages,
    required this.uploadedTime,
    required this.province,
    required this.contactNumber,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(uploadedTime);
    String formattedTime = "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
    String formattedDate = "${dateTime.day}/${dateTime.month}/${dateTime.year}";

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Card(
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: itemImages.isNotEmpty
                    ? Image.network(
                  itemImages.isNotEmpty ? itemImages[0] : 'gs://sportsitemdonationp.appspot.com/imageFile', // Ensure a valid URL is provided
                  fit: BoxFit.cover,
                  height: 150,
                  width: 180,
                )
                    : const Icon(Icons.image),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemName,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
                    ),
                    Text('Uploaded: $formattedDate at $formattedTime', style: const TextStyle(color: Colors.white60)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OtherItemData {
  String itemName;
  List<String> itemImages;
  String uploadedTime;
  String province;
  String contactNumber;
  String description;
  bool approved;


  OtherItemData({
    required this.itemName,
    required this.itemImages,
    required this.uploadedTime,
    required this.province,
    required this.contactNumber,
    required this.description,
    required this.approved,

  });
}
