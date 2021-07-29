import '../env.dart';
import 'package:http/http.dart' as http;

import '../models/center_found_model.dart';

class DiscordAlerter {
  void sendCentersMessageOnDiscord(
      {List<VacCenterFound>? centers, String? timeFetched}) async {
    var mssgToSend = '';
    centers!.forEach((element) async {
      mssgToSend =
          '**`Center Name`**: ${element.centerName}\nDose 1` ${element.dose1}\n`Pincode` ${element.pinCode}\n`Date`:${element.date}\n`Synced-At` $timeFetched\n`vacc-name` ${element.vaccineName}\n`Is All Ages`  ${element.allAges}\n`min-age-limit` ${element.minAgeLimit}\n`max-age-limit` ${element.maxAgeLimit}\n\n\n';
      sendMessage(mssgToSend);
      await Future.delayed(Duration(seconds: 2));
    });
  }

  void sendMessage(String mssg) async {
    try {
      await http.post(Uri.parse(EnvironmentVariables.DISCORD_WEB_HOOK_API),
          body: {'content': 'mssg', 'tts': 'true'});
    } catch (e) {
      //PRINT THE ERROR
      print(e.toString());
    }
  }

  void testWebHook() async {
    try {
      await http.post(Uri.parse(EnvironmentVariables.DISCORD_WEB_HOOK_API),
          body: {'content': 'pingTest', 'tts': 'true'});
    } catch (e) {
      //PRINT THE ERROR
      print(e.toString());
    }
  }
}
