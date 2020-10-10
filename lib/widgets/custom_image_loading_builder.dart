import 'package:flutter/material.dart';
import 'package:onlyfilms/widgets/progress_indicator.dart';

class CustomImageLoadingBuilder extends StatelessWidget {
  CustomImageLoadingBuilder(this.child, this.loadingProgress);
  final Widget child;
  final ImageChunkEvent loadingProgress;
  @override
  Widget build(BuildContext context) {
    if (loadingProgress == null) return child;
    return Center(
      child: CustomProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes
              : null),
    );
  }
}
