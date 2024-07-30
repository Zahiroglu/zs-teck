import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:zs_teck/companents/new_models/user_permitions_model.dart';

import '../../global_widgets/custom_responsize_textview.dart';

class ScreenUserPermisions extends StatelessWidget {
  ScreenUserPermisions({super.key, required this.listPermisions});

  List<UserPermitionsModel> listPermisions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(labeltext: "icazeler".tr,fontsize: 18),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: listPermisions.length,
          itemBuilder: (context,index){
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(labeltext: listPermisions.elementAt(index).perValue,fontsize: 16,maxline: 5),
                const Icon(Icons.verified_user_outlined,color: Colors.green,)
               // CustomText(labeltext: listPermisions.elementAt(index).valName??"")
              ],
            ),
          ),
        );
      }),
    );
  }
}
