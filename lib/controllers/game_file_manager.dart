import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class GameFileManager {
  String _gamesLocation = "";
  Dio dio = Dio();
  

  Future<String> getGamesLocation () async {
    if (_gamesLocation=="") {
      _gamesLocation = (await getDownloadsDirectory())!.path + "/games";
    }
    return _gamesLocation;
  }
  Future<String> getGameFolder (String gameId) async {
    String gamesLocation = await getGamesLocation();
    // Start a process to run a binary executable
    String gameUrl = "$gamesLocation/$gameId/index.js";
    return gameUrl;
    
  }

  Future<String> getGameEntryPoint (String gameId) async {
    String gamesLocation = await getGamesLocation();
    String gameWorkingDirectory = "$_gamesLocation/$gameId/";
    return gameWorkingDirectory;
  }

  Future<bool> isGameFolderExist(String gameId) async {
    String gameFolder = await getGameFolder(gameId);
    bool exists = await Directory(gameFolder).exists();

    return exists;
  }

  void downloadGame(gameId, gameUrl) async {
    String gamesLocation = await getGamesLocation();
    String gameArchive =  gamesLocation + "/$gameId.zip";
    // download the game
    var response = await dio.download(
        gameUrl,
        gameArchive,
        onReceiveProgress: (count, total) {  
        },
    );
    // extract the archive
    await extractFileToDisk(gameArchive, gamesLocation);
  }
}