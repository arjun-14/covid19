import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class EssentialScreen extends StatefulWidget {
  static const String id = 'essentialScreen';
  @override
  _EssentialScreenState createState() => _EssentialScreenState();
}

class _EssentialScreenState extends State<EssentialScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async{
    try{
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position);
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ) ,
      ),
    );
  }
}
