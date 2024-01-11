import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
  });

  final void Function(Meal meal) onToggleFavorite;

  /* 159. Adding Cross-Screen Navigation
  Aquí estamos haciendo algo que no habíamos hecho antes: estamos añadiendo un 
  método a un StatelessWidget. Lo habíamos hecho anteriormente, pero para 
  actualizar el estado en un StateFullWidget, pero en _selectCategory NO 
  QUEREMOS ACTUALIZAR EL ESTADO, se quiere cargar una pantalla diferente. */
  void _selectCategory(BuildContext context, Category category) {
    /* VIDEO #160. Passing Data to the Target Screen
    Estamos creando una lista filtrada, dónde _selectCategory necesitará otro 
    argumento "category" ya que se necesita saber qué categoria se seleccionó. 
    Caso de no entender, ver el video*/
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    /* 159. Adding Cross-Screen Navigation
    Para cargar una nueva pantalla usamos Navigator.push). Lo que hace al final,
    es empujar route (2do argumento) que será una especie de widget EN LA PARTE 
    SUPERIOR DE LA PILA ACTUAL DE PANTALLAS */
    /* 159. Adding Cross-Screen Navigation
    Como estoy en un StatelessWidget, el CONTEXTO no está disponible 
    globalmente. Por lo tanto, debemos aceptar un valor de contexto en 
    _selectCategory de tipo BuildContext. Otra forma, de hacer esto:
    Navigator.push(context, route);
    Por último, en route se mostrará el widget*/
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(context) {
    /* VIDEO #153. Using a GridView
    Cuando queremos implementar múltiples pantallas, es recomendable usar 
    Scaffold. */
    /* VIDEO #165. Adding Tab-based Navigation
    Aquí anteriormente, había un Scaffold (después del return) pero lo 
    eliminamos debido a que TabScreen (tabs.dart) ya estaba usando uno con 
    AppBar */
    return GridView(
      padding: const EdgeInsets.all(24),
      /* VIDEO #153. Using a GridView
        gridDelegate controla la disposición de los elementos. 
        SliverGridDelegateWithFixedCrossAxisCount establece el número de 
        columnas horizontales que deseo obtener. childAspectRatio define el 
        tamaño de los elementos del gridView */
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        //Espacio horizontal entre las columnas
        crossAxisSpacing: 20,
        // Espacio vertical entre las columnas
        mainAxisSpacing: 20,
      ),
      children: [
        /* VIDEO #155. Displaying Category Items on a Screen
          Realizamos un loop por medio de los elementos que se encuentran en 
          availableCategories y los estructuramos visualmente por medio de la 
          clase CategoryGridItem. Esta sería otra alternativa para de realizar 
          el recorrido:
          availableCategories.map(
            (category) => CategoryGridItem(category: category)
            ).toList() */
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectedCategory: () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
