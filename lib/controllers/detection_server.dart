import 'dart:io';
import 'dart:convert';
import 'package:network_info_plus/network_info_plus.dart';

class DetectionServer {
  late RawDatagramSocket server;

  void run() async {
    print("run datagram ${InternetAddress.anyIPv4}");
    server = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 2222);

    server.listen((RawSocketEvent event) async  {
      if (event == RawSocketEvent.read) {
        Datagram? datagram = server.receive();
        print("received a datagram");
        if (datagram != null) {
          final message = utf8.decode(datagram.data);
          print('Data received from client: $message');
           final info = NetworkInfo();
          final ipAddress =  await info.getWifiIP();

          final response = {
            "server": true,
            "name": "Dart monitor server",
            "ip": ipAddress,
          };
          final strMsg = json.encode(response);

          server.send(
            utf8.encode(strMsg),
            datagram.address,
            2223,
          );

          print('UDP data sent !!!');
        }
      }
    },
    
    );

    
  }
}