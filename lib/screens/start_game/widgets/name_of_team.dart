import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_styles.dart';

class NameOfTeam extends StatelessWidget {
  final String hintText;
  final Function(String value) onChanged;
  final TextInputAction textInputAction;

  const NameOfTeam({
    required this.hintText,
    required this.onChanged,
    required this.textInputAction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 36.w,
          vertical: 12.h,
        ),
        child: TextField(
          textInputAction: textInputAction,
          onChanged: onChanged,
          style: ModerniAliasTextStyles.teamNameTextField,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: buildInputBorder(),
            enabledBorder: buildInputBorder(),
            hintText: hintText,
            hintStyle: ModerniAliasTextStyles.nameOfTeamHint,
          ),
          cursorColor: ModerniAliasColors.whiteColor,
          cursorRadius: Radius.circular(16.r),
          cursorWidth: 4.w,
        ),
      );
}

// Make Input Border
UnderlineInputBorder buildInputBorder() => UnderlineInputBorder(
      borderSide: BorderSide(
        color: ModerniAliasColors.whiteColor,
        width: 2.w,
      ),
    );
