import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/presentation/widgets/appBar/appBar_custom.dart';

class BodyBase extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const BodyBase(this.title, this.children, {super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarCustom(title: title),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}

class BodyBaseChild extends StatelessWidget {
  final String title;
  final Widget child;
  const BodyBaseChild(this.title, {super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarCustom(title: title),
        body: Container(padding: EdgeInsets.all(16.0), child: child),
      ),
    );
  }
}
