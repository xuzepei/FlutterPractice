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

  static Widget buildNoDataWidget(String text) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, //让Column高度最小（包裹内容）
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "images/no_data.png",
            width: 70,
            height: 70,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
