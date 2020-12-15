import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomeScreen.dart';
import 'ChartPlot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String initialRoute;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Spacer(),
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.blueAccent,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.blueAccent,
                  ),
                ),
                Center(
                  child: Lottie.asset('assets/welcome.json',
                      repeat: true,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.5,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.7),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top:50.0),
                child: Text(
                  "The Blues ",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "Social Media Depression Analysis ",
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),Center(
              child: Padding(
                padding: const EdgeInsets.only(top:15.0),
                child: Text(
                  "The Application helps in visualisation \nof the data which is fed to it through \nFirebase.\nThis application, with the help of \ncharts is able to do so.",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Spacer(flex: 9,),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FloatingActionButton(
                  elevation: 5,
                  onPressed: (){
                    {
//                  initialRoute == 'true' ?
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ChartPlot()));
//                      :
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => HomeScreen()));
                    }
                  },
                  child: Text(">",style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
            ),
            Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }
}
