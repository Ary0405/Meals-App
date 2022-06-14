import 'package:flutter/material.dart';
import '../models/dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
      GridView(
        padding: const EdgeInsets.all(20),
          children: dummyCategories
              .map((catData) =>
                  CategoryItem(title: catData.title, color: catData.color, id: catData.id,))
              .toList(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            // distance between column and row in the grid
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          )
    );
  }
}
