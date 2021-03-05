import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shared_preference_demo/constants/color_constants.dart';
import 'package:flutter_shared_preference_demo/constants/constants.dart';
import 'package:flutter_shared_preference_demo/screens/send_data_screen.dart';
import 'package:flutter_shared_preference_demo/widget/text_button_widget.dart';
import 'package:flutter_shared_preference_demo/widget/text_form_field_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
Title:SignInScreen
Purpose:SignInScreen
Created By:Kalpesh Khandla
*/

class SignInScreen extends StatefulWidget {
  SignInScreen({
    Key key,
  }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  double height, width;
  TextEditingController userNameController;
  TextEditingController passwordController;
  bool isChecked = true;
  bool isHidden = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode userNameFocus;
  FocusNode passFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userNameController = new TextEditingController();
    passwordController = new TextEditingController();
    userNameFocus = FocusNode();
    passFocus = FocusNode();
    chekRememberMe();
  }

  chekRememberMe() async {
    if (isChecked == true) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var email = preferences.getString("isRememberMe");
      print(email);
      userNameController.text = email;
      print(userNameController.text);
    } else {
      print("Shared Pref");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameFocus.dispose();
    passFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorConstants.kwhiteColor,
      statusBarBrightness: Brightness.light,
    ));

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.kwhiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              Text(
                "Set And Get Values from Shared Preference Demo",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: "NeurialGrotesk-Regular",
                      color: ColorConstants.kBlackColor,
                    ),
              ),
              SizedBox(
                height: height * 0.1/2,
              ),
              FittedBox(
                child: Text(
                  "Welcome Back, Please sign in to your account.",
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontSize: 16,
                        fontFamily: "NeurialGrotesk-Regular",
                        color: ColorConstants.kBlackColor,
                      ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormFieldWidget(
                hintTxt: "Username/Email",
                autoFocusTxt: true,
                focusNode: userNameFocus,
                controllerName: userNameController,
                onChanged: () {
                  print(userNameController.text);
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormFieldWidget(
                hintTxt: "Password",
                focusNode: passFocus,
                controllerName: passwordController,
                obscureText: isHidden,
                suffixIconImg:
                    isHidden ? Icons.visibility_off : Icons.visibility,
                onChanged: () {
                  print(passwordController.text);
                },
                onIconTapped: () {
                  makeVisible();
                },
                onSaved: () {
                  print("ONSAVED");
                },
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        checkColor: ColorConstants.kwhiteColor,
                        activeColor: ColorConstants.kButtonBackColor,
                        onChanged: (bool checked) {
                          setState(() {
                            isChecked = checked;
                          });
                        },
                      ),
                      Text(
                        "Remember Me",
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 14,
                              color: ColorConstants.kBackGroundImageColor,
                              fontFamily: 'NeurialGrotesk-Regular',
                            ),
                      ),
                    ],
                  ),
                  Text(
                    "Forgot Password?",
                    style: Theme.of(context).textTheme.caption.copyWith(
                          fontSize: 14,
                          color: ColorConstants.kBackGroundImageColor,
                          fontFamily: 'NeurialGrotesk-Regular',
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextButtonWidget(
                btnOntap: () {
                  _loginCheck();
                },
                btnTxt: "Sign In",
                backColor: ColorConstants.kButtonBackColor,
                textColor: ColorConstants.kwhiteColor,
              ),
              SizedBox(
                height: height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loginCheck() async {
    String fname = userNameController.text.trim();
    String pass = passwordController.text.trim();

    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (fname == "" && pass == "") {
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
      preferences.setString("isRememberMe", userNameController.text);
      userName = userNameController.text;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SendDataScreen(),
        ),
      );
    }
  }

  void makeVisible() {
    setState(() {
      isHidden = !isHidden;
      print("ISHIDDEN" + isHidden.toString());
    });
  }
}
