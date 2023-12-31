import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; // location name for the UI
  late String time; // time in that location
  String flag; // url to tan asset flag icon
  String url; // location url for api endpoint
  late bool isDaytime; // true or false if daytime or not

  WorldTime({
    required this.location,
    required this.flag,
    required this.url
  });

  Future<void> getTime() async{

    try{
      // make the request
      Uri url = Uri.parse('http://worldtimeapi.org/api/${this.url}');
      Response response = await get(url);
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'];
      //print(datetime);
      //print(offset);

      // convert datetime to a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset.substring(1, 3))));

      // set the time property
      time = DateFormat.jm().format(now);

      // set isDaytime to true if time is between 6:00 AM and 8:00 PM
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    }
    catch(e){
      time = "could not get time data";
      isDaytime = false;
    }

  }

}
