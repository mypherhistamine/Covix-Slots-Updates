import 'controllers/covid_updates_controller.dart';
import 'controllers/discord_alerter.dart';
import 'models/center_found_model.dart';
import 'models/session_by_district.dart';
import 'models/session_model.dart';
import 'package:http/http.dart' as http;

void main(List<String> arguments) {
  var sendAlertToDiscordChannel = DiscordAlerter();
  var controller = CovidSessionAvailabilityController();
  var slotFound = false;
  //list of centers found
  List<VacCenterFound> centersFound = [];

  //listen to slot changes
  void pinCodeSlotsHandler(CovidSession centers) {
    centers.centers!.forEach(
      (center) {
        center.sessions!.forEach(
          (singleSession) {
            //applying the filters
            if (singleSession.availableCapacity! > 0 &&
                center.feeType == 'Free' &&
                singleSession.availableCapacityDose1! > 0) {
              print('Time Fetched - ${DateTime.now()}');
              print('Center Name: ${center.name}');
              print('Pin Code: ${center.name}');
              print('Date - ${singleSession.date}');
              print('Dose 1 Seats - ${singleSession.availableCapacityDose1}');
              print('Vaccine Name : ${singleSession.vaccineName}');
              print(
                  'Age Limit ${singleSession.minAgeLimit} - ${singleSession.maxAgeLimit}');
              print('All ages ${singleSession.allowAllAge}');
              centersFound.add(
                VacCenterFound(
                    allAges: singleSession.allowAllAge.toString(),
                    centerName: center.name,
                    date: singleSession.date,
                    dose1: singleSession.availableCapacityDose1.toString(),
                    maxAgeLimit: singleSession.maxAgeLimit.toString(),
                    minAgeLimit: singleSession.minAgeLimit.toString(),
                    pinCode: center.pincode.toString(),
                    timeFetched: DateTime.now().toLocal().toString(),
                    vaccineName: singleSession.vaccineName),
              );
              slotFound = true;
              // covidMailer.sendMailToUser();
            }
          },
        );
      },
    );
  }

  //listen to slot changes
  void districtWiseSlotHandler(CovidSessionByDistrict centers) {
    centers.sessions!.forEach(
      (singleSession) {
        //applying the filters
        if (
            // singleSession.availableCapacity! > 0 &&
            singleSession.feeType == FeeType.FREE
            // &&
            // singleSession.availableCapacityDose2! > 0
            ) {
          print('Time Fetched - ${DateTime.now()}');
          print('Center Name: ${singleSession.name}');
          print('Pin Code: ${singleSession.pincode}');
          print('Date - ${singleSession.date}');
          print('Dose 1 Seats - ${singleSession.availableCapacityDose1}');
          print('Dose 2 Seats - ${singleSession.availableCapacityDose2}');
          // print('Vaccine Name : ${singleSession.vaccineName}');
          print(
              'Age Limit ${singleSession.minAgeLimit} - ${singleSession.minAgeLimit}');
          print('All ages ${singleSession.allowAllAge}');
          centersFound.add(
            VacCenterFound(
              allAges: singleSession.allowAllAge.toString(),
              centerName: singleSession.name,
              // date: singleSession.date,
              dose1: singleSession.availableCapacityDose1.toString(),
              maxAgeLimit: singleSession.maxAgeLimit.toString(),
              minAgeLimit: singleSession.minAgeLimit.toString(),
              pinCode: singleSession.pincode.toString(),
              timeFetched: DateTime.now().toLocal().toString(),
              // vaccineName: singleSession.vaccineName,
            ),
          );
          slotFound = true;
          // covidMailer.sendMailToUser();
        }
      },
    );
    if (slotFound) {
      sendAlertToDiscordChannel.testWebHook(centers: centersFound);
      centersFound.clear();
      slotFound = false;
    }
  }

  //PinCode controller slots
  // controller
  //     .fetchSlotsForPincodeAndDateProvided('110085', '27-07-2021')
  //     .listen((event) => pinCodeSlotsHandler(event));

  // District controller slots
  controller
      .showSlotsByDistrictOfOneWeek('147', '29-07-2021')
      .listen((event) => districtWiseSlotHandler(event));
}
