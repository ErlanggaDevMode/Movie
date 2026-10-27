import 'package:flutter/material.dart';

Widget addVerticalSpace(double amount) {
  return SizedBox(height: amount);
}

Widget addHorizontalSpace(double amount) {
  return SizedBox(width: amount);
}

enum Sorting {
  aToZ(name: 'A-Z'),
  zToA(name: 'Z-A'),
  rating(name: 'Rating'),
  year(name: 'Year');

  const Sorting({required this.name});

  final String name;
}
