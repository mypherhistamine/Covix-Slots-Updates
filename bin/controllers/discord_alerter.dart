import '../env.dart';
import 'package:http/http.dart' as http;

import '../models/center_found_model.dart';

class DiscordAlerter {
  void sendCentersMessageOnDiscord(
      {List<VacCenterFound>? centers, String? timeFetched}) async {
    String mssgToSend = '';
    print('${centers!.length} centers');
    centers.forEach((element) {
      mssgToSend =
          '`Center Name`: ${element.centerName}\n\n`Pincode` ${element.pinCode}\n\n`Date`:${element.date}\n\n`Synced-At` $timeFetched\n\n`Dose 1` ${element.dose1}\n\n`vacc-name` ${element.vaccineName}\n\n`Is All Ages`  ${element.allAges}\n\n`min-age-limit` ${element.minAgeLimit}\n\n`max-age-limit` ${element.maxAgeLimit}\n\n' +
              mssgToSend;
    });

    final response = await http
        .post(Uri.parse(EnvironmentVariables.DISCORD_WEB_HOOK_API), body: {
      'content': mssgToSend,
      'tts': 'true',
    });
    print(response.body);
  }

  void testWebHook() async {
    await http.post(Uri.parse(EnvironmentVariables.DISCORD_WEB_HOOK_API),
        body: {'content': 'pingTest', 'tts': 'true'});
  }
}
