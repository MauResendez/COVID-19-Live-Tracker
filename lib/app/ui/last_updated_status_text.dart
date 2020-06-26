import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdatedDateFormatter
{
  final DateTime lastUpdated;

  LastUpdatedDateFormatter(@required this.lastUpdated);

  String lastUpdatedStatusText()
  {
    if (lastUpdated != null)
    {
      final formatter = DateFormat.yMd().add_Hms(); // Assigns a formatter to use on a string
      final formatted = formatter.format(lastUpdated);
      return 'Last updated: $formatted'; // Uses intl package to change the date format
    }

    return ''; // If null, just send an empty string
  }
}

class LastUpdatedStatusText extends StatelessWidget 
{
  final String text;

  const LastUpdatedStatusText({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return Padding
    (
      padding: const EdgeInsets.all(8.0),
      child: Text
      (
        text, textAlign: TextAlign.center,
      ),
    );
  }
}