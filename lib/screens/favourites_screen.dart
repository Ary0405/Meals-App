import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key, required this.favouriteMeal})
      : super(key: key);
  final List<Meal> favouriteMeal;
  @override
  Widget build(BuildContext context) {
    if (favouriteMeal.isEmpty) {
      return const Center(
        child: Text('You have no favourites yet - start adding some !'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: favouriteMeal[index].id,
            title: favouriteMeal[index].title,
            imageUrl: favouriteMeal[index].imageUrl,
            duration: favouriteMeal[index].duration,
            complexity: favouriteMeal[index].complexity,
            affordability: favouriteMeal[index].affordability,
          );
        },
        itemCount: favouriteMeal.length,
      );
    }
  }
}
