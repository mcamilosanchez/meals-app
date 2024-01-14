import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

/* 182. Creating a Provider 
Creamos una variable "mealsProvider" donde va a almacenar el objeto Provider 
para que lo podamos usar en cualquier parte. Necesita un argumento, una función 
que reciba como argumento un objeto de tipo Provider (se llamará ref). Dentro de 
esta función, debemos devolver (return) el valor que queremos proporcionar*/
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
