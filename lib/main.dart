//import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spectacle/controllers/detection_server.dart';
import 'package:spectacle/controllers/game_server.dart';
import 'package:spectacle/themes/main_theme.dart';
import 'package:spectacle/views/game_monitor_page.dart';
import 'package:spectacle/views/main_screen_page.dart';
import 'package:window_manager/window_manager.dart';


final globalNavigatorKey = GlobalKey<NavigatorState>();
void main(List<String> args)  async {
  
  
  if (runWebViewTitleBarWidget (args)) {
    return;
  }
  
  WidgetsFlutterBinding.ensureInitialized();
  DetectionServer().run();
  GameServer().run();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const  WindowOptions(
    fullScreen: true,
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  //await Firebase.initializeApp();
  /*SystemChrome.setPreferredOrientations([DeviceOrzerfdeientation.landscapeRight])  b 
      .then((_) {
    */
  runApp(const MyApp()); /*
  });*/
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      title: 'Spectacle',
      theme: mainTheme.defaultTheme,
      navigatorKey: globalNavigatorKey,
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    switch (settings.name) {
      case '/':
        //return MaterialPageRoute(builder: (context) => const MainSignPage());
        return MaterialPageRoute(
            builder: (context) {
              return MainScreenPage();
            });

      case '/game_monitor':
        return MaterialPageRoute(
            builder: (context) => GameMonitorPage(
                ));

      
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
