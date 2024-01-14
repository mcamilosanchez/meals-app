/* 184. Creating a More Complex Provider with StateNotifier */
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

/* 184. Creating a More Complex Provider with StateNotifier
Si tenemos datos más complejos, que deben cambiar en determinadas 
circunstancias, la clase Provider() es la elección equivocada. En este caso, se 
debe usar StateNotifierProvider, la cual está optimizada para datos que puedan 
cambiar.
StateNotifie es una clase genérica, por lo cual vamos a escribir <> al final 
para indicar que tipo de datos serán gestionados por este notificador*/

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  /* 184. Creating a More Complex Provider with StateNotifier
  El primer paso para crear el notifier, es crear el construstor. Luego, 
  llamamos a super para llegar a la clase padre (StateNotifier) y dentro de 
  super, pasamos nuestro datos iniciales. Estos datos pueden ser de cualquier 
  tipo, pero debe ser del tipo del que estamos usando dentro de 
  StateNotifier<List<Meal>>, es decir, una lista de meals; que por ahora será 
  una lista vacía. */
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    /* 184. Creating a More Complex Provider with StateNotifier
    Algo importante que debemos tener en cuenta relacionado con este valor
    super([]) que es manejado por el Notifier, es que NUNCA DEBES EDITARLO, es 
    decir, no podemos acceder a esta lista super([]) para añadir o eliminar, en 
    su lugar tendríamos que SUSTITUIRLO, para ellos usamos la propiedad state */
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      /* Si los ids no son iguales, la comida a la que estoy hechando un vistazo
       (m) no es la comida(meal) para la que estoy cambiando el estado de 
       Favorito.
       Así es como se puede quitar una comida por añadir a otra. */
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

/* 184. Creating a More Complex Provider with StateNotifier */
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});
