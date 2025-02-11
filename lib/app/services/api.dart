import 'package:covid19_live_tracker/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum Endpoint
{
  cases,
  todayCases,
  active,
  deaths,
  todayDeaths,
  recovered,
  critical,
  casesPerOneMillion,
  deathsPerOneMillion,
  totalTests,
}

class API
{
  API({@required this.apiKey});
  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  static final String host = "apigw.nubentos.com";
  static final int port = 443;
  static final String basePath = 't/nubentos.com/ncovapi/2.0.0';

  Uri tokenUri() => Uri // Used to create the URL
  (
    scheme: 'https',
    host: host,
    port: port,
    path: 'token',
    queryParameters: {'grant_type': 'client_credentials'},
  );

  Uri endpointUri(Endpoint endpoint) => Uri
  (
    scheme: 'https',
    host: host,
    port: port,
    path: '$basePath/${_paths[endpoint]}',
  );


  static Map<Endpoint, String> _paths = {
    Endpoint.cases: 'cases',
    Endpoint.todayCases: 'todayCases',
    Endpoint.active: 'active',
    Endpoint.deaths: 'deaths',
    Endpoint.todayDeaths: 'todayDeaths',
    Endpoint.recovered: 'recovered',
    Endpoint.critical: 'critical',
    Endpoint.casesPerOneMillion: 'casesPerOneMillion',
    Endpoint.deathsPerOneMillion: 'deathsPerOneMillion',
    Endpoint.totalTests: 'totalTests',
  };

}