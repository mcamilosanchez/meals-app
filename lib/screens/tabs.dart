/* VIDEO #165. Adding Tab-based Navigation
The purpose of this screen is to show embedded screens */
import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  /* VIDEO #166. Passing Functions Through Multiple Layers of Widgets 
  (for State Management) */
  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    /*  Aquí, se verifica si el objeto meal está presente en la lista 
    _favoriteMeals. Caso contrario, returna FALSE*/
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      /* Si es TRUE tenemos que remover la comida */
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Marked as favorite!');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  /* VIDEO #169. Closing the Drawer Manually */
  void _setScreen(String identifier) {
    if (identifier == 'filters') {
    } else {
      /* VIDEO #169. Closing the Drawer Manually
      En este caso, es importante tener en cuenta que aquí vamos a mostrar 
      TabsScreen y debemos tener en cuenta que ya estamos ubicados en dicha 
      pantalla. Por lo cual si accedemos al drawer y damos clic a Meals, DEBEMOS 
      cerrar el drawer*/
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
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
