import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../../general_info/general_info_screen.dart';

class InfoButton extends StatelessWidget {
  static const routeName = '/general-info';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        GeneralInfo.routeName,
      ),
      child: Container(
        padding: EdgeInsets.all(24.0),
        alignment: Alignment.topRight,
        child: Icon(
          Icons.info_outline,
          color: textColor,
          size: 36.0,
        ),
      ),
    );
  }
}
