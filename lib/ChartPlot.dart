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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
        FloatingActionButton(
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue[900],
          onPressed: (){
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
                      top: 60.0, right: 15.0, left: 15.0, bottom: 8),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 80.0, right: 15.0, left: 15.0),
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
                              margin: 32,
                              reservedSize: 14,
                              getTitles: (value) {
                                if (value == 0) {
                                  return '1';
                                } else if (value == 5) {
                                  return '2';
                                } else if (value == 10) {
                                  return '3';
                                } else if (value == 15)
                                  return '4';
                                else if (value == 20)
                                  return '5';
                                else {
                                  return '';
                                }
                              },
                            ),
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: [
                            BarChartGroupData(
                              x: 0,
                              barRods: [
                                BarChartRodData(y: 8, color: Colors.blue),
                              ],
                              showingTooltipIndicators: [0],
                            ),
                            BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(y: 10, color: Colors.blue)
                              ],
                              showingTooltipIndicators: [0],
                            ),
                            BarChartGroupData(
                              x: 2,
                              barRods: [
                                BarChartRodData(
                                  y: 14,
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
              ],
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
                  child: LineChart(
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
                        bottomTitle: AxisTitle(showTitle: true, titleText: 'Total Users',textStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
                      leftTitle:
                      AxisTitle(showTitle: true, titleText: 'Depressed Users',textStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold)),
                    ),
                      borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                              color: const Color(0xff37434d), width: 1)),
                      minX: 0,
                      maxX: 11,
                      minY: 0,
                      maxY: 6,
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 3),
                            FlSpot(2.6, 2),
                            FlSpot(4.9, 5),
                            FlSpot(6.8, 3.1),
                            FlSpot(8, 4),
                            FlSpot(9.5, 3),
                            FlSpot(11, 4),
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
}
