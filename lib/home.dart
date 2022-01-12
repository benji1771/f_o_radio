// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:f_o_radio/station.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Station>> _getStationList() async {
    final http.Response response = await http.get(Uri.parse(
        'http://de1.api.radio-browser.info/json/stations/byname/jazz'));
    Iterable stationList = jsonDecode(response.body);
    List<Station> parsedStationList = <Station>[];
    for (Map<String, dynamic> station in stationList) {
      parsedStationList.add(Station.fromJson(station));
    }
    return parsedStationList;
  }

  late Future<List<Station>> stationsList;
  @override
  void initState() {
    stationsList = _getStationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[700],
      body: SafeArea(
          child: FutureBuilder<List<Station>>(
        future: stationsList,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(child: Text('Loading..'));
            case ConnectionState.done:
              List<Station> stations = snapshot.data ?? <Station>[];
              return ListView.builder(
                  itemCount: stations.length,
                  itemBuilder: (context, index) {
                    return Card(
                      //margin: EdgeInsets,
                      child: ListTile(
                        title: Text('${stations[index].name}'),
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('assets/play.png'),
                        ),
                      ),
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
