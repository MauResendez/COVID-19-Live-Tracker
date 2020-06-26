import 'package:flutter/foundation.dart';

class EndpointData
{
  final int value;
  final DateTime date;

  EndpointData(@required this.value, this.date);

  String toString() => 'date $date, value $value';
}

