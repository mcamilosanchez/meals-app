import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectedCategory,
  });

  final Category category;
  final void Function() onSelectedCategory;

  @override
  Widget build(context) {
    /* VIDEO #156. Making any Widget Tappable with InkWell
    Para hacer tappable el siguiente contenedor o cualquier otro widget, 
    realizaremos un wrap sobre este y usamos InkWell. Se recomienda usar este y 
    no GestureDetector, ya que InkWell tiene mejor respuesta visual. */
    return InkWell(
      onTap: onSelectedCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            /* VIDEO #155. Displaying Category Items on a Screen
            Define dónde empieza y acaba el gradiente */
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          /* VIDEO #155. Displaying Category Items on a Screen
          Ver el video si no entiende la asignación de los temas */
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
