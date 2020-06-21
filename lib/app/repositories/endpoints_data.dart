import 'package:covid19_live_tracker/app/services/api.dart';
import 'package:flutter/foundation.dart';

class EndpointsData
{
  EndpointsData({@required this.values});
  final Map<Endpoint, int> values;
  
  int get cases => values[Endpoint.cases];
  int get todayCases => values[Endpoint.todayCases];
  int get active => values[Endpoint.active];
  int get deaths => values[Endpoint.deaths];
  int get todayDeaths => values[Endpoint.todayDeaths];
  int get recovered => values[Endpoint.recovered];
  int get critical => values[Endpoint.critical];
  int get casesPerOneMillion => values[Endpoint.casesPerOneMillion];
  int get deathsPerOneMillion => values[Endpoint.deathsPerOneMillion];
  int get totalTests => values[Endpoint.totalTests];
  
  String toString() => 'Cases: $cases, Today''s Cases: $todayCases, Active: $active, Deaths: $deaths, Today''s Deaths: $todayDeaths, Recovered: $recovered, Critical: $critical, Cases Per One Million: $casesPerOneMillion, Deaths Per One Million: $deathsPerOneMillion, Total Tests (Not finished yet): $totalTests';
}