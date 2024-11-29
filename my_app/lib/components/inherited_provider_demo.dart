import 'package:flutter/material.dart';

// class InheritedProvider<T> extends InheritedWidget {
//   InheritedProvider({required super.child, required this.data});
//
//   final T data;
//
//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
//     return true;
//   }
// }

// //子组件用于观察状态的改变
// class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
//   ChangeNotifierProvider({super.key, required this.data, required this.child});
//
//   final T data;
//   final Widget child;
//
//
//   //定义一个便捷方法，方便子树中的widget获取共享数据
//   static InheritedProvider<T>? of<T>(BuildContext context) {
//     final provider =  context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
//     return provider;
//   }
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return ChangeNotifierProviderState();
//   }
// }

// class ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
//
//   void update() {
//     //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
//     setState(() => {});
//   }
//
//   @override
//   void initState() {
//     // 给model添加监听器
//     widget.data.addListener(update);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // 移除model的监听器
//     widget.data.removeListener(update);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return InheritedProvider<T>(data: widget.data, child: widget.child);
//   }
// }