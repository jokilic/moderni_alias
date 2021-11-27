import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../general_info/general_info_screen.dart';

class InfoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(16.r),
        alignment: Alignment.topRight,
        child: IconButton(
          icon: const Icon(Icons.info_outline),
          color: whiteColor,
          iconSize: 36.r,
          onPressed: () => Get.toNamed(
            GeneralInfoScreen.routeName,
          ),
        ),
      );
}
