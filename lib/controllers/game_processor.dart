import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:spectacle/controllers/game_file_manager.dart';

class GameProcessor {
  Process? _gameProcess;
  bool _running = false;
  GameFileManager _gameFileManager = GameFileManager();
  void runGame(gameId) async {
    print("launch game id $gameId");

    String gameUrl = await _gameFileManager.getGameEntryPoint(gameId);
    String gameWorkingDirectory = await _gameFileManager.getGameFolder(gameId);
    
    if (File(gameUrl).existsSync()) {
      print("file exists ");
    }
    print("game path : $gameUrl");

    Process.start('node', [gameUrl], workingDirectory: gameWorkingDirectory)
        .then((Process process) {
      _gameProcess = process;
      _running = true;
      process.stdout.transform(utf8.decoder).listen((data) {
        // Handle the standard output of the process
        print('Process output: $data');
      });

      process.stderr.transform(utf8.decoder).listen((data) {
        // Handle the standard error of the process
        print('Process error: $data');
      });

      process.exitCode.then((int exitCode) {
        print('Process exited with code: $exitCode');
      });

    }).catchError((error) {
      print('Error executing process: $error');
    });
  }

  void killGame() {
    if (_running && _gameProcess != null) {
      _gameProcess!.kill(ProcessSignal.sigkill);
      _gameProcess = null;
      _running = false;
    }
  }
}
