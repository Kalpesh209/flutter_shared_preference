import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shared_preference_demo/constants/color_constants.dart';
import 'package:flutter_shared_preference_demo/constants/constants.dart';
import 'package:flutter_shared_preference_demo/screens/get_data_screen.dart';
import 'package:flutter_shared_preference_demo/widget/text_button_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


/*
Title:ScanQRScreen
Purpose:ScanQRScreen
Created By:Kalpesh Khandla
*/

class ScanQRScreen extends StatefulWidget {
  final String qrData;
  ScanQRScreen({
    Key key,
    this.qrData,
  }) : super(key: key);

  @override
  _ScanQRScreenState createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  double height, width;
  TextEditingController firstNameController;
  TextEditingController lastnameController;
  TextEditingController mobileController;
  TextEditingController propertyController;
  SharedPreferences sharedPreferences;
  GlobalKey globalKey = new GlobalKey();
  String generatedQR = " Share QR Code ";
  String firstName;
  String lastName;
  String mobileNo;
  String propertyNo;
  String imagePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController = new TextEditingController();
    lastnameController = new TextEditingController();
    mobileController = new TextEditingController();
    propertyController = new TextEditingController();
    getData();
  }

  getData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    firstName = sharedPreferences.getString("Fname" + userName);
    lastName = sharedPreferences.getString("Lname" + userName);
    mobileNo = sharedPreferences.getString("Mobile" + userName);
    propertyNo = sharedPreferences.getString("Property" + userName);
    imagePath = sharedPreferences.getString("ImagePath" + userName);
    print(imagePath);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.kwhiteColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.kwhiteColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorConstants.kBlackColor,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Scan",
          style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: ColorConstants.kBackGroundImageColor,
                fontFamily: 'NeurialGrotesk-Medium',
              ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.25,
          ),
          RepaintBoundary(
            key: globalKey,
            child: Container(
              color: ColorConstants.kwhiteColor,
              child: QrImage(
                data: widget.qrData,
                size: 180,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width * 0.4,
                    child: TextButtonWidget(
                      btnOntap: () {
                        sendToOwnerrequest();
                      },
                      btnTxt: "Send Request",
                      backColor: ColorConstants.kButtonBackColor,
                      textColor: ColorConstants.kwhiteColor,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: width * 0.4,
                    child: TextButtonWidget(
                      btnOntap: () {
                        _captureAndSharePng();
                      },
                      btnTxt: "Share Code",
                      backColor: ColorConstants.kwhiteColor,
                      textColor: ColorConstants.kButtonBackColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  sendToOwnerrequest() async {
    print(firstName);
    print(imagePath);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GetDataScreen(
          firstNameTxt: firstName,
          lastNameTxt: lastName,
          mobileTxt: mobileNo,
          propertyNo: propertyNo,
          imageDirectory: imagePath,
        ),
      ),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();

      await file.writeAsBytes(pngBytes);

      await Share.file(
        generatedQR,
        '$generatedQR.png',
        pngBytes,
        'image/png',
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
