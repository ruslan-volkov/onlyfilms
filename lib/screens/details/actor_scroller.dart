import 'package:flutter/material.dart';
import 'package:onlyfilms/models/cast.dart';
import 'package:onlyfilms/screens/details/image_viewer.dart';
import 'package:onlyfilms/utilities/localization.dart';

class ActorScroller extends StatelessWidget {
  ActorScroller(this.cast);
  final List<Cast> cast;

  Widget _buildActor(BuildContext ctx, int index) {
    var actor = cast[index];

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          ImageViewer(
              actor.image,
              CircleAvatar(
                backgroundImage: NetworkImage(actor.image),
                radius: 40.0,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(actor.name),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            AppLocalizations.of(context).translate("Cast"),
            style: textTheme.subtitle1.copyWith(fontSize: 18.0),
          ),
        ),
        SizedBox.fromSize(
          size: const Size.fromHeight(120.0),
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(top: 12.0, left: 20.0),
            itemBuilder: _buildActor,
          ),
        ),
      ],
    );
  }
}
