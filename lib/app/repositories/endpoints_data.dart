import 'package:covid19_live_tracker/app/services/api.dart';
import 'package:covid19_live_tracker/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';

class EndpointsData
{
  EndpointsData({@required this.values});
  final Map<Endpoint, EndpointData> values;
  
  EndpointData get cases => values[Endpoint.cases];
  EndpointData get todayCases => values[Endpoint.todayCases];
  EndpointData get active => values[Endpoint.active];
  EndpointData get deaths => values[Endpoint.deaths];
  EndpointData get todayDeaths => values[Endpoint.todayDeaths];
  EndpointData get recovered => values[Endpoint.recovered];
  EndpointData get critical => values[Endpoint.critical];
  EndpointData get casesPerOneMillion => values[Endpoint.casesPerOneMillion];
  EndpointData get deathsPerOneMillion => values[Endpoint.deathsPerOneMillion];
  EndpointData get totalTests => values[Endpoint.totalTests];
  
  String toString() => 'Cases: $cases, Today''s Cases: $todayCases, Active: $active, Deaths: $deaths, Today''s Deaths: $todayDeaths, Recovered: $recovered, Critical: $critical, Cases Per One Million: $casesPerOneMillion, Deaths Per One Million: $deathsPerOneMillion, Total Tests (Not finished yet): $totalTests';
}