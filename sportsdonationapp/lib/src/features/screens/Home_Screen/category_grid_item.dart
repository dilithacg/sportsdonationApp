import 'package:flutter/material.dart';
import '../Donation_Screen/Football_screen.dart';
import '../Donation_Screen/Netball_screen.dart';
import '../Donation_Screen/Other_screen.dart';
import '../Donation_Screen/Rugby_screen.dart';
import '../Donation_Screen/Volleyball_screen.dart';
import '../Donation_Screen/cricket_screen.dart';
import 'Category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _navigateToCategoryScreen(context, category); // Call navigation method
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.headline6!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
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
          MaterialPageRoute(builder: (context) => CricketItemsList()),
        );
        break;
      case 'c2':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VolleyballItemsList()),
        );
        break;
      case 'c3':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FootballItemsList()),
        );
        break;
      case 'c4':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RugbyItemsList()),
        );
        break;
      case 'c5':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NetballItemsList()),
        );
        break;
      case 'c6':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtherItemsList()),
        );
        break;
      default:
      // Handle the default case
        break;
    }
  }
}
