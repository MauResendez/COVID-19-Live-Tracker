import 'dart:convert';

import 'package:covid19_live_tracker/app/services/api.dart';
import 'package:covid19_live_tracker/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService
{
  APIService(this.api);
  final API api;

  Future<String> getAccessToken() async
  {
    final response = await http.post
    (
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );

    if(response.statusCode == 200)
    {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];

      if(accessToken != null)
      {
        return accessToken;
      }
    }
    else if(response.statusCode == 401) // To debug any error
    {
      final data = json.decode(response.body);
      print(data["access_token"]);
      print(api.apiKey);
      print(api.tokenUri().toString());
    }
    print('Request ${api.tokenUri()} failed \nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  Future<EndpointData> getEndpointData
  ({
      @required String accessToken,
      @required Endpoint endpoint,
  }) 
  async 
  {
    final uri = api.endpointUri(endpoint);
    final response = await http.get
    (
      uri.toString(),
      headers: { 'Authorization': 'Bearer $accessToken'},
    );

    if(response.statusCode == 200)
    {
      final List<dynamic> data = json.decode(response.body); // Puts it into a list since each GET request we get is in square brackets meaning it can easily be put into a list

      if(data.isNotEmpty)
      {
        final Map<String, dynamic> endpointData = data[0]; // Gets the data from the first and only element on the list and puts it into a map

        final String responseJsonKey = _responseJsonKeys[endpoint];

        final int result = endpointData[responseJsonKey];

        final String dateString = endpointData["date"];

        final date = DateTime.tryParse(dateString); // tryParse parses the dateString given from the API and can give a error message/exception if the string can't be parsed 

        if(result != null)
        {
          return EndpointData(result, date);
        }
      }
    }
    print('Request $uri failed \nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  static Map<Endpoint, String> _responseJsonKeys =
  {
    Endpoint.cases: 'data',
    Endpoint.todayCases: 'data',
    Endpoint.active: 'data',
    Endpoint.deaths: 'data',
    Endpoint.todayDeaths: 'data',
    Endpoint.recovered: 'data',
    Endpoint.critical: 'data',
    Endpoint.casesPerOneMillion: 'data',
    Endpoint.deathsPerOneMillion: 'data',
    Endpoint.totalTests: 'data',
  };
}