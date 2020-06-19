import 'package:covid19_live_tracker/app/repositories/data_repository.dart';
import 'package:covid19_live_tracker/app/services/api_service.dart';
import 'package:covid19_live_tracker/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/services/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget 
{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
    return Provider<DataRepository>
    (
      create: (_) => DataRepository(apiService: APIService(API.sandbox())),
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

