import 'package:covid19_live_tracker/app/services/api.dart';
import 'package:covid19_live_tracker/app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository
{
  DataRepository({@required this.apiService});

  final APIService apiService;
  String _accessToken;

  Future<int> getEndpointData(Endpoint endpoint) async
  {
    try
    {
      if(_accessToken == null) // if accessToken hasn't been given yet, call getAccessToken function to get it
      {
        _accessToken = await apiService.getAccessToken();
      }

      return await apiService.getEndpointData(accessToken: _accessToken, endpoint: endpoint); // set the endpoint and accessToken to the apiService object
    }
    on Response catch (response)
    {
      if (response.statusCode == 401) // if unauthorized, access token has expired
      {
        if(_accessToken == null)
        {
          _accessToken = await apiService.getAccessToken();
        }

        return await apiService.getEndpointData(accessToken: _accessToken, endpoint: endpoint);
      }
      rethrow;
    }
    

  }
}