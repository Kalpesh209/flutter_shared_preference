import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_shared_preference_demo/constants/color_constants.dart';


class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controllerName;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final String hintTxt;
  final Function() onChanged;
  final Function() onSaved;
  final IconData suffixIconImg;
  final bool obscureText;
  final Function() onIconTapped;
  final bool autoFocusTxt;

  TextFormFieldWidget({
    Key key,
    @required this.controllerName,
    @required this.hintTxt,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIconImg,
    this.onChanged,
    this.onSaved,
    this.focusNode,
    this.onIconTapped,
    this.autoFocusTxt = false,
    GestureTapCallback onTap,
    FormFieldValidator<String> validator,
    List<TextInputFormatter> inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: 57,
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorConstants.ktextFieldBorderColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: TextFormField(
          autofocus: autoFocusTxt,
          obscureText: obscureText,
          focusNode: focusNode,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.caption.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: "NeurialGrotesk-Regular",
                color: ColorConstants.kHintTextColor,
              ),
          controller: controllerName,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            suffixIcon: GestureDetector(
              onTap: () {
                onIconTapped();
              },
              child: Icon(
                suffixIconImg,
                size: 18,
                color: ColorConstants.kGreyColor,
              ),
            ),
            errorStyle: Theme.of(context).textTheme.caption.copyWith(
                  color: ColorConstants.kRedColor,
                  fontWeight: FontWeight.w700,
                ),
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            hintText: hintTxt,
            hintStyle: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 16,
                  fontFamily: "NeurialGrotesk-Regular",
                  color: ColorConstants.kHintTextColor.withOpacity(0.3),
                ),
            focusedBorder: InputBorder.none,
            focusColor: ColorConstants.kGreenColor,
          ),
          onChanged: (str) {
            onChanged();
            // To do
          },
          onSaved: (str) {
            //  To do
            onSaved();
          },
        ),
      ),
    );
  }
}
