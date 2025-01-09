import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_app/components/component_animatedlist.dart';
import 'package:my_app/components/component_customscrollview.dart';
import 'package:my_app/components/component_gridview.dart';
import 'package:my_app/components/component_listview.dart';
import 'package:my_app/components/component_scrollcontroller.dart';
import 'package:my_app/components/component_single_child_scrollview.dart';
import 'package:my_app/components/component_tabbarview.dart';
import 'package:my_app/components/counter_demo.dart';
import 'package:my_app/components/future_stream.dart';
import 'package:my_app/components/inherited_provider_demo.dart';
import 'package:my_app/components/provider_demo.dart';
import 'package:my_app/components/stream_builder_demo.dart';
import 'package:my_app/components/tapbox_demo.dart';
import 'package:my_app/components/theme_demo.dart';
import 'package:my_app/components/value_listenable_builder_demo.dart';
import 'package:my_app/home/myhomepage.dart';
import 'package:my_app/home/statemanagementtest.dart';
import 'package:my_app/main.dart';
import 'package:provider/provider.dart';
import 'dialog_demo.dart';
import 'component_pageview.dart';
import 'component_scaffold.dart';
import 'component_slivers.dart';
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
import 'dialog_state_demo.dart';
import 'future_builder_demo.dart';
import 'inherited_widget_demo.dart';
import 'layout_demo.dart';

class BasicComponents extends StatelessWidget {
  var items = [
    "Future & Stream",
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
    "CustomScrollView",
    "Slivers",
    "Layout Demo",
    "InheritedWidget Demo",
    "Provider Demo",
    "Theme Demo",
    "ValueListenableBuilder Demo",
    "FutureBuilder Demo",
    "StreamBuilder Demo",
    "Dialog Demo",
    "Dialog Demo2",
    "Counter Widget",
    "TapBox Demo",
    "MyHomePage Demo",
  ];

  BasicComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Basic Components"),
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
                      return FutureDemo(title: items[index]);
                    } else if (1 == index) {
                      return ComponentText();
                    } else if (2 == index) {
                      return ComponentButton();
                    } else if (3 == index) {
                      return ComponentImage();
                    } else if (4 == index) {
                      return const ComponentSwitch();
                    } else if (5 == index) {
                      return const ComponentTextField();
                    } else if (6 == index) {
                      return const ComponentForm();
                    } else if (7 == index) {
                      return const ComponentIndicator();
                    } else if (8 == index) {
                      return ComponentConstrainedBox(
                        title: items[index],
                      );
                    } else if (9 == index) {
                      return const ComponentLinearLayout();
                    } else if (10 == index) {
                      return const ComponentFlex();
                    } else if (11 == index) {
                      return const ComponentWrap();
                    } else if (12 == index) {
                      return const ComponentStack();
                    } else if (13 == index) {
                      return const ComponentAlign();
                    } else if (14 == index) {
                      return LayoutBuilderDemo(title: items[index]);
                    } else if (15 == index) {
                      return DecoratedBoxDemo(title: items[index]);
                    } else if (16 == index) {
                      return TransformDemo(title: items[index]);
                    } else if (17 == index) {
                      return ContainerDemo(title: items[index]);
                    } else if (18 == index) {
                      return ClipDemo(title: items[index]);
                    } else if (19 == index) {
                      return FittedBoxDemo(title: items[index]);
                    } else if (20 == index) {
                      return ScaffoldDemo(title: items[index]);
                    } else if (21 == index) {
                      return SingleChildScrollViewDemo(title: items[index]);
                    } else if (22 == index) {
                      return ListViewDemo(title: items[index]);
                    } else if (23 == index) {
                      return ScrollControllerDemo(title: items[index]);
                    } else if (24 == index) {
                      return AnimatedListDemo(title: items[index]);
                    } else if (25 == index) {
                      return GridViewDemo(title: items[index]);
                    } else if (26 == index) {
                      return PageViewDemo(title: items[index]);
                    } else if (27 == index) {
                      return TabBarViewDemo(title: items[index]);
                    } else if (28 == index) {
                      return CustomScrollViewDemo(title: items[index]);
                    } else if (29 == index) {
                      return SliversDemo(title: items[index]);
                    } else if (30 == index) {
                      return LayoutDemo(title: items[index]);
                    } else if (31 == index) {
                      return InheritedWidgetDemo(title: items[index]);
                    } else if (32 == index) {
                      return ProviderDemo(title: items[index]);
                    } else if (33 == index) {
                      return ThemeDemo(title: items[index]);
                    } else if (34 == index) {
                      return ValueListenableBuilderDemo(title: items[index]);
                    } else if (35 == index) {
                      return FutureBuilderDemo(title: items[index]);
                    } else if (36 == index) {
                      return StreamBuilderDemo(title: items[index]);
                    } else if (37 == index) {
                      return DialogDemo(title: items[index]);
                    } else if (38 == index) {
                      return DialogDemo2(title: items[index]);
                    } else if (39 == index) {
                      return CounterWidget(title: items[index]);
                    } else if (40 == index) {
                      return TapBoxDemo(title: items[index]);
                    } else {
                      return MyHomePage(title: items[index]);
                    }
                  }));
                },
              );
            }));
  }
}
