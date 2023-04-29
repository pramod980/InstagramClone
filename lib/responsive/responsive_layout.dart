import 'package:flutter/material.dart';
import 'package:instagram_clone/utilities/dimension.dart';

class Responsive extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const Responsive(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      if (Constraints.maxWidth > webScreen) {
        return webScreenLayout;
      }
      return mobileScreenLayout;
    });
  }
}
