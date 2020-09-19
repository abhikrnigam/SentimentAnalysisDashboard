import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import 'HomeScreen.dart';
import 'WalkthorughScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            Lottie.asset('assets/welcome.json',
                repeat: true,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.5,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.7),
            Text(
              "Welcome to The Blues \n Social Media Depression Analysis",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Click on Next to Continue",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                color: Colors.blue,
                child: Text("Next",style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),),
                onPressed: () {
//                  initialRoute == 'true' ?
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => WalkthroughScreen()));
//                      :
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
