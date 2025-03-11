import 'package:flutter/material.dart';
import 'package:panda_union/common/button.dart';
import 'package:panda_union/util/color.dart';

class MyCustom {
  static AppBar buildAppBar(
      String title, double opacity, BuildContext context, [List<Widget>? actions, bool? hideLeading]) {
    return AppBar(
      title: Opacity(
        opacity: opacity,
        child: Text(title),
      ),
      centerTitle: true,
      //systemOverlayStyle: SystemUiOverlayStyle.dark,
      //automaticallyImplyLeading: hideAppBar == true ? false : true,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      leading: hideLeading == true ? null : MyButton.appBarLeadingButton(context),
      actions: actions,
    );
  }
}
