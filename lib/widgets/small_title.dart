import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallTitle extends StatelessWidget {
  final String title;

  const SmallTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontSize: 26,
              ),
        ),
      );
}
