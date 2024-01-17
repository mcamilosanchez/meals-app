/* 187. Getting Started with Another Provider */
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

/* No te rindas Sánchez, tu puedes hacerlo!!! */

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          /* Recordar que dentro de super inicializaremos el estado, en este caso será
    un map de filtros donde cada filtro se establece en false inicialmente*/
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  /* Luego, con el estado definido, se debe añadir un método que nos permita 
  manipular ese estado de forma inmutable */

  /* VIDEO #188. Combining Local & Provider-managed State
  Este método de aquí, establecerá todos los filtros */
  void setFilters(Map<Filter, bool> chosenFilters) {
    /* Uso este nuevo mapa chosenFilters para anular mi estado existente 
    (state):  */
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    /* Cuando recibimos estos dos datos, ya podemos actualizar el estado. 
    Recordar que debemos hacerlo de manera INMUTABLE, es decir, si lo hacemos de
    esta manera: 

    state[filter] = isActive   NO ESTARÍA PERMITIDO, YA QUE ESTAMOS MUTANDO EL 
    ESTADO EN MEMORIA.

    Por lo anterior, la mejor manera de hacerlo, es establecer el estado a un 
    nuevo map, de la siguiente manera:
    
    La forma de crear un nuevo mapa aquí, es copiar el mapa existente y sus 
    pares clave-valor existentes con el operador spread (...). Recordar que 
    también funcionan en listas. Es decir, copia los mapas existentes con pares 
    clave-valor en este nuevo mapa (...state). */

    state = {
      ...state,
      /* Esto sobrescribirá el par clave-valor con el mismo 
      identificador del filtro que se ha copiado */
      filter: isActive,
    };

    /* El objetivo del state anterior, es actualizar uno de los filtros en este 
    mapa */
  }
}

/* VIDEO #187. Getting Started with Another Provider */
final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

/* 190. Connecting Multiple Providers With Each Other (Dependent Providers)
Vamos a crear otro Provider que gestionará las comidas filtradas. Para ésto, 
será un simple proveedor, ya que no se creará una nueva clase de FiltersNotifier 
como en filtersProvider. Es decir, un provider estándar. */
final filteredMealsProvider = Provider((ref) {
  /* Ahora, éste filteredMealsProvider depende de filtersProvider, ya que se 
    está implementando activeFilters. La forma de conectarlos es usando ref: */

  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
