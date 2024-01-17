/* VIDEO #165. Adding Tab-based Navigation
The purpose of this screen is to show embedded screens */
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/widgets/main_drawer.dart';

/* VIDEO #175. Applying Filters
Reordar la letra K, es para definir una variable global */
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

/* VIDEO #183. Using a Provider
Tenemos que cambiar StatefulWidget a ConsumerStatefulWidget, si fuese 
StatelessWidget se cambiaría de manera diferente, por CosumerWidget*/
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  /* VIDEO #166. Passing Functions Through Multiple Layers of Widgets 
  (for State Management) */
  //final List<Meal> _favoriteMeals = [];

  /* VIDEO #175. Applying Filters
  Aquí vamos a añadir una nueva variable donde almacenaremos los filtros 
  seleccionados */
  //Map<Filter, bool> _selectedFilters = kInitialFilters;

  /* VIDEO #185. Using the FavoritesProvider
  Podemos deshacernos de este código, ya que no estamos manejando la lista 
  _favoriteMeals gracias a Provider*/

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   /*  Aquí, se verifica si el objeto meal está presente en la lista
  //   _favoriteMeals. Caso contrario, returna FALSE*/
  //   final isExisting = _favoriteMeals.contains(meal);

  //   if (isExisting) {
  //     /* Si es TRUE tenemos que remover la comida */
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Meal is no longer a favorite');
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //     });
  //     _showInfoMessage('Marked as favorite!');
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  /* VIDEO #169. Closing the Drawer Manually */
  /* VIDEO #174. Reading & Using Returned Data
  Como se había mencionado en el video 173, al cerrar FiltersScreeen por medio 
  de popScope, se está enviando información a ésta pantalla. Para leer o recibir
  estos datos, debemos ir al lugar dónde llamamos Push. Este método push, en 
  realidad devuelve un valor FUTURO, la obtenerlo se resuelven los datos 
  devueltos por la pantalla que navegamos. Es importante recordar que al momento
  de hacer un push en esta pila de pantallas, NO OBTENEMOS INMEDIATAMENTE de 
  vuelta esos datos ya que el usuario puede interactuar con esa pantalla y 
  pulsar el botón de retroceso al cabo de 10 seg o más, por eso se llama 
  FUTURO ya que no disponemos inmediatamente el valor de retorno. Por lo 
  anterior, añadimos ASYNC en el método y AWAIT*/
  void _setScreen(String identifier) async {
    /* VIDEO #171. Replacing Screens (Instead of Pushing) 
    En este caso, es importante tener en cuenta que aquí vamos a mostrar 
    TabsScreen y debemos tener en cuenta que ya estamos ubicados en dicha 
    pantalla. Por lo cual si accedemos al drawer y damos clic en algunas de las 
    dos opciones (MEALS or FILTERS), DEBEMOS cerrar el drawer.*/
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      /* VIDEO #171. Replacing Screens (Instead of Pushing) 
      Al realizar la navegación de esta manera estaremos acumulando una pila de 
      screens. Para solucionar eso, en ves de usar push, usaremos 
      pushReplacement. Al implementarlo, estamos diciendo que FiltersScreen no 
      será empujado (push), sino que será reemplazado por TabsScreen. Por lo 
      tanto el BOTON DE RETROCESO no funcionaría porque no hay ningún lugar para
      volver*/
      /* VIDEO #174. Reading & Using Returned Data
      Aquí explican el uso de await */

      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(
              //currentFilters: _selectedFilters,
              ),
        ),
      );
      /* VIDEO #174. Reading & Using Returned Data
      Aquí, result estará disponible y se establecerá los datos devueltos, En 
      push, podemos definir que tipo de valor será devuelto por medio de < >*/

      /* VIDEO #175. Applying Filters
      Almacenar los filtros de esta manera no es suficiente ya que debemos 
      asegurarnos de que el build se ejecute de nuevo, para que los filtros 
      actualizados o lista de comidas disponibles se pase a la pantalla. No a la
      pantalla MealsScreen sino a CategoriesScreen, ya que así está la lógica.*/

      /* El operador ?? comprueba si el valor delante de él es NULO y si es así,
      se utilizará el valor de reserva definido después de los signos de 
      interrogación. Es decir, este operador permite establecer un valor de 
      retorno condicional en caso de sea nulo */
      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    /* VIDEO #183. Using a Provider
    El objetivo es obtener las comidas (availableMeals) de Provider. Para eso 
    tenemos una nueva propiedad: ref. Lo que podemos hacer con ref es utilizar 
    métodos de utilidad, los más importantes son: read (obtener datos de nuestro
    Provider), watch (configurar un oyente que asegura de que el build se 
    ejecuta de nuevo cuando nuestros datos cambian). La documentación de 
    Riverpot, recomienda utilizar watch tan a menudo como sea posible, incluso 
    si necesita leer los datos una vez.
    Al escribrir ref.watch(mealsProvider) configuramos un listener que 
    re-ejecutará el build cada vez que mealsProvider cambie.
    Además con este listener, watch devuelve los datos del Provider que vigila. */
    //final meals = ref.watch(mealsProvider);
    /* VIDEO #175. Applying Filters
    Aquí estamos cargando la nueva lista con los filtros aplicados. */

    /* 188. Combining Local & Provider-managed State
    Recordar que watch configura un oyente (listener) que asegura de que el 
    build se ejecuta de nuevo cuando nuestros datos cambian. */
    //final activeFilters = ref.watch(filtersProvider);
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      // onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      /* VIDEO #185. Using the FavoritesProvider */
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
        // onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      /* VIDEO #168. Adding a Side Drawer */
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      /* VIDEO #165. Adding Tab-based Navigation
      El widget Scaffold permite establecer una barra de navegación 
      (NavigationBar)*/
      bottomNavigationBar: BottomNavigationBar(
        /* VIDEO #165. Adding Tab-based Navigation
        Cuando se da clic en algún elemento del Navigator, onTap es el encargado 
        de realizar la acción necesaria, además internamente le pasa un index, 
        para identificar a cual elemento se dió clic. Por lo anterior, el método 
        _selectPage recibe como argumento un index*/
        onTap: _selectPage,
        /* currentIndex controla la pestaña seleccionada */
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
