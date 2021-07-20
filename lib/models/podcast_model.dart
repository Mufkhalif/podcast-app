class PodcastModel {
  int id;
  String title;
  String date;
  String time;
  String imgSrc;
  String type;
  String desc;
  String url;

  PodcastModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.imgSrc,
    required this.type,
    required this.desc,
    required this.url,
  });

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    return PodcastModel(
      id: json['id'],
      title: json['title'],
      date: json['date'],
      time: json['time'],
      imgSrc: json['imgSrc'],
      type: json['type'],
      desc: json['desc'],
      url: json['url'],
    );
  }

  @override
  String toString() {
    return 'id: ${this.id}, title: ${this.title}, date: ${this.date}, time: ${this.time}';
  }
}
