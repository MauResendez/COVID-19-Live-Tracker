import 'package:covid19_live_tracker/app/repositories/endpoints_data.dart';
import 'package:covid19_live_tracker/app/services/api.dart';
import 'package:covid19_live_tracker/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheService
{
  DataCacheService(@required this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  static String endpointValueKey(Endpoint endpoint) => '$endpoint/value';
  static String endpointDateKey(Endpoint endpoint) => '$endpoint/date';

  EndpointsData getData()
  {
    Map<Endpoint, EndpointData> values = {};
    Endpoint.values.forEach((endpoint)
    {
      final value = sharedPreferences.getInt(endpointValueKey(endpoint));
      final dateString = sharedPreferences.getString(endpointDateKey(endpoint));

      if(value != null && dateString != null)
      {
        final date = DateTime.tryParse(dateString);
        values[endpoint] = EndpointData(value, date);
      }
    });

    return EndpointsData(values: values);
  }
  
  Future<void> setData(EndpointsData endpointsData) async 
  {
    endpointsData.values.forEach((endpoint, endpointData) async
    {
      await sharedPreferences.setInt(endpointValueKey(endpoint), endpointData.value);
      await sharedPreferences.setString(endpointDateKey(endpoint), endpointData.date.toIso8601String());
    });
  }
}