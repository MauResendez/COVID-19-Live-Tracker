import 'package:covid19_live_tracker/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget 
{
  const EndpointCard({Key key, this.endpoint, this.value}) : super(key: key);
  final Endpoint endpoint; // For what data category we want to show
  final int value; // For the data given to us

  static Map<Endpoint, String> cardTitles = 
  {
    Endpoint.cases: 'Cases',
    Endpoint.todayCases: "Today's Cases",
    Endpoint.active: 'Active',
    Endpoint.deaths: 'Deaths',
    Endpoint.todayDeaths: "Today's Deaths",
    Endpoint.recovered: 'Recovered',
    Endpoint.critical: 'Critical',
    Endpoint.casesPerOneMillion: 'Cases Per One Million',
    Endpoint.deathsPerOneMillion: 'Deaths Per One Million',
    Endpoint.totalTests: 'Total Tests (Not finished yet)',
  };
  
  @override
  Widget build(BuildContext context) 
  {
    return Padding
    (
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card
      (
        child: Padding
        (
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row
          (
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>
            [
              Text(cardTitles[endpoint], style: Theme.of(context).textTheme.headline),
              Text(value != null ? value.toString() : '', style: Theme.of(context).textTheme.display1),
            ],
          ),
        ),
      ),
    );
  }
}