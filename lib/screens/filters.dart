/* VIDEO #170. Adding a Filter Item */
import 'package:flutter/material.dart';
// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';

/* VIDEO #VIDEO #173. Returning Data When Leaving a Screen */
enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  /* VIDEO #175. Applying Filters */
  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  /* VIDEO #170. Adding a Filter Item
  Cuando el switch cambie, la UI debe cambiar, pot lo cual empleamos setState*/
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  /* VIDEO #175. Applying Filters 
  Lo que queremos hacer acá, es modificar los variables de los filtros y asignar
  los valores correspondientes de currentFilters, recordar que para usar 
  currentFilters que se encuentra en otra clase usamos la propiedad 
  widget:
      var _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree];
  Pero widget no se encuentra disponible al momento de inicializar la varible. 
  Por lo anterior, usaremos iniState: */
  @override
  void initState() {
    super.initState();
    /* No hay necesidad de llamar de nuevo setState ya que initState se 
    ejecutará antes del método Build */
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // /* VIDEO #171. Replacing Screens (Instead of Pushing)
      // Vamos a adicionar el mismo drawer en FiltersScreen, con el objetivo de
      // ELIMINAR el back button que aparece en el appBar */
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     /* VIDEO #171. Replacing Screens (Instead of Pushing)
      //     Al realizar la navegación de esta manera estaremos acumulando una pila
      //     de screens. Para solucionar eso, en ves de usar push, usaremos
      //     pushReplacement. Al implementarlo, estamos diciendo que TabsScreen
      //     no será empujado (push), sino que será reemplazado por FiltersScreen.
      //     Por lo tanto el BOTON DE RETROCESO no funcionaría porque no hay ningún
      //     lugar para volver*/
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (ctx) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),
      /* VIDEO #173. Returning Data When Leaving a Screen
       Usaremos PopScope ya que queremos HACER ALGO después de que el usuario 
       haya seleccionado los filtros y eso sucederá cuando presionamos ATRAS en 
       la pantalla, por eso, hacemos un wrap y usamos WillPopScope en toda la 
       columna. Este widget, me proporciona una función (onWillPop) que retorna 
       un futuro cada vez que el usuario intente salir de esta pantalla. 
       Añadiendo async, esta función devolverá un futuro que luego eventualmente
       resolverá el false */
      body: WillPopScope(
        onWillPop: () async {
          /* VIDEO #VIDEO #173. Returning Data When Leaving a Screen
          Recordar que Navigator.pop cierra la pantalla, pero hay una 
          configuración que podemos usar, y es pasar parámetros cuando ésta se 
          cierra y la pantalla que los recibe, sería TabsScreen. Los cuales, 
          serán los ENUM que declaramos al inicio*/
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
          return false; /*Se confirma o se niega si queremos navegar de vuelta, 
          será false ya que no queremos apareces dos veces en la pantalla porque
          si lo hacemos, cerraríamos nuestra pantalla*/
        },
        /* New code because WillPopScope is deprecated
        PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            if (didPop) return;
            Navigator.pop(context, {
              Filter.glutenFree: _glutenFreeFilterSet,
              Filter.lactoseFree: _lactoseFreeFilterSet,
              Filter.vegetarian: _vegetarianFilterSet,
              Filter.vegan: _veganFilterSet,
            });
          }, */
        child: Column(
          children: [
            /* VIDEO #170. Adding a Filter Item
            value recibe un booleano que controla cual switch está on u off  */
            SwitchListTile(
              value: _glutenFreeFilterSet,
              /* VIDEO #170. Adding a Filter Item
              Cuando el switch cambie, la UI debe cambiar, pot lo cual empleamos 
              setState*/
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              /* VIDEO #170. Adding a Filter Item
              Cuando el switch cambie, la UI debe cambiar, pot lo cual empleamos 
              setState*/
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianFilterSet,
              /* VIDEO #170. Adding a Filter Item
              Cuando el switch cambie, la UI debe cambiar, pot lo cual empleamos 
              setState*/
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _veganFilterSet,
              /* VIDEO #170. Adding a Filter Item
              Cuando el switch cambie, la UI debe cambiar, pot lo cual empleamos 
              setState*/
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
