import 'package:flutter/material.dart';
import 'package:flutter_shared_preference_demo/constants/color_constants.dart';


class TextButtonWidget extends StatelessWidget {
  final String btnTxt;
  final Color backColor;
  final Color textColor;
  final Color borderColor;
  final Function btnOntap;

  const TextButtonWidget({
    Key key,
    @required this.btnTxt,
    @required this.backColor,
    @required this.textColor,
    @required this.btnOntap,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height, width;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      height: 57,
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorConstants.kOrangeColor,
        ),
      ),
      child: TextButton(
        onPressed: btnOntap,
        child: Center(
          child: Text(
            btnTxt,
            style: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'NeurialGrotesk-Medium',
                ),
          ),
        ),
      ),
    );
  }
}
