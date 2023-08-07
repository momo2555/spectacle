import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spectacle/controllers/detection_server.dart';

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({super.key});

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();

    
  }
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(child: Text("La boîte à jeux", style: TextStyle(fontSize: 50,color: Theme.of(context).primaryColorDark),)),
    );
  }
}