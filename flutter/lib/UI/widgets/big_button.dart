import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final VoidCallback _onTap;
  final String title;

  BigButton(this._onTap, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Material(
              color: Theme.of(context).accentColor,
              child: InkWell(
                onTap: _onTap,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
