import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import '../../../global_widgets/custom_responsize_textview.dart';
import '../../../thema/theme_constants.dart';
import '../../new_models/logged_usermodel.dart';
import '../controller/drawer_menu_controller.dart';

class CustomDrawerMobile extends StatefulWidget {
  CustomDrawerMobile({
    required this.drawerMenuController,
    required this.userModel,
    required this.appversion,
    required this.closeDrawer,
    required this.data,
    required this.scaffoldkey,
    required this.initialSelected,
    Key? key,
  }) : super(key: key);

  final String appversion;
  final int initialSelected;
  final Function(int index) data;
  final Function(bool clouse) closeDrawer;
  final GlobalKey<ScaffoldState> scaffoldkey;
  DrawerMenuController drawerMenuController=Get.put(DrawerMenuController());
  LoggedUserModel userModel;

  @override
  State<CustomDrawerMobile> createState() => _CustomDrawerMobileState();
}

class _CustomDrawerMobileState extends State<CustomDrawerMobile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 5),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          borderRadius:  const BorderRadius.only(
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(0)),
          color: colorPramary.withOpacity(0.4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Expanded(
                flex: 2,
                child: widgetHeader()),
            const Divider(thickness: 3,endIndent: 5,indent: 5),
            Expanded(
              flex: 13,
              child: widget.drawerMenuController.getItemsMenu(widget.closeDrawer,false,widget.scaffoldkey),
            ),
            // const SizedBox(
            //   height: 50,
            // )
          ],
        ),
      ),
    );
  }

  Padding widgetHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: 30,
                minRadius: 20,
                backgroundColor: Colors.white,
                child:  Image.asset(
                  widget.userModel.userModel!.userGender==1
                      ? "images/imagewoman.png"
                      : "images/imageman.png",
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(labeltext: "${widget.userModel.userModel!.userName} ${widget.userModel.userModel!.userSurname} - ${widget.userModel.userModel!.temKod}",fontWeight: FontWeight.w700,fontsize: 16,overflow: TextOverflow.ellipsis,),
                    SizedBox(width: 5,),
                    CustomText(labeltext: "${widget.userModel.userModel!.moduleName}",fontWeight: FontWeight.w500,fontsize: 14,overflow: TextOverflow.ellipsis,),
                    CustomText(labeltext: "${widget.userModel.userModel!.roleName}",fontWeight: FontWeight.w500,fontsize: 14,overflow: TextOverflow.ellipsis,),

                  ],
                ),
              )

            ],
          ),
        ],
      ),
    );
  }

}
