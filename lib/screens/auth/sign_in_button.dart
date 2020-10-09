import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SignInButton extends StatelessWidget {
  SignInButton(
      {@required this.context,
      @required this.onPressed,
      @required this.text,
      this.logo});
  final BuildContext context;
  final Function onPressed;
  final String text;
  final Image logo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // match_parent
      child: OutlineButton(
        color: Colors.white,
        splashColor: Colors.grey,
        onPressed: () => onPressed(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        highlightElevation: 0,
        borderSide: BorderSide(color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              logo != null
                  ? logo
                  : SizedBox(height: ScreenUtil().setHeight(35)),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
