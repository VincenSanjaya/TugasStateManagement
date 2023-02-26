import 'package:flutter/material.dart';
import 'dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget portraitBody;
  final Widget landscapeBody;

  ResponsiveLayout({required this.portraitBody, required this.landscapeBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileWidth) {
          return portraitBody;
        } else {
          return landscapeBody;
        }
      },
    );
  }
}