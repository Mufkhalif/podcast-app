import 'package:cloud_firestore/cloud_firestore.dart';

class PodcastModel {
  String id;
  String title;
  String date;
  String time;
  String imgSrc;
  String type;
  String desc;
  String url;
  String album;

  PodcastModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.imgSrc,
    required this.type,
    required this.desc,
    required this.url,
    required this.album,
  });

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    return PodcastModel(
      id: json['id'] ?? "0",
      title: json['title'] ?? "tanpa judul",
      date: json['date'] ?? "tanpa date",
      time: json['time'] ?? "tanpa time",
      imgSrc: json['cover'] ??
          "https://previews.123rf.com/images/oksanaoo/oksanaoo2002/oksanaoo200200025/141014443-podcast-vector-icon-seamless-pattern-on-a-white-background-layers-grouped-for-easy-editing-illustrat.jpg",
      type: json['type'] ?? "tanpa type",
      desc: json['desc'] ?? "tanpa desc",
      url: json['url'] ?? "tanpa url",
      album: json['album'] ?? "tanpa album",
    );
  }

  factory PodcastModel.fromDocument(DocumentSnapshot ds) {
    return PodcastModel(
      id: '2',
      title: 'title',
      date: 'date',
      time: 'time',
      imgSrc: 'img',
      type: 'type',
      desc: 'desc',
      url: 'desc',
      album: "tanpa album",
    );
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'date': date,
      'time': time,
      'imgSrc': imgSrc,
      'type': type,
      'desc': desc,
      'url': url,
      'album': album,
    };
  }

  @override
  String toString() {
    return 'id: ${this.id}, title: ${this.title}, date: ${this.date}, time: ${this.time}';
  }
}
