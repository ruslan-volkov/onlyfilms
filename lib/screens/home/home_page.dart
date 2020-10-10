import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/utilities/localization.dart';
import 'package:onlyfilms/widgets/custom_switch.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool choice = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Theme.of(context).backgroundColor,
          child: Stack(
            children: [
              Container(),
              Positioned(
                bottom: ScreenUtil().setHeight(20),
                right: ScreenUtil().setWidth(20),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CustomSwitch(
                          width: ScreenUtil().setWidth(280),
                          height: ScreenUtil().setHeight(100),
                          activeColor: Theme.of(context).splashColor,
                          inactiveColor: Theme.of(context).accentColor,
                          activeText:
                              AppLocalizations.of(context).translate("Movies"),
                          inactiveText:
                              AppLocalizations.of(context).translate("Series"),
                          value: choice,
                          onChanged: (value) {
                            setState(() {
                              choice = value;
                            });
                          },
                        ),
                      ),
                    ]),
              ),
            ],
          )
          // child: Column(
          //   children: [
          //     // TODO : get home page categories
          //     // Upcoming (movie), airing today and on the air (series)
          //     // Latest
          //     // Popular
          //     // Top rated

          //     // bottom right -> switch button tv/movie
          //     Container(
          //         child: Align(
          //       alignment: Alignment.bottomRight,
          //       child: CustomSwitch(
          //         width: ScreenUtil().setWidth(250),
          //         height: ScreenUtil().setHeight(100),
          //         activeColor: Theme.of(context).splashColor,
          //         inactiveColor: Theme.of(context).accentColor,
          //         activeText: AppLocalizations.of(context).translate("Movies"),
          //         inactiveText:
          //             AppLocalizations.of(context).translate("Tv Series"),
          //         value: choice,
          //         onChanged: (value) {
          //           setState(() {
          //             choice = value;
          //           });
          //         },
          //       ),
          //     ))
          //   ],
          // ),
          ),
    );
  }
}
