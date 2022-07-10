import 'package:flutter/material.dart';

abstract class EntityList extends StatelessWidget {
  final Axis scrollDirection;
  const EntityList({super.key, required this.scrollDirection});
}
