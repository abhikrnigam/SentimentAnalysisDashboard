import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sentimentanalysisdashboard/InfoPage.dart';

class ChartPlot extends StatefulWidget {
  @override
  _ChartPlotState createState() => _ChartPlotState();
}

class _ChartPlotState extends State<ChartPlot> {
  BarChartRodData rodData = new BarChartRodData().copyWith(width: 50);
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  int touchedIndex;
  int depressedUsers;
  int totalUsers;
  int ploty_1;
  int ploty_5;
  int ploty_10;
  int plotx_1=1;
  int plotx_5=5;
  int plotx_10=10;

  void setData() async{
    double depressiveFactor=-92.991212;
    double positiveFactor=-67.919232;
    String name="Urvashi";
    String tweet="hahahahaha! i pranked my boyfriend. ";
    bool prediction=true;
    await FirebaseFirestore.instance.collection('users').add({
      "depressiveFactor":depressiveFactor,
      "positiveFactor":positiveFactor,
      "name":name,
      "tweet":tweet,
      "prediction":prediction,
    }).whenComplete(() => {
      print("Updated Database")
    });
  }

  Future<void> getGlobalDataLine() async{

    QuerySnapshot response_1=await FirebaseFirestore.instance.collection('users').where("prediction",isEqualTo: true).limit(plotx_1).get();
    QuerySnapshot response_5=await FirebaseFirestore.instance.collection('users').where("prediction",isEqualTo: true).limit(plotx_5).get();
    QuerySnapshot response_10=await FirebaseFirestore.instance.collection('users').where("prediction",isEqualTo: true).limit(plotx_10).get();
    ploty_1=response_1.size%10;
    ploty_5=response_5.size%10;
    ploty_10=response_10.size%10;
    setState(() {

    });
  }

  Future<void> getGlobaldata() async {
    QuerySnapshot depressedUsersResponse = await FirebaseFirestore.instance
        .collection("users")
        .where('prediction', isEqualTo: true)
        .get();
    QuerySnapshot totalUserResponse =
        await FirebaseFirestore.instance.collection("users").get();
    totalUsers = totalUserResponse.size;
    depressedUsers = depressedUsersResponse.size;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGlobaldata();
    getGlobalDataLine();
  }

  @override
  Widget build(BuildContext context) {
    //setData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_back_ios,
          size: 25,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[900],
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 50.0, right: 15.0, left: 15.0, bottom: 5),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Column(
                  children: [
                    (depressedUsers == null || totalUsers == null)
                        ? Container(
                            margin: EdgeInsets.only(top: 150),
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.cyan,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                                top: 45.0, left: 65.0, right: 65.0, bottom: 2),
                            child: PieChart(
                              PieChartData(
                                  pieTouchData: PieTouchData(
                                      touchCallback: (pieTouchResponse) {
                                    setState(() {
                                      if (pieTouchResponse.touchInput
                                              is FlLongPressEnd ||
                                          pieTouchResponse.touchInput
                                              is FlPanEnd) {
                                        touchedIndex = -1;
                                      } else {
                                        touchedIndex = pieTouchResponse
                                            .touchedSectionIndex;
                                      }
                                    });
                                  }),
                                  borderData: FlBorderData(
                                    show: false,
                                  ),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 40,
                                  sections: showingSections()),
                            ),
                          ),
                    Center(
                      child: (depressedUsers == null || totalUsers == null)
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(left: 85.0),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    width: 30,
                                    height: 30,
                                    color: Colors.blue,
                                  ),
                                  Text(
                                    "Depressed Users",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey[900], fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    Center(
                      child: (depressedUsers == null || totalUsers == null)
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(left: 85.0),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    width: 30,
                                    height: 30,
                                    color: Color(0xfff8b250),
                                  ),
                                  Text(
                                    "Non-Depressed Users",
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey[900], fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 35.0, left: 15.0, right: 15.0, bottom: 10.0),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, left: 50.0, right: 55.0),
                  child: (ploty_10==null || ploty_1==null || ploty_5==null)?Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ):LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: const Color(0xff37434d),
                            strokeWidth: 1,
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: const Color(0xff37434d),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 2:
                                return '';
                              case 5:
                                return '';
                              case 8:
                                return '';
                            }
                            return '';
                          },
                          margin: 8,
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          getTitles: (value) {
                            switch (value.toInt()) {
                              case 1:
                                return '';
                              case 2:
                                return '';
                              case 3:
                                return '';
                              case 4:
                                return '';
                              case 5:
                                return '';
                              case 6:
                                return '';
                            }
                            return '';
                          },
                          reservedSize: 28,
                          margin: 1,
                        ),
                      ),
                      axisTitleData: FlAxisTitleData(
                        bottomTitle: AxisTitle(
                            showTitle: true,
                            titleText: 'Total Users',
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        leftTitle: AxisTitle(
                            showTitle: true,
                            titleText: 'Depressed Users',
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                              color: const Color(0xff37434d), width: 1)),
                      minX: 0,
                      maxX: 11,
                      minY: 0,
                      maxY: 10,
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 0),
                            FlSpot(1, plotx_1.toDouble()),
                            FlSpot(5, plotx_5.toDouble()),
                            FlSpot(10, plotx_10.toDouble()),

//                            FlSpot(8, 4),
//                            FlSpot(9.5, 3),
//                            FlSpot(11, 4),
                          ],
                          isCurved: true,
                          colors: gradientColors,
                          barWidth: 5,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: false,
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            colors: gradientColors
                                .map((color) => color.withOpacity(0.3))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Material(
                color: Colors.blue,
                child: Text(
                  "Figure : Graph showing \nDepressed Users vs Number of Users",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 18 : 13;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: depressedUsers / totalUsers * 100,
            title: depressedUsers / totalUsers * 100 == 0
                ? ''
                : '${(depressedUsers / totalUsers * 100).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: (totalUsers - depressedUsers) / totalUsers * 100,
            title: (totalUsers - depressedUsers) / totalUsers * 100 == 0
                ? ''
                : '${((totalUsers - depressedUsers) / totalUsers * 100).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 0,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 0,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
