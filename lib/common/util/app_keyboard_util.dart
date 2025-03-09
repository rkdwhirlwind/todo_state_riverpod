import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
//import 'package:keyboard_utils/keyboard_listener.dart' as k;
//import 'package:keyboard_utils/keyboard_utils.dart';

class AppKeyboardUtil {
  static void hide(BuildContext context) {
    FocusScope.of(context).unfocus();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void show(BuildContext context, FocusNode node) {
    FocusScope.of(context).unfocus();
    Timer(const Duration(milliseconds: 1), () {
      FocusScope.of(context).requestFocus(node);
    });
  }
}

mixin KeyboardDetector<T extends StatefulWidget> on State<T> {
  //final keyboardUtils = KeyboardUtils();
  late StreamSubscription<bool> keyboardSubscription;
  int? subscribingId;
  bool isKeyboardOn = false;
  final bool useDefaultKeyboardDetectorInit = true;

  @override
  void initState() {
    if (useDefaultKeyboardDetectorInit) {
      initKeyboardDetector();
    }
    super.initState();
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  void initKeyboardDetector({
    final Function()? willHideKeyboard,
    final Function()? willShowKeyboard,
  }) {
    keyboardSubscription =
        KeyboardVisibilityController().onChange.listen((bool visible) {
          if (visible) {
            if (willShowKeyboard != null) {
              willShowKeyboard();
            }
          } else {
            if (willHideKeyboard != null) {
              willHideKeyboard();
            }
          }
          setState(() {
            isKeyboardOn = visible;
          });
        });
  }
}