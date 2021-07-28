import '../env.dart';
import 'package:http/http.dart' as http;

import '../models/center_found_model.dart';

class DiscordAlerter {

  
  void testWebHook({List<VacCenterFound>? centers}) async {
    String mssgToSend = '';
    centers!.forEach((element) {
      mssgToSend = '''
      `Center Name: ${element.centerName} `

      --------------------------------------
      ''' +
          mssgToSend;
    });

    final response = await http
        .post(Uri.parse(EnvironmentVariables.DISCORD_WEB_HOOK_API), body: {
      'content': mssgToSend,
      'tts': 'true',
    });
    print(response.body);
  }
}
