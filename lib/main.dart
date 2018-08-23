import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _state createState() => new _state();
}

class _state extends State<MyApp> {
  Map countries = new Map();

  void getData() async {
    var url = 'http://country.io/names.json';
    var response = await http.get(url);
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      setState(() {
        print('asd');
        countries = JSON.decode(response.body);
        print('laoded: ${countries.length}');
      });
    }
  }

  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My Title'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Text('ListView'),
              new Expanded(
                  child: new ListView.builder(
                itemCount: countries.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = countries.keys.elementAt(index);
                  return new Row(
                    children: <Widget>[
                      new Text('${key} :'),
                      new Text('${countries[key]} :'),
                    ],
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
