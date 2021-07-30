import 'dart:async';
import 'dart:convert';
import '../models/session_by_district.dart';
import '../models/session_model.dart';

import 'package:http/http.dart' as http;

class CovidSessionAvailabilityController {
  String calendarByDisctrict = '';
  //cowin api calls function
  int apiCalled = 1;

  Stream<CovidSession> fetchSlotsForPincodeAndDateProvided(
      String pinCode, String date) async* {
    //api limit
    //100 API calls per 5 minutes per IP
    //means 20 API calls per minute per IP

    while (true) {
      final response = await http.get(Uri.parse(
          'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin?pincode=$pinCode&date=$date'));

      if (response.statusCode == 200) {
        print('api called $apiCalled times');
        apiCalled++;
        yield CovidSession.fromJson(jsonDecode(response.body));
        print('Last fethced : ${DateTime.now()}');
      } else {
        //print error code
        print('${response.statusCode}');
        break; //break stream if some error occurs
      }
      //delay the api as COWIN api has a cap mention on line `[11]`
      await Future.delayed(Duration(minutes: 1));
    }
  }

  String fetchDateToday() {
    var instance = DateTime.now();
    var month = instance.month.toString();
    var day = instance.day.toString();
    var year = instance.year.toString();
    return '$day-$month-$year';
  }

  Stream<String> currentDate() async* {
    while (true) {
      yield fetchDateToday();
    }
  }

  Stream<SessionsByDistrict> showSlotsByDistrictOfOneWeek(
      String districtCode) async* {
    //api limit
    //100 API calls per 5 minutes per IP
    //means 20 API calls per minute per IP

    while (true) {
      var currentDate = fetchDateToday();
      print('Date Today $currentDate');
      final response = await http.get(Uri.parse(
          'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=$districtCode&date=$currentDate'));
      if (response.statusCode == 200) {
        print('api called $apiCalled times');
        apiCalled++;
        yield SessionsByDistrict.fromJson(jsonDecode(response.body));
      } else {
        print('${response.statusCode}');
        break;
      }
      await Future.delayed(Duration(seconds: 10));
    }
  }
}
