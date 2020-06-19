import 'package:covid19_live_tracker/app/repositories/data_repository.dart';
import 'package:covid19_live_tracker/app/services/api.dart';
import 'package:covid19_live_tracker/app/ui/endpoint_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget
{
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
{
  int _cases; // The cases we are going to display in the dashboard

  void initState() // Initializes the states of the page everytime it's shown
  {
    _updateData();
    super.initState();
  }

  Future<void> _updateData() async
  {
    final dataRepository = Provider.of<DataRepository>(context, listen: false); // Have a data repository object ready to be able to retrieve data from it, depending on endpoint
    final cases = await dataRepository.getEndpointData(Endpoint.cases);
    setState(() => _cases = cases); // Updates number when refreshed
  }

  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text("COVID-19 Live Tracker"),
      ),
      body: RefreshIndicator
      (
        onRefresh: _updateData,
        child: ListView
        (
          children: <Widget>
          [
            EndpointCard(endpoint: Endpoint.cases, value: _cases)
          ],
        ),
      )
    );
  }
}