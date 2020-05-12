import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var confirmed;
  var active;
  var recovered;
  var deceased;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future getData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/data.json');
    String data = response.body;
    var body = (jsonDecode(data));
    print(body['statewise'][0]);
      setState(() {
        confirmed = body['statewise'][0]['confirmed'];
        active = body['statewise'][0]['active'];
        recovered = body['statewise'][0]['recovered'];
        deceased = body['statewise'][0]['deaths'];
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COVID19 INDIA',
          style: TextStyle(
            color: Color(0xFFEB1555),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('Confirmed',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                    ),
                   ),
                    Text('$confirmed',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.red,
                    ),),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('Active',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                    ),
                    ),
                    Text('$active',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.blue,
                    ),),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('Recovered',
                      style: TextStyle(
                          fontSize: 15,
                        color: Colors.green,
                      ),
                    ),
                    Text('$recovered',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.green,
                    ),),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text('Deceased',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                   ),
                    Text('$deceased',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.grey,
                    ),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
