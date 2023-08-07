import 'package:desktop_webview_window/desktop_webview_window.dart';
import 'package:flutter/material.dart';

class MonitorController {
  static Webview? webview;
  static bool launched = false;
  static void launchMonitor() async {
    if (!launched) {
      MonitorController.webview = await WebviewWindow.create(
        configuration: CreateConfiguration(
          openMaximized: true,
          title: "Spectacle",
          titleBarTopPadding: 0,
          // userDataFolderWindows: await _getWebViewPath(),
        ),
      );
      if (webview != null) {
        webview!
          ..registerJavaScriptMessageHandler("test", (name, body) {
            debugPrint('on javaScipt message: $name $body');
          })
          ..setApplicationNameForUserAgent("WebviewExample/1.0.0")
          ..setPromptHandler((prompt, defaultText) {
            if (prompt == "test") {
              return "Hello World!";
            } else if (prompt == "init") {
              return "initial prompt";
            }
            return "";
          })
          ..launch("http://localhost:2227/game/monitor.html");
      }
      launched = true;
    }
  }

  static void closeMonitor() {
    if (launched && webview != null) {
      MonitorController.webview!.close();
      launched = false;
    }
  }
}
