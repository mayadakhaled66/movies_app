import 'package:flutter/material.dart';

class AppMainPage extends StatelessWidget {
  final Widget pageBody;
  final bool isPageWithAppbar;
  final String? appBarTitle;

  const AppMainPage(
      {required this.pageBody,
      required this.isPageWithAppbar,
      this.appBarTitle,
      Key? key})
      : super(key: key);

  PreferredSizeWidget? buildAppBarWidget() {
    if (isPageWithAppbar) {
      return AppBar(
        title: Text(appBarTitle ?? ""),
      );
    }else{
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(),
      body: pageBody,
    );
  }
}
