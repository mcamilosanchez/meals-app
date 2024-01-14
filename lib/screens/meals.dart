/* VIDEO #157. Adding Meals Data
El objetivo de esta pantalla es mostrar todas las comidas para una categoría 
seleccionada */
import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    /* VIDEO #165. Adding Tab-based Navigation
    Hacemos title NO sea requerido debido al condicional (VER COMENTARIO 77) */
    this.title,
    required this.meals,
    //required this.onToggleFavorite,
  });

  /* VIDEO #165. Adding Tab-based Navigation
  Hacemos title NULLABLE debido al condicional (VER COMENTARIO 77) */
  final String? title;
  final List<Meal> meals;
  /* VIDEO #166. Passing Functions Through Multiple Layers of Widgets 
  (for State Management): */
  //final void Function(Meal meal) onToggleFavorite;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          /* 166. Passing Functions Through Multiple Layers of Widgets 
          (for State Management): Estamos pasando una función a múltiples 
          widgets, se hace así por el momento. Más adelante, se aplicará un 
          mejor método */
          //onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /* VIDEO #158. Loading Meals Data Into a Screen
          Ver el anterior video, si no entiende el siguiente código */
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      /* VIDEO #158. Loading Meals Data Into a Screen
      Ver el anterior video, si no entiende el siguiente código */
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
            meal: meals[index],
            /* VIDEO #163. Adding Navigation to the MealDetails Screen */
            onSelectMeal: (meal) {
              selectMeal(context, meal);
            }),
      );
    }

    /* VIDEO #165. Adding Tab-based Navigation: VER COMENTARIO 77 */
    if (title == null) {
      return content;
    }

    /* VIDEO #165. Adding Tab-based Navigation
    Como el main está ejecutando TabsScreen() y éste ya tiene el widget Scaffold
    y Appbar implementado, éste código de abajo se interpondrá, por lo cuál 
    haremos un condicional */
    return Scaffold(
      appBar: AppBar(
        title: Text(title!), /* Recordar que al poner ! estamos negando null */
      ),
      body: content,
    );
  }
}
