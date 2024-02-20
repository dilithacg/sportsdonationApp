import 'package:flutter/material.dart';
import 'Category.dart';
import 'main_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Interface'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var category in availableCategories)
              ElevatedButton(
                onPressed: () {
                  _navigateToCategoryScreen(context, category);
                },
                style: ElevatedButton.styleFrom(
                  primary: category.color,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                ),
                child: Text(
                  category.title,
                  style: TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _navigateToCategoryScreen(BuildContext context, Category category) {
    // Use a switch statement or if-else to determine which screen to navigate to
    switch (category.id) {
      case 'c1':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminScreen()),
        );
        break;
      case 'c2':
      // Navigate to VolleyballItemsList
        break;
      case 'c3':
      // Navigate to FootballItemsList

    }
  }
}
