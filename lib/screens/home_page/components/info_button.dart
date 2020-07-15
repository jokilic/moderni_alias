import 'package:flutter/material.dart';

import '../../../colors.dart';
import '../../general_info/general_info_screen.dart';

class InfoButton extends StatelessWidget {
  static const routeName = '/general-info';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.topRight,
      child: IconButton(
        icon: Icon(Icons.info_outline),
        color: whiteColor,
        iconSize: 36.0,
        onPressed: () => Navigator.pushNamed(
          context,
          GeneralInfo.routeName,
        ),
      ),
    );
  }
}
