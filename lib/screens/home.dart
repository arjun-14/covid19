import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final List statesInfo;
  Home({this.statesInfo});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DataRow> dataRow = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datacell();
  }

  void datacell() {
    for (var i = 0; i < widget.statesInfo.length; i++) {
      print(widget.statesInfo[i]['state']);
      dataRow.add(
        DataRow(cells: [
          DataCell(Text(widget.statesInfo[i]['state'])),
          DataCell(Text(widget.statesInfo[i]['active'])),
          DataCell(Text(widget.statesInfo[i]['confirmed'])),
          DataCell(Text(widget.statesInfo[i]['recovered'])),
          DataCell(Text(widget.statesInfo[i]['deaths'])),
        ]),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return dataRow == null
        ? LinearProgressIndicator()
        : SingleChildScrollView(
            child: Center(
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    rows: dataRow,
                    columns: [
                      DataColumn(
                        label: Text('State'),
                      ),
                      DataColumn(label: Text('Confirmed')),
                      DataColumn(label: Text('Active')),
                      DataColumn(label: Text('Recovered')),
                      DataColumn(label: Text('Deceased')),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
