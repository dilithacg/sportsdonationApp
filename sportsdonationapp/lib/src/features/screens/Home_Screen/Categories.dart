import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


import '../../../constants/colors.dart';
import '../../../constants/navBar.dart';
import '../ItemDonate_Screen/ItemDonate.dart';
import 'category_grid_item.dart';
import 'categorydata.dart';
//import 'main.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: Column(
        children: [
          // Add the CarouselSlider widget here
          CarouselSlider(
            items: carouselItems.map((imagePath) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
          Expanded(
            child: GridView(
              padding: const EdgeInsets.all(24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: [
                for (final category in availableCategories)
                  CategoryGridItem(category: category)
              ],
            ),
          ),
        ],

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 1),
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {
            // Handle the Floating Action Button press
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ItemDonate()),
            );
          },
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 3, color: Colors.white38),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(Icons.add),
        ),
      ),
   bottomNavigationBar: const BottomNavBar(),
    );
  }
}