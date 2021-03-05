import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_shared_preference_demo/constants/color_constants.dart';
import 'package:flutter_shared_preference_demo/screens/sign_in_screen.dart';

/*
Title:GetDataScreen
Purpose:GetDataScreen
Created By:Kalpesh Khandla
*/

class GetDataScreen extends StatefulWidget {
  final String firstNameTxt;
  final String lastNameTxt;
  final String mobileTxt;
  final String propertyNo;
  final String imageDirectory;

  GetDataScreen({
    Key key,
    this.firstNameTxt,
    this.lastNameTxt,
    this.mobileTxt,
    this.propertyNo,
    this.imageDirectory,
  }) : super(key: key);

  @override
  _GetDataScreenState createState() => _GetDataScreenState();
}

class _GetDataScreenState extends State<GetDataScreen>
    with TickerProviderStateMixin {
  double height, width;
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    print("HEIGHT" + height.toString());
    print("WIDTH" + width.toString());

    return Scaffold(
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
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: height * 0.4,
                width: width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      File(
                        widget.imageDirectory,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.firstNameTxt,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          fontFamily: "NeurialGrotesk-Bold",
                          color: ColorConstants.kBlackColor,
                        ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.lastNameTxt,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          fontFamily: "NeurialGrotesk-Regular",
                          color: ColorConstants.kBlackColor,
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Mobile No: " + "+91" + widget.mobileTxt,
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: "NeurialGrotesk-Regular",
                      color: ColorConstants.kBlackColor,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Property No: " + widget.propertyNo,
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: "NeurialGrotesk-Regular",
                      color: ColorConstants.kBlackColor,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                child: Lottie.asset(
                  "assets/lottie/success.json",
                  fit: BoxFit.fill,
                  repeat: true,
                  reverse: true,
                  animate: true,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "You request has been approved",
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 18,
                      fontFamily: "NeurialGrotesk-Regular",
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.kprofileAprovedColor,
                    ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  loggedOut();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorConstants.kOrangeColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Log Out",
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 18,
                            fontFamily: "NeurialGrotesk-Regular",
                            fontWeight: FontWeight.w700,
                            color: ColorConstants.kwhiteColor,
                          ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  loggedOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final keys = preferences.getKeys();
    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = preferences.get(key);
    }
    print("SF LOGOUT VALUES" + prefsMap.toString());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
    );
  }
}
