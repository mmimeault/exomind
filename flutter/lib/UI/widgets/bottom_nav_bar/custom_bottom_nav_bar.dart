import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'bottom_navigation_bar_padding_less.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final ValueChanged<int> onTap;
  final int currentIndex;
  final List<BottomNavigationBarItem> items;

  const CustomBottomNavigationBar({@required this.onTap, @required this.currentIndex, @required this.items});

  @override
  Widget build(BuildContext context) {
    return _getContainer(context);
  }

  Widget _getContainer(BuildContext context) {
    final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 4, blurRadius: 4)],
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        color: isDarkMode ? Color(0XFF2E2E2E) : Colors.white,
      ),
      margin: EdgeInsets.fromLTRB(12, 12, 12, math.max(MediaQuery.of(context).padding.bottom, 12)),
      child: _getBar(context),
    );
  }

  Widget _getBar(BuildContext context) {
    return BottomNavigationBarPaddingLess(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      items: items,
      currentIndex: currentIndex,
      selectedItemColor: Color(0XFFFF00AA),
      onTap: onTap,
    );
  }
}
