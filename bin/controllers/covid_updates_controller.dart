import 'dart:async';
import 'dart:convert';
import '../models/session_by_district.dart';
import '../models/session_model.dart';

import 'package:http/http.dart' as http;

class CovidSessionAvailabilityController {
  String calendarByDisctrict = '';
  //cowin api calls function
  int apiCalled = 0;

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

  Stream<CovidSessionByDistrict> showSlotsByDistrictOfOneWeek(
      String pinCode, String date) async* {
    //api limit
    //100 API calls per 5 minutes per IP
    //means 20 API calls per minute per IP

    while (true) {
      final response = await http.get(Uri.parse(
          'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=$pinCode&date=$date'));
      if (response.statusCode == 200) {
        print('api called $apiCalled times');
        apiCalled++;
        yield CovidSessionByDistrict.fromJson(jsonDecode(response.body));
        // print('Last fethced : ${DateTime.now()}');
        // print('${response.body}');
      } else {
        //print error code
        print('${response.statusCode}');
        break; //break stream if some error occurs
      }
      //delay the api as COWIN api has a cap mention on line `[11]`
      await Future.delayed(Duration(seconds: 10));
    }
  }
}
