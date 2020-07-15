import 'package:flutter/material.dart';

import '../../../colors.dart';

class NameOfTeam extends StatelessWidget {
  final String hintText;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final TextEditingController textFieldController;

  NameOfTeam({
    this.hintText,
    this.focusNode,
    this.onFieldSubmitted,
    this.textFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0),
      child: TextFormField(
        controller: textFieldController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: buildInputBorder(),
          enabledBorder: buildInputBorder(),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                color: whiteColor.withOpacity(0.6),
              ),
        ),
        cursorColor: whiteColor,
        cursorRadius: Radius.circular(16.0),
        cursorWidth: 4.0,
      ),
    );
  }
}

// Make Input Border
UnderlineInputBorder buildInputBorder() {
  return UnderlineInputBorder(
    borderSide: BorderSide(
      color: whiteColor,
      width: 2.0,
    ),
  );
}
