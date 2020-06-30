import 'package:covid19_live_tracker/app/repositories/endpoints_data.dart';
import 'package:covid19_live_tracker/app/services/api.dart';
import 'package:covid19_live_tracker/app/services/api_service.dart';
import 'package:covid19_live_tracker/app/services/data_cache_service.dart';
import 'package:covid19_live_tracker/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository
{
  DataRepository({@required this.apiService, @required this.dataCacheService});

  final APIService apiService;
  final DataCacheService dataCacheService;
  String _accessToken;

  Future<EndpointData> getEndpointData(Endpoint endpoint) async =>
      await _getDataRefreshingToken<EndpointData>
      (
        onGetData: () => apiService.getEndpointData
        (
            accessToken: _accessToken, endpoint: endpoint
        ),
      );

  EndpointsData getAllEndpointsCachedData() => dataCacheService.getData();

  Future<EndpointsData> getAllEndpointsData() async 
  {
      final endpointsData = await _getDataRefreshingToken<EndpointsData>
      (
        onGetData: _getAllEndpointsData,
      );

      // save on cache
      await dataCacheService.setData(endpointsData);
      return endpointsData;
  }

  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async 
  {
    try 
    {
      if (_accessToken == null) 
      {
        _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) 
    {
      // if unauthorized, get access token again
      if (response.statusCode == 401) 
      {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }


  Future<EndpointsData> _getAllEndpointsData() async
  {
    final values = await Future.wait([ // Future.wait does all async function calls at the same time instead of having to do it one by one and putting each result into a variable which would take long
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.todayCases),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.active),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.todayDeaths),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.recovered),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.critical),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.casesPerOneMillion),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.deathsPerOneMillion),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.totalTests),
    ]);

    return EndpointsData
    (
      values: 
      {
        Endpoint.cases: values[0],
        Endpoint.todayCases: values[1],
        Endpoint.active: values[2],
        Endpoint.deaths: values[3],
        Endpoint.todayDeaths: values[4],
        Endpoint.recovered: values[5],
        Endpoint.critical: values[6],
        Endpoint.casesPerOneMillion: values[7],
        Endpoint.deathsPerOneMillion: values[8],
        Endpoint.totalTests: values[9],
      } 
    );
  }
}