import 'package:audio_service/audio_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:podcast_app/controller/popularController.dart';
import 'package:podcast_app/models/podcast_model.dart';
import 'package:podcast_app/ui/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _intialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _intialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Terjadi kesalah'),
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: AudioServiceWidget(
                child: Home(),
                // child: Testpage(),
              ),
            );
          }
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        });
  }
}

class Testpage extends StatelessWidget {
  final Stream<QuerySnapshot> _popularStream =
      FirebaseFirestore.instance.collection('popular').snapshots();

  final PopularController pc = Get.put(PopularController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _popularStream,
          builder: (context, snapshost) {
            if (snapshost.hasError) {
              return Center(
                child: Text('Terjadi kesalahan'),
              );
            }

            if (snapshost.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: [
                ...snapshost.data!.docs.map((DocumentSnapshot document) {
                  PodcastModel item = PodcastModel.fromJson(
                      document.data() as Map<String, dynamic>);
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.title),
                  );
                }).toList(),
                Container(
                  child: ElevatedButton(
                    onPressed: () {
                      pc.streamDemo();
                    },
                    child: Text('refresh'),
                  ),
                )
              ],
            );
          }),
    );
  }
}
