import 'package:flutter/material.dart';
import 'package:meals_app/models/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_detail.dart';
import 'package:meals_app/screens/tabs_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Map<String , bool> _filters  = {
    'gluten' : false,
    'lactose' : false, 
    'vegan' : false,
    'vegetarian' : false,
  };
  void _setFilters(Map<String , bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = dummyMeals.where((meal) {
        if(_filters['gluten'] == true && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose'] == true && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan'] == true && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian'] == true && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }
  
  void _toggleFavourite(String mealId) {
    final existingIndex = _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >=0){
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    }else {
      setState(() {
        _favouriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isFavourite(String id) {
    return _favouriteMeals.any((meal) => meal.id == id);
  }

  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favouriteMeals = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      title: 'DeliMeals',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(secondary: Colors.amber),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1 : const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          bodyText2: const TextStyle(
            color : Color.fromRGBO(20, 51, 51, 1),
          ),
          subtitle1 : const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          )
        )
      ),
      //home: const CategoriesScreen(),
      routes: {
        '/' :(context) => TabsScreen(favouriteMeal: _favouriteMeals,),
        '/category-meals' :(context) => displayMealscreen(availableMeals: _availableMeals,),
        MealDetail.routeName : ((context) => MealDetail(isFavourite : _isFavourite,toggleFavourite : _toggleFavourite)),
        FiltersScreen.routeName :(context) => FiltersScreen(currentFilters : _filters,saveFilters: _setFilters )
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx)=>const CategoriesScreen());
      },

    );
  }
}
