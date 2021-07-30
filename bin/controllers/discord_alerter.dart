import 'dart:async';

import '../env.dart';
import 'package:http/http.dart' as http;

import '../models/center_found_model.dart';

class DiscordAlerter {
  int counter = 1;
  void sendCentersMessageOnDiscord(
      {List<VacCenterFound>? centers, String? timeFetched}) async {
    counter = 1;
    var mssgToSend = '';
    centers!.forEach((element) {
      mssgToSend =
          '-\n**${element.pinCode}**  **${element.centerName}**   **`${element.dose1}`**  ${element.date}   ${element.vaccineName}\n' +
              mssgToSend;
      // sendMessage(mssgToSend);
      print('Called $counter times');
      counter++;
    });
    sendMessage(mssgToSend);
  }

  void sendMessage(String mssg) async {
    try {
      final response = await http.post(
          Uri.parse(EnvironmentVariables.DISCORD_WEB_HOOK_API),
          body: {'content': '$mssg', 'tts': 'false'});
      print(response.body);
    } catch (e) {
      //PRINT THE ERROR
      print(e.toString());
    }
  }

  void pingKeepAlive() async {
    try {
      await http.post(Uri.parse(EnvironmentVariables.KEEP_ALIVE_DISCORD),
          body: {'content': '${DateTime.now()}', 'tts': 'false'});
    } catch (e) {
      //PRINT THE ERROR
      print(e.toString());
    }
  }
}
