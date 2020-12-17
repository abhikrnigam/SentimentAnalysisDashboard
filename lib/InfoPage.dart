import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sentimentanalysisdashboard/ChartPlot.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  dynamic response;

  Future<dynamic> getUserInfo() async {
    response = await FirebaseFirestore.instance.collection("users").get();
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.equalizer,
          size: 40,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[900],
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChartPlot()));
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          "The Blues",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 25.0, left: 40.0, right: 40.0, bottom: 50.0),
            child: FutureBuilder(
              future: getUserInfo(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  );
                } else {
                  String tweet = snapshot.data.docs[0]["tweet"];
                  String name = snapshot.data.docs[0]["name"];
                  double depressiveFactor=snapshot.data.docs[0]["depressiveFactor"];
                  double positiveFactor=snapshot.data.docs[0]["positiveFactor"];
                  bool prediction=snapshot.data.docs[0]["prediction"];
                  if (tweet.length == 0 || name.length == 0) {
                    return Text("Something went wrong");
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue[900],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 5.0),
                                  child: Text(
                                    "$tweet",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "~${name} ",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:25.0,bottom: 10.0),
                          child: Container(
                            decoration:BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 25.0, right: 15.0, left: 15.0),
                                child: Container(
                                  child: BarChart(
                                    BarChartData(
                                      alignment: BarChartAlignment.spaceAround,
                                      maxY: 20,
                                      barTouchData: BarTouchData(
                                        enabled: false,
                                        touchTooltipData: BarTouchTooltipData(
                                          tooltipBgColor: Colors.transparent,
                                          tooltipPadding: const EdgeInsets.all(0),
                                          tooltipBottomMargin: 0,
                                          getTooltipItem: (
                                              BarChartGroupData group,
                                              int groupIndex,
                                              BarChartRodData rodData,
                                              int rodIndex,
                                              ) {
                                            return BarTooltipItem(
                                              "",
                                              //rodData.y.round().toString(),
                                              TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      titlesData: FlTitlesData(
                                        show: true,
                                        bottomTitles: SideTitles(
                                          showTitles: true,
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                          margin: 10,
                                          getTitles: (double value) {
                                            switch (value.toInt()) {
                                              case 0:
                                                return 'Abhishek';
                                              case 1:
                                                return 'Nikhil';
                                              case 2:
                                                return 'Tabassum';
                                              default:
                                                return '';
                                            }
                                          },
                                        ),
                                        leftTitles: SideTitles(
                                          showTitles: true,
                                          textStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                          margin: 10,
                                          reservedSize: 14,
                                          getTitles: (value) {
                                            if (value == 0) {
                                              return ' 1';
                                            } else if (value == 5) {
                                              return ' 2';
                                            } else if (value == 10) {
                                              return ' 3';
                                            } else if (value == 15)
                                              return ' 4';
                                            else if (value == 20)
                                              return ' 5';
                                            else {
                                              return '';
                                            }
                                          },
                                        ),
                                      ),
                                      axisTitleData: FlAxisTitleData(
                                        //bottomTitle: AxisTitle(showTitle: true, titleText: 'Total Users',textStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
                                        leftTitle:
                                        AxisTitle(showTitle: true, titleText: 'Depression Factor',textStyle: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold)),
                                      ),
                                      borderData: FlBorderData(
                                        show: false,
                                      ),
                                      barGroups: [
                                        BarChartGroupData(
                                          x: 0,
                                          barRods: [
                                            BarChartRodData(y: (depressiveFactor*-1)%5.toInt()<1?1:(depressiveFactor*-1)%5.toInt(), color: Colors.blue),
                                          ],
                                          showingTooltipIndicators: [0],
                                        ),
                                        BarChartGroupData(
                                          x: 1,
                                          barRods: [
                                            BarChartRodData(y: (depressiveFactor*-1)%5.toInt()<1?1:(depressiveFactor*-1)%5.toInt(), color: Colors.blue)
                                          ],
                                          showingTooltipIndicators: [0],
                                        ),
                                        BarChartGroupData(
                                          x: 2,
                                          barRods: [
                                            BarChartRodData(
                                              y: (depressiveFactor*-1)%5.toInt()<1?1:(depressiveFactor*-1)%5.toInt(),
                                              color: Colors.blue,
                                            )
                                          ],
                                          showingTooltipIndicators: [0],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Material(
                            color: Colors.blue,
                            child: Text(
                              "Figure : Graph showing depression factor \n between the users.",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:15.0,right: 20.0,left: 20.0),
                          child: Center(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 15.0),
                                child: Text("Prediction:  ${prediction?"Depressed":"Not Depressed"}",style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),),
                              ),
                              decoration: BoxDecoration(
                                color: prediction?Colors.red[500]:Colors.green,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
