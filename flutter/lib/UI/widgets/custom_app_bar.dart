import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget _content;

  const CustomAppBar(this._content);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 2)]),
      width: MediaQuery.of(context).size.width,
      height: kToolbarHeight + statusBarHeight,
      child: ClipRRect(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Container(
            margin: EdgeInsets.fromLTRB(0, statusBarHeight, 0, 0),
            child: _content,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
