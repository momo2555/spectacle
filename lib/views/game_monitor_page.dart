import 'package:flutter/material.dart';
import 'package:desktop_webview_window/desktop_webview_window.dart';

class GameMonitorPage extends StatefulWidget {
  const GameMonitorPage({super.key});

  @override
  State<GameMonitorPage> createState() => _GameMonitorPageState();
}

class _GameMonitorPageState extends State<GameMonitorPage> {
  //WebViewController _webViewController = WebViewController();
  void _initWebViewController() async {
    /*await _webViewController.init(
      context: context,
      setState: setState,
      uri: Uri.parse("https://flutter.dev"),
    );*/

    final webview = await WebviewWindow.create(
      configuration: CreateConfiguration(
        openMaximized: true,
        title: "ExampleTestWindow",
        titleBarTopPadding: 0,
       // userDataFolderWindows: await _getWebViewPath(),
      ),
    );
    webview
      ..registerJavaScriptMessageHandler("test", (name, body) {
        debugPrint('on javaScipt message: $name $body');
      })
      ..setApplicationNameForUserAgent(" WebviewExample/1.0.0")
      ..setPromptHandler((prompt, defaultText) {
        if (prompt == "test") {
          return "Hello World!";
        } else if (prompt == "init") {
          return "initial prompt";
        }
        return "";
      })
      ..evaluateJavaScript("""
        var elem = document.querySelector("html");
        elem.requestFullscreen();
        console.log("coucou 1");
      """)
      ..addScriptToExecuteOnDocumentCreated("""
        var elem = document.querySelector("html");
        elem.requestFullscreen();
        console.log("coucou 2");
      """)
      ..launch("http://localhost:2227/game/monitor.html");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initWebViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
