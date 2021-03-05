import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shared_preference_demo/constants/color_constants.dart';
import 'package:flutter_shared_preference_demo/constants/constants.dart';
import 'package:flutter_shared_preference_demo/screens/get_data_screen.dart';
import 'package:flutter_shared_preference_demo/screens/scan_qr_screen.dart';
import 'package:flutter_shared_preference_demo/widget/text_button_widget.dart';
import 'package:flutter_shared_preference_demo/widget/text_form_field_widget.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
Title:SendDataScreen
Purpose:SendDataScreen
Created By:Kalpesh Khandla
*/

class SendDataScreen extends StatefulWidget {
  SendDataScreen({
    Key key,
  }) : super(key: key);

  @override
  _SendDataScreenState createState() => _SendDataScreenState();
}

class _SendDataScreenState extends State<SendDataScreen> {
  double height, width;
  TextEditingController firstNameController;
  TextEditingController lastnameController;
  TextEditingController mobileController;
  TextEditingController propertyNoController;

  File _image;
  bool isQRvisible = false;
  String generatedQR;
  Uint8List _imageFile;
  String _imagePath;

  GlobalKey globalKey = new GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstNameController = new TextEditingController();
    lastnameController = new TextEditingController();
    mobileController = new TextEditingController();
    propertyNoController = new TextEditingController();

    getDefaultValues();
  }

  getDefaultValues() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    firstNameController.text = sharedPreferences.getString("Fname" + userName);
    lastnameController.text = sharedPreferences.getString("Lname" + userName);
    mobileController.text = sharedPreferences.getString("Mobile" + userName);
    propertyNoController.text =
        sharedPreferences.getString("Property" + userName);
    loadImagePath();
  }

  void loadImagePath() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      _imagePath = sharedPreferences.getString("ImagePath" + userName);
    });
    print(_imagePath);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    String name = firstNameController.text;
    String lName = lastnameController.text;
    String mobile = mobileController.text;
    String property = propertyNoController.text;

    generatedQR = "First Name: " +
        name +
        "Last Name: " +
        lName +
        "Mobile: " +
        mobile +
        "Property No: " +
        property;
    return Scaffold(
      key: _scaffoldKey,
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
          "Profile",
          style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: ColorConstants.kBackGroundImageColor,
                fontFamily: 'NeurialGrotesk-Medium',
              ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        getImage(ImgSource.Both);
                      },
                      child: _image != null
                          ? CircleAvatar(
                              radius: 56,
                              backgroundImage: FileImage(_image),
                            )
                          : Container(
                              height: 112,
                              width: 112,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(112 / 2),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: ExactAssetImage(
                                    "assets/images/user.png",
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26 / 2),
                          color: ColorConstants.kwhiteColor,
                          border: Border.all(
                            color: ColorConstants.kButtonBackColor,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          size: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldWidget(
                  hintTxt: "First Name",
                  keyboardType: TextInputType.text,
                  controllerName: firstNameController,
                  onChanged: () {
                    print(firstNameController.text);
                  },
                  onSaved: () {
                    print("ONSAVED");
                  }),
              SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                hintTxt: "Last Name",
                keyboardType: TextInputType.text,
                controllerName: lastnameController,
                onChanged: () {
                  print(firstNameController.text);
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                  hintTxt: "Mobile",
                  controllerName: mobileController,
                  keyboardType: TextInputType.number,
                  onChanged: () {
                    print(firstNameController.text);
                  },
                  onSaved: () {
                    print("ONSAVED");
                  }),
              SizedBox(
                height: 10,
              ),
              TextFormFieldWidget(
                  hintTxt: "Property Number",
                  controllerName: propertyNoController,
                  keyboardType: TextInputType.number,
                  onChanged: () {
                    print(firstNameController.text);
                  },
                  onSaved: () {
                    print("ONSAVED");
                  }),
              SizedBox(
                height: 20,
              ),
              Visibility(
                visible: isQRvisible,
                child: RepaintBoundary(
                  key: globalKey,
                  child: QrImage(
                    data: "First Name: " +
                        name +
                        "\n"
                            "Last Name: " +
                        lName +
                        "\n"
                            "Mobile: " +
                        mobile +
                        "\n"
                            "Property: " +
                        property,
                    size: 180,
                  ),
                ),
              ),
              isQRvisible
                  ? Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButtonWidget(
                          btnOntap: () {
                            saveData();
                          },
                          btnTxt: "Save & Send Data",
                          backColor: ColorConstants.kButtonBackColor,
                          textColor: ColorConstants.kwhiteColor,
                        ),
                      ),
                    )
                  : Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButtonWidget(
                          btnOntap: () {
                            generateQRCode();
                          },
                          btnTxt: "Create QR Code",
                          backColor: ColorConstants.kButtonBackColor,
                          textColor: ColorConstants.kwhiteColor,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  generateQRCode() {
    String fname = firstNameController.text;
    String lName = lastnameController.text;
    String mobile = mobileController.text;
    String property = propertyNoController.text;

    if (fname == "" && lName == "" && mobile == "" && property == "") {
      var snackBar = SnackBar(
        content: Text(
          'Please Enter Details Properly....',
          style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ColorConstants.kwhiteColor,
              ),
        ),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    } else {
      setState(() {
        isQRvisible = true;
      });
    }
  }

  saveData() async {
    String fname = firstNameController.text;
    String lname = lastnameController.text;
    String mobile = mobileController.text;
    String property = propertyNoController.text;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("Fname" + userName, fname);
    sharedPreferences.setString("Lname" + userName, lname);
    sharedPreferences.setString("Mobile" + userName, mobile);
    sharedPreferences.setString("Property" + userName, property);
    String data = "First Name: " +
        fname +
        "\n"
            "Last Name: " +
        lname +
        "\n"
            "Mobile: " +
        mobile +
        "\n"
            "Property No: " +
        property;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScanQRScreen(
          qrData: data,
        ),
      ),
    );
  }

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
        context: context,
        source: source,
        cameraIcon: Icon(
          Icons.camera_alt,
          color: ColorConstants.kButtonBackColor,
        ),
        cameraText: Text(
          "From Camera",
          style: TextStyle(
            color: ColorConstants.kButtonBackColor,
          ),
        ),
        galleryText: Text(
          "From Gallery",
          style: TextStyle(
            color: Colors.blue,
          ),
        ));
    setState(() {
      _image = image;
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("ImagePath" + userName, _image.path);
    });
  }
}
