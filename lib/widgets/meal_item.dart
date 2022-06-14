// ignore_for_file: dead_code


import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail.dart';

class MealItem extends StatelessWidget {
  const MealItem(
      {Key? key,
      required this.id,
      required this.title,
      required this.imageUrl,
      required this.duration,
      required this.complexity,
      required this.affordability})
      : super(key: key);
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      MealDetail.routeName,
      arguments: id
    ).then((value) {
      if(value != null)
      {
        // removeItem(value);
      }
    });
  }

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple :
        return 'Simple';
        break;
      case Complexity.Challenging :
        return 'Challenging';
        break;
      case Complexity.Hard :
        return 'Hard';
        break;
      default :
        return 'Unknown';
    }
  }
  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable :
        return 'Affordable';
        break;
      case Affordability.Pricey :
        return 'Pricey';
        break;
      case Affordability.Luxurious :
        return 'Luxurious';
        break;
      default :
        return 'Unknown';
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                Row(
                  children: [
                    const Icon(Icons.schedule,),
                    const SizedBox(width:6,),
                    Text('$duration min'),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.work,),
                    const SizedBox(width:6,),
                    Text(complexityText),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.attach_money,),
                    const SizedBox(width:6,),
                    Text(affordabilityText),
                  ],
                ),
              ],),
            )
          ],
        ),
      ),
    );
  }
}
