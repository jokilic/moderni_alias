import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_styles.dart';

class SmallTitle extends StatelessWidget {
  final String title;

  const SmallTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
        child: Text(
          title,
          style: ModerniAliasTextStyles.smallTitle,
        ),
      );
}
