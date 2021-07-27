import 'dart:math';

import 'controllers/covid_updates_controller.dart';
import 'controllers/mail_controller.dart';
import 'models/center_found_model.dart';
import 'models/session_model.dart';

void main(List<String> arguments) {
  var covidMailer = CustomMailer();
  var controller = CovidSessionAvailabilityController();

  //list of centers found
  List<VacCenterFound> centersFound = [];

  //listen to slot changes
  void onSnapshostHandler(CovidSession centers) {
    centers.centers!.forEach(
      (center) {
        center.sessions!.forEach(
          (singleSession) {
            //applying the filters
            if (singleSession.availableCapacity! > 0 &&
                center.feeType == 'Free' &&
                singleSession.availableCapacityDose2! > 0) {
              print('Time Fetched - ${DateTime.now()}');
              print('Center Name: ${center.name}');
              print('Pin Code: ${center.name}');
              print('Date - ${singleSession.date}');
              print('Dose 1 Seats - ${singleSession.availableCapacityDose1}');
              print('Vaccine Name : ${singleSession.vaccineName}');
              print(
                  'Age Limit ${singleSession.minAgeLimit} - ${singleSession.maxAgeLimit}');
              print('All ages ${singleSession.allowAllAge}');
              // centersFound.add(VacCenterFound(
              //     allAges: singleSession.allowAllAge.toString(),
              //     centerName: center.name,
              //     date: singleSession.date,
              //     dose1: singleSession.availableCapacityDose1.toString(),
              //     maxAgeLimit: singleSession.maxAgeLimit.toString(),
              //     minAgeLimit: singleSession.minAgeLimit.toString(),
              //     pinCode: center.pincode.toString(),
              //     timeFetched: DateTime.now().toLocal().toString(),
              //     vaccineName: singleSession.vaccineName));

              // covidMailer.sendMailToUser();
            }

            //send email to the user if slot found
            covidMailer.sendMailToUser(centersFound);
            //then make the slot false
          },
        );
      },
    );
  }

  controller
      .fetchSlotsForPincodeAndDateProvided('110085', '27-07-2021')
      .listen((event) => onSnapshostHandler(event));
}
