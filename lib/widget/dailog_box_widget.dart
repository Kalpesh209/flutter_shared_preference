import 'package:flutter/material.dart';
import 'package:flutter_shared_preference_demo/constants/color_constants.dart';
import 'package:flutter_shared_preference_demo/widget/text_button_widget.dart';


class DialgBoxWidget extends StatelessWidget {
  final String nameTxt;
  final String emailTxt;
  final String mobileTxt;

  const DialgBoxWidget({
    Key key,
    @required this.nameTxt,
    @required this.emailTxt,
    @required this.mobileTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: height * 0.3,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              Text(
                nameTxt,
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.kBackGroundImageColor,
                      fontFamily: 'NeurialGrotesk-Bold',
                    ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                emailTxt,
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 18,
                      color: ColorConstants.kBackGroundImageColor,
                      fontFamily: 'NeurialGrotesk-Regular',
                    ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                mobileTxt,
                style: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 18,
                      color: ColorConstants.kBackGroundImageColor,
                      fontFamily: 'NeurialGrotesk-Regular',
                    ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 50,
                      width: width * 0.3,
                      child: TextButtonWidget(
                        btnOntap: () {},
                        borderColor: ColorConstants.kButtonBackColor,
                        btnTxt: "Approved",
                        backColor: ColorConstants.kButtonBackColor,
                        textColor: ColorConstants.kwhiteColor,
                      ),
                    ),
                  ),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: 50,
                      width: width * 0.3,
                      child: TextButtonWidget(
                        btnOntap: () {},
                        borderColor: ColorConstants.kButtonBackColor,
                        btnTxt: "Rejected",
                        backColor: ColorConstants.kwhiteColor,
                        textColor: ColorConstants.kButtonBackColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
