import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import '../../../thema/theme_constants.dart';
import '../../new_models/logged_usermodel.dart';
import '../controller/drawer_menu_controller.dart';

class CustomDrawerWindos extends StatefulWidget {
  CustomDrawerWindos({
    required this.drawerMenuController,
    required this.userModel,
    required this.appversion,
    required this.closeDrawer,
    required this.data,
    required this.scaffoldkey,
    required this.logout,
    required this.initialSelected,
    Key? key,
  }) : super(key: key);

  final String appversion;
  final int initialSelected;
  final Function(bool) logout;
  final Function(int index) data;
  final Function(bool clouse) closeDrawer;
  final GlobalKey<ScaffoldState> scaffoldkey;
  DrawerMenuController drawerMenuController=Get.put(DrawerMenuController());
  LoggedUserModel userModel;

  @override
  State<CustomDrawerWindos> createState() => _CustomDrawerWindosState();
}

class _CustomDrawerWindosState extends State<CustomDrawerWindos> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
   // Get.delete<DrawerMenuController>();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 20,bottom: 20),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            borderRadius:  const BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            color: colorPramary.withOpacity(0.4),
          ),
          padding: const EdgeInsets.only(top: 10,bottom: 10),
          child: widget.drawerMenuController.getItemsMenu(widget.closeDrawer,true,widget.scaffoldkey),
        )
      ),
    );
  }


}
