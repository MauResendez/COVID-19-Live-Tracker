import 'package:covid19_live_tracker/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndpointCardData
{
  EndpointCardData(this.title, this.assetName, this.color);

  final String title;
  final String assetName;
  final Color color;
}

class EndpointCard extends StatelessWidget 
{
  const EndpointCard({Key key, this.endpoint, this.value}) : super(key: key);
  final Endpoint endpoint; // For what data category we want to show
  final int value; // For the data given to us

  static Map<Endpoint, EndpointCardData> cardsData = 
  {
    Endpoint.cases: EndpointCardData('Cases', 'assets/count.png', Color(0xFFFFF492)),
    Endpoint.todayCases: EndpointCardData("Today's Cases", 'assets/count.png', Color(0xFFFFF492)),
    Endpoint.active: EndpointCardData('Active', 'assets/count.png', Color(0xFFFFF100)),
    Endpoint.deaths: EndpointCardData('Deaths', 'assets/death.png', Color(0xFFE40000)),
    Endpoint.todayDeaths: EndpointCardData("Today's Deaths", 'assets/death.png', Color(0xFFE40000)),
    Endpoint.recovered: EndpointCardData('Recovered', 'assets/patient.png', Color(0xFF32CD32)),
    Endpoint.critical: EndpointCardData('Critical', 'assets/fever.png', Color(0xFFE99600)),
    Endpoint.casesPerOneMillion: EndpointCardData("Cases Per One Million", 'assets/count.png', Color(0xFFFFF492)),
    Endpoint.deathsPerOneMillion: EndpointCardData("Deaths Per One Million", 'assets/death.png', Color(0xFFE40000)),
    Endpoint.totalTests: EndpointCardData("Total Tests (Not finished yet)", 'assets/patient.png', Color(0xFF70A9FF)),
  };

  String get formattedValue
  {
    if(value == null)
    {
      return '';
    }

    return NumberFormat('#,###,###,###').format(value);
  }
  
  @override
  Widget build(BuildContext context) 
  {
    final cardData = cardsData[endpoint];

    return Padding
    (
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card
      (
        child: Padding
        (
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>
            [
              Text(cardData.title, style: Theme.of(context).textTheme.headline.copyWith(color: cardData.color)),
              SizedBox
              (
                height: 4
              ),
              SizedBox
              (
                height: 52,
                child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    Image.asset(cardData.assetName, color: cardData.color),
                    Text(formattedValue, style: Theme.of(context).textTheme.display1.copyWith(color: cardData.color, fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}