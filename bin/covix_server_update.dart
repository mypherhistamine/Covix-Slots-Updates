import 'controllers/covid_updates_controller.dart';
import 'controllers/discord_alerter.dart';
import 'models/center_found_model.dart';

import 'models/session_model.dart';

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
                singleSession.availableCapacityDose2! > 0) {
              // print('Time Fetched - ${DateTime.now()}');
              // print('Center Name: ${center.name}');
              // print('Pin Code: ${center.name}');
              // print('Date - ${singleSession.date}');
              // print('Dose 1 Seats - ${singleSession.availableCapacityDose1}');
              // print('Vaccine Name : ${singleSession.vaccineName}');
              // print(
              //     'Age Limit ${singleSession.minAgeLimit} - ${singleSession.maxAgeLimit}');
              // print('All ages ${singleSession.allowAllAge}');
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

  // District controller slots
  controller.showSlotsByDistrictOfOneWeek('146').listen(
    (centers) {
      centers.centers!.forEach(
        (singleCenters) {
          singleCenters.sessions!.forEach((singleSession) {
            if (
                // singleSession.availableCapacity! > 0 &&
                singleCenters.feeType == 'Free' &&
                    singleSession.availableCapacityDose2! > 0 &&
                    (singleSession.vaccine == 'COVISHIELD' ||
                        singleSession.vaccine == 'COVAXIN') &&
                    (singleCenters.pincode == 110084 ||
                        singleCenters.pincode == 110009 ||
                        singleCenters.pincode == 110007)) {
              centersFound.add(
                VacCenterFound(
                  allAges: singleSession.allowAllAge.toString(),
                  centerName: singleCenters.name,
                  // date: singleSession.date,
                  dose1: singleSession.availableCapacityDose1.toString(),
                  maxAgeLimit: singleSession.maxAgeLimit.toString(),
                  minAgeLimit: singleSession.minAgeLimit.toString(),
                  pinCode: singleCenters.pincode.toString(),
                  date: singleSession.date.toString(),
                  vaccineName: singleSession.vaccine,
                  dose2: singleSession.availableCapacityDose2.toString(),
                  timeFetched: DateTime.now().toLocal().toString(),
                  // vaccineName: singleSession.vaccineName,
                ),
              );
              slotFound = true;
              // covidMailer.sendMailToUser();
            }
          });
          //applying the filters
        },
      );
      if (slotFound) {
        print(
            'Found ${centersFound.length} centers sending message to Discord');
        sendAlertToDiscordChannel.sendCentersMessageOnDiscord(
            centers: centersFound,
            timeFetched: DateTime.now().toString().substring(0, 16));
        centersFound.clear();
        slotFound = false;
      }
    },
  );
}
