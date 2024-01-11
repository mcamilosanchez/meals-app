/* VIDEO #161. Introducing the Stack Widget */
import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;
  /* VIDEO #163. Adding Navigation to the MealDetails Screen */
  final void Function(Meal meal) onSelectMeal;

  String get complexityText {
    /* VIDEO #162. Improving the MealItem Widget
    Hacemos un getter ya que complexity es un enum.
    Aquí estamos devolviendo la primer caracter [0] de name en mayúscula. 
    Substring devuelve una parte de la cadena en el inicio, estoy diciendo que 
    inicie la cadena a partir de la segunda letra (1)*/
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    /* VIDEO #162. Improving the MealItem Widget
    Hacemos un getter ya que affordability es un enum.
    Aquí estamos devolviendo la primer caracter [0] de name en mayúscula. 
    Substring devuelve una parte de la cadena en el inicio, estoy diciendo que 
    inicie la cadena a partir de la segunda letra (1)*/
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      /* VIDEO #161. Introducing the Stack Widget
        Stack no permite el borderRadius, para esto usamos clipBehavior. Lo que 
        hace es recortar el widget Stack, eliminando cualquier contenido de 
        widgets hijos que se salieran de los límites
        */
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          /* VIDEO #163. Adding Navigation to the MealDetails Screen */
          onSelectMeal(meal);
        },
        /* VIDEO #161. Introducing the Stack Widget
        Stack es un widget que se puede usar para colocar varios widgets uno 
        encima del otro, pero NO uno encima del otro, como lo hacíamos en Column
        */
        child: Stack(
          children: [
            /* VIDEO #161. Introducing the Stack Widget 
            Aquí vamos a añadir todos los widgets que deben colocarse uno encima 
            del otro. Aquí vamos a usar una característica, imagen transparente. 
            Para hacerlo debemos escribir lo siguiente en la consola: 
            flutter pub add transparent_image */
            /* IMPORTANTE: RECORDAR QUE EL PRIMER WIDGET EN CHILDREN, SERÁ EL 
            MÁS INFERIOR */
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              /* VIDEO #161. Introducing the Stack Widget
              BoxFit asegura que la imagen NUNCA SE DISTORSIONA, sino que se 
              recorta y se amplía un poco, si de otro modo no cabría en la caja
              */
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity, //usa todo el espacio horizontal
            ),
            /* VIDEO #161. Introducing the Stack Widget 
            Para posicionar un widget encima de otro widget dentro de una pila 
            en Stack, usamoa el widget Positioned */
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      /* softWrap asegura de que el texto se envuelve de una 
                      buena manera */
                      softWrap: true,
                      /* overFlow controla cómo se cortará el texto si es 
                      necesario cortarlo si es demasiado largo, porque podría 
                      ocupar más de dos líneas (maxLines). Ellipsis asegura que 
                      si el texto es demasiado largo. lo cortaría añadiendo tres 
                      puntos*/
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      //Vamos a centrar el row
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /* VIDEO #162. Improving the MealItem Widget
                        Como vamos a repetir la combinación de un ícono y texto 
                        tres veces, tiene sentido crear un widget personalizado. 
                        MealItemTrait devuelve un row, pero como lo estamos 
                        llamando dentro de otro row, debería aparecer un error y
                        se puede solucionar usando Expanded, pero no es 
                        necesario ya que este widget está dentro de un 
                        Positioned y este obliga al hijo (Container) a tomar 
                        exactamente el left y right. Por lo tanto, esta fila no 
                        está sin RESTRICCIONES horizontales y no tiene ningún 
                        problema con otra fila dentro de ella. */
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
