import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });
}

const List<Category> availableCategories = [

  Category(
    id: 'c1',
    title: 'Donate requests',
    color: Colors.red,
  ),

  Category(
    id: 'c2',
    title: 'Item requests',
    color: Colors.blue,
  ),
  Category(
    id: 'c3',
    title: 'Add sports update',
    color: Colors.green,
  ),
];
