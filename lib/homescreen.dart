import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var body;
  var confirmed = '0';
  var active = '0';
  var recovered = '0';
  var deceased = '0';
  var lastUpdatedTime;
  var lastUpdatedTimeDate;
  bool loading = false;
  List statesInfo;
  var length;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future getData() async {
    loading = true;
    http.Response response =
        await http.get('https://api.covid19india.org/data.json');
    String data = response.body;
    body = (jsonDecode(data));
    setState(() {
      confirmed = body['statewise'][0]['confirmed'];
      active = body['statewise'][0]['active'];
      recovered = body['statewise'][0]['recovered'];
      deceased = body['statewise'][0]['deaths'];
      lastUpdatedTime = body['statewise'][0]['lastupdatedtime'];
      lastUpdatedTimeDate = lastUpdatedTime.toString().substring(0, 5) +
          lastUpdatedTime.toString().substring(10, 16);
      statesInfo = body['statewise'];
      statesInfo.removeAt(0);
      length = statesInfo.length;
      loading = false;
    });
    print(statesInfo[1]);
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
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    //child: Text('temp'),
                    child: Text('Last updated on: $lastUpdatedTimeDate IST'),
                  ),
                  Row(
                    children: <Widget>[
                      CasesNumber(
                        status: 'Confirmed',
                        colour: Colors.red,
                        number: confirmed,
                      ),
                      CasesNumber(
                        status: 'Active',
                        colour: Colors.blue,
                        number: active,
                      ),
                      CasesNumber(
                        status: 'Recovered',
                        colour: Colors.green,
                        number: recovered,
                      ),
                      CasesNumber(
                        status: 'Deceased',
                        colour: Colors.grey,
                        number: deceased,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(flex: 2,child: Text('State/UT',),),
                      Expanded(flex: 1,child: Text('confirmed',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),),
                      Expanded(flex: 1,child: Text('active',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),),
                      Expanded(flex: 1,child: Text('recovered',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),),
                      Expanded(flex: 1,child: Text('deaths',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: length,
                        itemBuilder: (context, int index) {
                          return Row(
                            children: <Widget>[
                              StatesCases(statesInfo: statesInfo[index]['state'],flex: 2,alignment: CrossAxisAlignment.start,),
                              StatesCases(statesInfo: statesInfo[index]['confirmed'],flex: 1,alignment: CrossAxisAlignment.end,),
                              StatesCases(statesInfo: statesInfo[index]['active'],flex: 1,alignment: CrossAxisAlignment.end,),
                              StatesCases(statesInfo: statesInfo[index]['recovered'],flex: 1,alignment: CrossAxisAlignment.end,),
                              StatesCases(statesInfo: statesInfo[index]['deaths'],flex: 1,alignment: CrossAxisAlignment.end,),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatesCases extends StatelessWidget {

  StatesCases({this.statesInfo,this.flex,this.alignment});
  final  statesInfo;
  final flex ;
  final alignment;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          Container(
            //color: Color(0xFF161625),
            child: Text(
              statesInfo,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 12,),
        ],
      ),
      flex: flex,
    );
  }
}



class CasesNumber extends StatelessWidget {
  CasesNumber({this.status, this.colour, @required this.number});
  final status;
  final colour;
  final number;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            status,
            style: TextStyle(
              fontSize: 15,
              color: colour,
            ),
          ),
          Text(
            number,
            //Text('${deceased.toString().substring(0,1)+','+deceased.toString().substring(1,4)}',
            style: TextStyle(
              fontSize: 23,
              color: colour,
            ),
          )
        ],
      ),
    );
  }
}
