import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zs_teck/companents/new_models/connections_user_model.dart';

import '../../global_widgets/custom_responsize_textview.dart';

class ScreenUserConnections extends StatelessWidget {
  ScreenUserConnections({super.key, required this.listConnections});

  List<UserConnectionsModel> listConnections = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(labeltext: "connections".tr,fontsize: 18),
        elevation: 0,
      ),
      body: listConnections.isNotEmpty?ListView.builder(
        itemCount: listConnections.length,
          itemBuilder: (context,index){
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(labeltext: "${listConnections.elementAt(index).userRole.toString()} : ",fontsize: 16,maxline: 5),
                SizedBox(width: 10,),
                CustomText(labeltext:listConnections.elementAt(index).userFullname,fontsize: 16,maxline: 5),
               // CustomText(labeltext: listConnections.elementAt(index).valName??"")
              ],
            ),
          ),
        );
      }):Center(child: CustomText(labeltext: "Melumat tapilmadi")),
    );
  }
}
