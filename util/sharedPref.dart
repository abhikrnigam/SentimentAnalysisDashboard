import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SharedPrefServices{

  final String initialView="firstTimeViewing";

  Future<String> getStartingView() async{
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    String initialViewString= sharedPreferences.get(initialView)==null?'false':sharedPreferences.get(initialView);
    return initialViewString;
  }


  Future<void> setStartingView() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString(initialView, 'true');
  }

}