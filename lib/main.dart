import 'package:authentication_repository/authentication_respository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:podcast_app/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  runApp(App(authenticationRepository: authenticationRepository));
  // runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   final Future<FirebaseApp> _intialization = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _intialization,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return MaterialApp(
//             home: Scaffold(
//               body: Center(
//                 child: Text('Terjadi kesalahan'),
//               ),
//             ),
//           );
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           // return GetMaterialApp(
//           //   debugShowCheckedModeBanner: false,
//           //   home: AudioServiceWidget(
//           //     child: Home(),
//           //   ),
//           // );
//         }


//         return MaterialApp(
//           home: Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
