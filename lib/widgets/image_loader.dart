import 'package:flutter/material.dart';
import 'package:onlyfilms/widgets/custom_image_loading_builder.dart';

class CustomImageLoader extends StatelessWidget {
  CustomImageLoader(this.width, this.height, this.child, this.loadingProgress);
  final double width;
  final double height;
  final Widget child;
  final ImageChunkEvent loadingProgress;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        child: CustomImageLoadingBuilder(child, loadingProgress));
  }
}
