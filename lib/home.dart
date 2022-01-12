// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:f_o_radio/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<List<Station>> _getStationList() async {
    final String response =
        await rootBundle.loadString('assets/listofstations.json');
    Iterable stationList = jsonDecode(response);
    List<Station> parsedStationList = <Station>[];
    for (Map<String, dynamic> station in stationList) {
      parsedStationList.add(Station.fromJson(station));
    }
    return parsedStationList;
  }

  late Future<List<Station>> stationsList;
  @override
  void initState() {
    // TODO: implement initState
    stationsList = _getStationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: SafeArea(
          child: FutureBuilder<List<Station>>(
        future: stationsList,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('Loading..');
            case ConnectionState.done:
              List<Station> stations = snapshot.data ?? <Station>[];
              return ListView.builder(
                  itemCount: stations.length,
                  itemBuilder: (context, index) {
                    print(
                        'name: ${stations[index].name} url = ${stations[index].favicon}');
                    return Card(
                      child: ListTile(
                          title: Text('${stations[index].name}'),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(stations[index].favicon),
                          )),
                    );
                  });
            default:
              return Text('Default');
          }
        },
      )),
    );
  }
}

class $ {}
