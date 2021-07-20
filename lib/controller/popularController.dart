import 'package:get/get.dart';
import 'package:podcast_app/data/list_podcast.dart';
import 'package:podcast_app/models/podcast_model.dart';

class PopularController extends GetxController {
  List<PodcastModel> list = [];
  var isLoading = false.obs;

  @override
  void onInit() {
    list = listPopular.map((e) => PodcastModel.fromJson(e)).toList();
    update();
    super.onInit();
  }
}
