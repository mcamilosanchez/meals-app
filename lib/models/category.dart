/* VIDEO #154. Widgets vs Screens
Category no será un widget, será un blueprint para un objeto normal */
import 'package:flutter/material.dart';

class Category {
/* Recordar que en el constructor inicializamos los objetos y establecemos sus 
propiedades */
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });

  final String id;
  final String title;
  final Color color;
}
