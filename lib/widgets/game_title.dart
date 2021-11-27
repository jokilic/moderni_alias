import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameTitle extends StatelessWidget {
  final String title;

  const GameTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          top: 24.h,
          left: 24.w,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
      );
}
