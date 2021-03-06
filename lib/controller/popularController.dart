import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:podcast_app/models/podcast.dart';

class PopularController extends GetxController {
  List<PodcastModel> list = [];
  var isLoading = false.obs;

  @override
  void onInit() {
    streamDemo();
    super.onInit();
  }

  streamDemo() async {
    List<PodcastModel> listNew = [];

    await FirebaseFirestore.instance.collection('popular').get().then(
      (qs) {
        qs.docs.forEach(
          (element) {
            PodcastModel item = PodcastModel.fromJson(element.data());
            listNew.add(item);
          },
        );
      },
    );

    list = listNew;
    update();
  }
}
