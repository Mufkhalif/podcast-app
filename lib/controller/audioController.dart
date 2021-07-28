import 'package:get/get.dart';
import 'package:podcast_app/models/podcast_model.dart';

class AudioController extends GetxController {
  var currentQueue = "".obs;

  goToDetail({
    required PodcastModel item,
  }) async {
    currentQueue.value = item.url;

    update();
  }
}
