import 'package:flutter/material.dart';

class Assets {
  final BuildContext _context;

  Assets(this._context);

  AssetImage getThemedImage(String id) {
    final isDarkMode = MediaQuery.of(_context).platformBrightness == Brightness.dark;
    if (isDarkMode) {
      return AssetImage("assets/dark/$id");
    }
    return AssetImage("assets/light/$id");
  }

  AssetImage getImage(String id) {
    return AssetImage(id);
  }

}
