import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future getData() async{
    http.Response response = await http.get('https://api.covid19india.org/data.json');
    String data = response.body;
    var body =  (jsonDecode(data));
    print(body['statewise'][0]);
  }
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM, kk:mm').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID19 INDIA',
        style: TextStyle(
          color: Color(0xFFEB1555),
        ),),
      ),
      body:Center(
        child: Container(
          child: Text(formattedDate),
        ),
      ),
    );
  }
}