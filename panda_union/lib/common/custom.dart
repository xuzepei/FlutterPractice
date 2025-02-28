import 'package:flutter/material.dart';
import 'package:panda_union/common/button.dart';
import 'package:panda_union/util/color.dart';

class MyCustom {
  static AppBar buildAppBar(
      String title, double opacity, BuildContext context, List<Widget>? actions) {
    return AppBar(
      title: Opacity(
        opacity: opacity,
        child: Text(title),
      ),
      //systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0.0,
      shadowColor: MyColors.appBarShadowColor,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      leading: MyButton.appBarLeadingButton(context),
      actions: actions,
    );
  }
}
