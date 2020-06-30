import 'package:covid19_live_tracker/app/repositories/data_repository.dart';
import 'package:covid19_live_tracker/app/services/api_service.dart';
import 'package:covid19_live_tracker/app/services/data_cache_service.dart';
import 'package:covid19_live_tracker/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/services/api.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance(); // Have the getInstance function for sharedPreferences (which is a future function) be ready before running the app
                                                                   // To use it synchronously when running it
  runApp(MyApp(sharedPreferences: sharedPreferences,));
}

class MyApp extends StatelessWidget 
{
  const MyApp({Key key, this.sharedPreferences}) : super(key: key);

  final SharedPreferences sharedPreferences;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
    return Provider<DataRepository>
    (
      create: (_) => DataRepository(apiService: APIService(API.sandbox()), dataCacheService: DataCacheService(sharedPreferences)),
      child: MaterialApp
      (
        debugShowCheckedModeBanner: false,
        title: 'COVID-19 Live Tracker',
        theme: ThemeData.dark().copyWith
        (
          scaffoldBackgroundColor: Color(0xFF000000),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard()
      ),
      
    );
  }
}

