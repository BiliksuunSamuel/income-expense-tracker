import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ie_montrac/api/services/events.service.dart';
import 'package:ie_montrac/routes/app.routes.dart';
import 'package:ie_montrac/screens/landing/welcome.screen.dart';
import 'package:ie_montrac/theme/app.theme.dart';
import 'package:ie_montrac/utils/dimensions.dart';
import 'package:socket_io_client/socket_io_client.dart' as SocketIo;

import "api/dependencies.dart" as dependencies;
import 'configuration/app.configuration.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  var socket = SocketIo.io(AppConfiguration.baseUrl, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });
  EventsService.socket = socket;
  //listen on signIn event
  EventsService.socket.on('signIn', (data) {
    EventsService.handleSignInEvent(data["userId"], data["tokenId"]);
    if (kDebugMode) {
      print('SignIn Event: $data');
    }
  });
  //
  try {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    if (kDebugMode) {
      print("Firebase initialized");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error initializing firebase: $e");
    }
  }
  await dependencies.init();

  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Dimensions.init(context);
    return GetMaterialApp(
        title: "IE Montrac",
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: AppRoutes.home,
        getPages: AppRoutes.routes,
        home: const WelcomeScreen());
  }
}
