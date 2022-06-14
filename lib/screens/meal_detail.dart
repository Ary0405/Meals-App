import 'package:flutter/material.dart';
import '../models/dummy_data.dart';

class MealDetail extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavourite;
  final Function isFavourite;
  MealDetail({Key? key, required this.toggleFavourite, required this.isFavourite}) : super(key: key);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular((10)),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = dummyMeals.firstWhere((meal) => meal.id == mealId);
    var title1;
    return Scaffold(
        appBar: AppBar(title: Text(selectedMeal.title)),
        body:SingleChildScrollView(
          child: Column (
            children: <Widget>[
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildSectionTitle(context, 'Ingridients'),
              buildContainer(
                ListView.builder(
                  itemBuilder: ((context, index) => Card(
                        color: Theme.of(context).colorScheme.secondary,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10),
                          child: Text(selectedMeal.ingredients[index]),
                        ),
                      )),
                  itemCount: selectedMeal.ingredients.length,
                ),
              ),
              buildSectionTitle(context, 'Steps'),
              buildContainer(ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    child: Text('# ${(index+1)}'),
                  ),
                  title: Text(selectedMeal.steps[index]),
                ),
                itemCount: selectedMeal.steps.length,
                )
              ) 
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            isFavourite(mealId) ? Icons.star : Icons.star_border,
          ),
          onPressed: () => toggleFavourite(mealId),
        ) ,
    );
  }
}
