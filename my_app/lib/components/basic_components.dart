import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_app/components/component_animatedlist.dart';
import 'package:my_app/components/component_gridview.dart';
import 'package:my_app/components/component_listview.dart';
import 'package:my_app/components/component_scrollcontroller.dart';
import 'package:my_app/components/component_single_child_scrollview.dart';
import 'package:my_app/components/component_tabbarview.dart';
import 'component_pageview.dart';
import 'component_scaffold.dart';
import 'component_text.dart';
import 'component_button.dart';
import 'component_image.dart';
import 'component_switch.dart';
import 'component_textfield.dart';
import 'component_form.dart';
import 'component_indicator.dart';
import 'component_linear_layout.dart';
import 'component_wrap.dart';
import 'component_stack.dart';
import 'component_test.dart';
import 'component_align.dart';
import 'component_constrained_box.dart';
import 'component_flex.dart';
import 'component_layout_builder.dart';
import 'component_decorated_box.dart';
import 'component_transform.dart';
import 'component_container.dart';
import 'component_clip.dart';
import 'component_fitted_box.dart';

class BasicComponents extends StatelessWidget {
  var items = [
    "Text",
    "Button",
    "Image & Icon",
    "Switch & Checkbox",
    "TextField",
    "Form",
    "Indicator",
    "ConstrainedBox & SizeBox",
    "LinearLayout",
    "Flex",
    "Wrap",
    "Stack",
    "Align",
    "LayoutBuilder",
    "DecoratedBox",
    "Transform",
    "Container",
    "Clip",
    "FittedBox",
    "Scaffold",
    "SingleChildScrollView",
    "ListView",
    "ScrollController",
    "AnimatedList",
    "GridView",
    "PageView",
    "TabBarView",
    "Test"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Basic Components"),
        ),
        body: ListView.separated(
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Divider(height: 0, color: Colors.grey[200]),
              );
            },
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400),
                onTap: () {
                  //使用iOS风格的场景切换CupertinoPageRoute
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                    if (0 == index) {
                      return ComponentText();
                    } else if (1 == index) {
                      return ComponentButton();
                    } else if (2 == index) {
                      return ComponentImage();
                    } else if (3 == index) {
                      return ComponentSwitch();
                    } else if (4 == index) {
                      return ComponentTextField();
                    } else if (5 == index) {
                      return ComponentForm();
                    } else if (6 == index) {
                      return ComponentIndicator();
                    } else if (7 == index) {
                      return ComponentConstrainedBox(
                        title: items[index],
                      );
                    } else if (8 == index) {
                      return ComponentLinearLayout();
                    } else if (9 == index) {
                      return ComponentFlex();
                    } else if (10 == index) {
                      return ComponentWrap();
                    } else if (11 == index) {
                      return ComponentStack();
                    } else if (12 == index) {
                      return ComponentAlign();
                    } else if (13 == index) {
                      return LayoutBuilderDemo(title: items[index]);
                    } else if (14 == index) {
                      return DecoratedBoxDemo(title: items[index]);
                    } else if (15 == index) {
                      return TransformDemo(title: items[index]);
                    } else if (16 == index) {
                      return ContainerDemo(title: items[index]);
                    } else if (17 == index) {
                      return ClipDemo(title: items[index]);
                    } else if (18 == index) {
                      return FittedBoxDemo(title: items[index]);
                    } else if (19 == index) {
                      return ScaffoldDemo(title: items[index]);
                    } else if (20 == index) {
                      return SingleChildScrollViewDemo(title: items[index]);
                    } else if (21 == index) {
                      return ListViewDemo(title: items[index]);
                    } else if (22 == index) {
                      return ScrollControllerDemo(title: items[index]);
                    } else if (23 == index) {
                      return AnimatedListDemo(title: items[index]);
                    } else if (24 == index) {
                      return GridViewDemo(title: items[index]);
                    } else if (25 == index) {
                      return PageViewDemo(title: items[index]);
                    } else if (26 == index) {
                      return TabBarViewDemo(title: items[index]);
                    }
                    else {
                      return ComponentTest();
                    }
                  }));
                },
              );
            }));
  }
}
