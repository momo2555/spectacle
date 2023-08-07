import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:spectacle/controllers/game_file_manager.dart';
import 'package:spectacle/controllers/game_processor.dart';
import 'package:spectacle/controllers/monitor_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GameServer {
  //ServerSocket? _server;
  Map<String, WebSocket?> _client = {
    "monitor": null,
    "controller": null,
  };
  GameProcessor _gameProcessor = GameProcessor();
  GameFileManager _gameFileManager = GameFileManager();

  void run() async {
    final server = await HttpServer.bind("0.0.0.0", 2225);
    server.listen((HttpRequest request) {
      if (WebSocketTransformer.isUpgradeRequest(request)) {
        WebSocketTransformer.upgrade(request).then((WebSocket socket) {
          socket.listen((message) {
            final decodedData = jsonDecode(message);
            print(decodedData);
            if (decodedData['header'] != null &&
                decodedData['header']['type'] != null) {
              final headerType = decodedData['header']['type'];
              if (headerType == 'request') {
                final requestData = decodedData['request'];
                switch (requestData['exec']) {
                  case 'launchGame':
                    final game = requestData['params']['gameId'];
                    final gameUrl = requestData['params']['gameUrl'];
                    startGame(game, gameUrl);
                    break;
                  case 'closeGame':
                    final game = requestData['params']['gameId'];
                    closeGame(game);
                    break;
                  case 'identification':
                    final id = decodedData['header']['from'];
                    print('identification: $id');
                    _client[id] = socket;
                    break;
                  case 'changeState':
                    
                    final state = requestData['params']['state'];
                    newState(socket, decodedData['header']['from'], state);
                    break;
                  default:
                    break;
                }
              } else if (headerType == 'data_exchange') {
                final to = decodedData['header']['to'];
                final from = decodedData['header']['from'];
                final data = decodedData['data'];
                dataExchange(socket, from, to, data);
              }
            }
          });
        });
      }
    });
  }

  void dataExchange(WebSocket client, String from, String to, dynamic data) {
    final dataToSend = {
      "header": {
        "type": "data_exchange",
        "from": from,
        "to": to,
      },
      "data": data,
    };
    final strDataToSend = jsonEncode(dataToSend);

    if (client != null) {
      client.add(strDataToSend);
    }
  }

  void startGame(String gameId, String gameUrl )async {
    print("start game $gameUrl");
    if(await _gameFileManager.isGameFolderExist(gameId)) {
      _gameProcessor.runGame(gameId);
      MonitorController.launchMonitor();
    }else {
      // download the game
      _gameFileManager.downloadGame(gameId, gameUrl);
      
    }
    

  }

  void closeGame(String game) {
    print("close game");
    _gameProcessor.killGame();
    MonitorController.closeMonitor();

  }

  void newState(WebSocket client, String from, dynamic state) {
    // Send a new state of game
    final data = {
      "header": {
        "type": "request",
        "from": from,
      },
      "request": {
        "exec": "changeState",
        "params": {
          "state": state,
        },
      },
    };
    print('sendAll');
    print(data);
    sendAll(from, data);
  }

  void sendAll(String from, Map<String, dynamic> data) {
    final strData = jsonEncode(data);

    for (final entry in _client.entries) {
      final key = entry.key;
      final value = entry.value;
      if (value != null) {
        value.add(strData);
      }
    }
  }
}
