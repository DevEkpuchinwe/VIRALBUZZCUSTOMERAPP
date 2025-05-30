import 'package:cabbieuser/core/helper/string_format_helper.dart';
import 'package:cabbieuser/data/services/api_service.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioUtils {
  static Future<void> playAudio(String path) async {
    printX('isNotificationAudioEnable: $path');
    if (Get.find<ApiClient>().isNotificationAudioEnable() == true) {
      AudioPlayer player = AudioPlayer();
      try {
        await player.stop();
        await player.setUrl(path);
        await player.play();
      } catch (e) {
        printX(e);
      }
    }
  }
}
