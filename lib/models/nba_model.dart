import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Nba extends Equatable {
  final String id;
  final String name;
  final Image image;

  const Nba({
    required this.name,
    required this.image,
    required this.id,
  });

  @override
  List<Object> get props => [id, name, image];

  static List<Nba> nbas = [
    Nba(
        id: '0',
        name: 'Lebron James',
        image: Image.asset('assets/images/lebron.png', width: 40,)),
    Nba(
        id: '1',
        name: 'Gianis Antetokounmpo',
        image: Image.asset('assets/images/gianis.png', width: 40,)),
  ];
}
