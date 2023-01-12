// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../constants/strings.dart';
import 'stats_table_row_widget.dart';

class StatsAnimatedList extends StatelessWidget {
  final List<StatsTableRowWidget>? widgets;
  final bool isOpen;
  final bool isListView;
  final ListView? listView;

  const StatsAnimatedList({
    this.widgets,
    this.listView,
    this.isOpen = false,
    this.isListView = false,
  });

  @override
  Widget build(BuildContext context) => AnimatedSize(
        duration: ModerniAliasDurations.animation,
        curve: Curves.easeIn,
        alignment: Alignment.centerLeft,
        child: isOpen
            ? isListView
                ? listView
                : Column(children: widgets!)
            : const SizedBox(),
      );
}
