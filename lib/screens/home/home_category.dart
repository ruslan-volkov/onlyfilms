import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:onlyfilms/models/model.dart';
import 'package:onlyfilms/screens/details/details_page.dart';

class HomeCategory extends StatelessWidget {
  HomeCategory(this.title, this.items);
  final String title;
  final List<Model> items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(30),
                      top: ScreenUtil().setWidth(20),
                      bottom: ScreenUtil().setWidth(20)),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).splashColor,
                        fontSize: ScreenUtil().setSp(50)),
                  )),
              Container(
                height: ScreenUtil().setHeight(500),
                child: ListView.builder(
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: _buildCard,
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildCard(BuildContext context, int index) {
    const POSTER_RATIO = 0.7; // return Container();
    var height = ScreenUtil().setHeight(500);
    var width = POSTER_RATIO * height;
    var item = items[index];
    return Row(children: [
      SizedBox(width: ScreenUtil().setWidth(30)),
      Material(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(4.0),
          elevation: 2.0,
          child: Stack(
            children: <Widget>[
              Image.network(
                item.image,
                fit: BoxFit.cover,
                width: width,
                height: height,
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.blueGrey.withOpacity(0.5),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPage(item)),
                      );
                    },
                  ),
                ),
              ),
            ],
          ))
    ]);
  }
}
