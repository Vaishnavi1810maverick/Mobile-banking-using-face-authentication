import 'package:face_net_authentication/pages/db/database.dart';
import 'package:face_net_authentication/pages/sign-in.dart';
import 'package:face_net_authentication/pages/sign-up.dart';
import 'package:face_net_authentication/services/facenet.service.dart';
import 'package:face_net_authentication/services/ml_kit_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Services injection

  //Extract features from images
  FaceNetService _faceNetService = FaceNetService();
  MLKitService _mlKitService = MLKitService();
  DataBaseService _dataBaseService = DataBaseService();

  //Get information on camera
  CameraDescription cameraDescription;
  //To load the camera
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _startUp(); //Runs asynchronously until await keyword is read
  }

  //

  _startUp() async {
    _setLoading(true);
    // Obtain a list of the available cameras on the device.
    List<CameraDescription> cameras = await availableCameras();

    // Front camera must only be used
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

    //loads the face net model and start the services
    await _faceNetService.loadModel();
    await _dataBaseService.loadDB();
    _mlKitService.initialize();

    _setLoading(false);
  }

  // shows or hides the circular progress indicator
  _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAF3FA),
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: !loading
          ? SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        children: [
                          Text(
                            "WELCOME TO RSV BANK.",
                            style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "We safeguard and protect your money!",
                            style: TextStyle(
                              color: Color(0xFF335098),
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        image: AssetImage('assets/homePage.png'),
                      ),
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignIn(
                                  cameraDescription: cameraDescription,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue[100],
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  blurRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'LOGIN',
                                  style: TextStyle(color: Colors.blue[900]),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.login, color: Colors.blue[900])
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignUp(
                                  cameraDescription: cameraDescription,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue[100],
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  blurRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'SIGN UP',
                                  style: TextStyle(color: Colors.blue[900]),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.person_add, color: Colors.blue[900])
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
