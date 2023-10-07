import 'package:flutter/material.dart';
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

class BasicComponents extends StatelessWidget {

  var items = ["Text", "Button", "Image & Icon", "Switch & Checkbox", "TextField","Form", "Indicator","LinearLayout","Wrap","Stack"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Basic Components"),
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    if(0 == index) {
                      return ComponentText();
                    } else if (1 == index){
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
                      return ComponentLinearLayout();
                    } else if (8 == index) {
                      return ComponentWrap();
                    } else if (9 == index) {
                      return ComponentStack();
                    }
                    else 
                    {
                      return ComponentImage();
                    }
                    
                  }));
                },
              );
            }));
  }

} 