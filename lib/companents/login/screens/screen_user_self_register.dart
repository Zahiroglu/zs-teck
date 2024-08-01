import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:zs_teck/companents/new_models/company_model.dart';
import 'package:zs_teck/global_widgets/custom_eleveted_button.dart';
import 'package:zs_teck/services/api_database_services/firebase_users_login_controller_mobile.dart';

import '../../../global_widgets/custom_responsize_textview.dart';
import '../../../global_widgets/custom_text_field.dart';
import '../controllers/controller_register_userself.dart';

class ScreenUsersSelfRegister extends StatefulWidget {
  String lisanceId;
  String token;
  String companyId;
  String moduleId;
  String roleId;
  String phoneId;

  ScreenUsersSelfRegister(
      {super.key,
      required this.lisanceId,
      required this.token,
      required this.companyId,
      required this.moduleId,
      required this.roleId,
      required this.phoneId,
      });

  @override
  State<ScreenUsersSelfRegister> createState() =>
      _ScreenUsersSelfRegisterState();
}

class _ScreenUsersSelfRegisterState extends State<ScreenUsersSelfRegister> {
  ControllerRegisterUserself controllerRegisterUserself =
      Get.put(ControllerRegisterUserself());


  @override
  void initState() {
    if(controllerRegisterUserself.initialized){
      controllerRegisterUserself.getCompanyDetails(widget.lisanceId, widget.token, widget.companyId, widget.moduleId, widget.roleId);
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        title: CustomText(
          labeltext: "Qeydiyyat",
        ),
        actions: [],
        centerTitle: false,
      ),
      body: Obx(()=>controllerRegisterUserself.dataLoading.isTrue?const Center(child: CircularProgressIndicator(color: Colors.green,)):Column(
        children: [
          widgetRegionSec(context),
          controllerRegisterUserself.regionSecildi.isTrue?Expanded(child: _istifadeciMelumatlari(context),):const SizedBox(),
        ],
      )),
    ));
  }

  Column widgetRegionSec(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: CustomText(
              maxline: 5,
              labeltext: "Salam hormetli istifadeci.Sizin "+controllerRegisterUserself.selectedCompany.value!.companyName!.toUpperCase()
              +" sirketinde " +controllerRegisterUserself.moduleName.value.toUpperCase()+" sobesinde "+ controllerRegisterUserself.roleName.value.toUpperCase()+" vezifesi uzre lisenziya huqqunuz var.Zehmet olmasa qeydiyyat ucun lazim olan xanalari doldurun."),
        ),
       Padding(
         padding: const EdgeInsets.all(8.0).copyWith(top: 0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           CustomText(
             labeltext: "regionsec".tr,
             fontsize: 16,
             fontWeight: FontWeight.bold,
           ),
           const SizedBox(
             height: 5,
           ),
           SizedBox(
               height: 40,
               width: MediaQuery.of(context).size.width*0.9,
               child: DecoratedBox(
                 decoration: BoxDecoration(
                     color: Colors.white,
                     //background color of dropdown button
                     border: Border.all(
                         color: Colors.blueAccent.withOpacity(0.5), width: 1),
                     //border of dropdown button
                     borderRadius: BorderRadius.circular(5),
                     //border raiuds of dropdown button
                     boxShadow: const <BoxShadow>[
                       //apply shadow on Dropdown button
                       BoxShadow(
                           spreadRadius: 1,
                           color: Color.fromRGBO(0, 0, 0, 0.57),
                           //shadow for button
                           blurRadius: 2)
                       //blur radius of shadow
                     ]),
                 child: controllerRegisterUserself.listRegionlar.isNotEmpty
                     ? DropdownButton(
                     value: controllerRegisterUserself.selectedRegion.value,
                     elevation: 10,
                     icon: const Icon(Icons.expand_more_outlined),
                     underline: const SizedBox(),
                     hint: CustomText(labeltext: "regionsec".tr),
                     alignment: Alignment.center,
                     isDense: false,
                     dropdownColor: Colors.grey,
                     borderRadius: const BorderRadius.all(Radius.circular(15)),
                     items: controllerRegisterUserself.listRegionlar
                         .map<DropdownMenuItem<ModelRegion>>(
                           (lang) => DropdownMenuItem(
                           alignment: Alignment.center,
                           value: controllerRegisterUserself.listRegionlar.isNotEmpty
                               ? lang
                               : ModelRegion(),
                           child: Container(
                               decoration: BoxDecoration(
                                 color: Colors.transparent,
                                 borderRadius: BorderRadius.circular(5), //border raiuds of dropdown button
                               ),
                               height: 50,
                               width: MediaQuery.of(context).size.width*0.8,
                               child: Center(
                                   child: CustomText(
                                       labeltext: lang.regionName.toString())))),
                     )
                         .toList(),
                     onChanged: (val) {
                       if (val != null) {
                         setState(() {
                           controllerRegisterUserself.changeSelectedRegion(val);
                         });
                       }
                     })
                     : SizedBox(),
               ))
         ],),
       )
      ],
    );
  }


  _istifadeciMelumatlari(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(left: 10, right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 0),
                  child: CustomText(labeltext: "${"userCode".tr}"),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      borderColor:
                          controllerRegisterUserself.cttextCodeError.value
                              ? Colors.red
                              : Colors.grey,
                      isImportant: true,
                      icon: Icons.perm_identity,
                      obscureText: false,
                      controller: controllerRegisterUserself.cttextCode,
                      fontsize: 14,
                      hindtext: "userCode".tr,
                      inputType: TextInputType.text,
                    ),
                    controllerRegisterUserself.cttextCodeError.value
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child:
                                controllerRegisterUserself.cttextCodeError.value
                                    ? CustomText(
                                        labeltext: "userCode".tr,
                                        color: Colors.red,
                                        fontsize: 8,
                                      )
                                    : const SizedBox(),
                          )
                        : SizedBox()
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomText(labeltext: "${"ad".tr} : "),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      borderColor:
                          controllerRegisterUserself.cttextAdError.value
                              ? Colors.red
                              : Colors.grey,
                      isImportant: true,
                      icon: Icons.perm_identity,
                      obscureText: false,
                      controller: controllerRegisterUserself.cttextAd,
                      fontsize: 14,
                      hindtext: "ad".tr,
                      inputType: TextInputType.text,
                    ),
                    controllerRegisterUserself.cttextAdError.value
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child:
                                controllerRegisterUserself.cttextAdError.value
                                    ? CustomText(
                                        labeltext: "adsoyaderrorText".tr,
                                        color: Colors.red,
                                        fontsize: 8,
                                      )
                                    : const SizedBox(),
                          )
                        : SizedBox()
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomText(labeltext: "soyad".tr),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      borderColor:
                          controllerRegisterUserself.cttextSoyadError.value
                              ? Colors.red
                              : Colors.grey,
                      isImportant: true,
                      icon: Icons.perm_identity,
                      obscureText: false,
                      controller: controllerRegisterUserself.cttextSoyad,
                      fontsize: 14,
                      hindtext: "soyad".tr,
                      inputType: TextInputType.text,
                    ),
                    controllerRegisterUserself.cttextSoyadError.value
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: controllerRegisterUserself
                                    .cttextSoyadError.value
                                ? CustomText(
                                    labeltext: "adsoyaderrorText".tr,
                                    color: Colors.red,
                                    fontsize: 8,
                                  )
                                : const SizedBox(),
                          )
                        : SizedBox()
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomText(labeltext: "${"userPhone".tr} : "),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      borderColor:
                          controllerRegisterUserself.cttextTelefonError.value
                              ? Colors.red
                              : Colors.grey,
                      isImportant: true,
                      icon: Icons.phone_android_outlined,
                      obscureText: false,
                      controller: controllerRegisterUserself.cttextTelefon,
                      fontsize: 14,
                      hindtext: "userPhone".tr,
                      inputType: TextInputType.phone,
                    ),
                    controllerRegisterUserself.cttextTelefonError.value
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: controllerRegisterUserself
                                    .cttextTelefonError.value
                                ? CustomText(
                                    labeltext: "telefonErrorText".tr,
                                    color: Colors.red,
                                    fontsize: 8,
                                  )
                                : const SizedBox(),
                          )
                        : SizedBox()
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CustomText(labeltext: "${"email".tr} : "),
                ),
                CustomTextField(
                  icon: Icons.email_outlined,
                  obscureText: false,
                  controller: controllerRegisterUserself.cttextEmail,
                  fontsize: 14,
                  hindtext: "email".tr,
                  inputType: TextInputType.emailAddress,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child:
                      CustomText(maxline: 2, labeltext: "${"birthDay".tr} : "),
                ),
                CustomTextField(
                    align: TextAlign.center,
                    suffixIcon: Icons.date_range,
                    obscureText: false,
                    updizayn: true,
                    onTopVisible: () {
                      controllerRegisterUserself.callDatePicker();
                    },
                    // suffixIcon: Icons.date_range,
                    hasBourder: true,
                    borderColor: Colors.black,
                    containerHeight: 40,
                    controller: controllerRegisterUserself.cttextDogumTarix,
                    inputType: TextInputType.datetime,
                    hindtext: "",
                    fontsize: 14)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 4),
                      child: CustomText(labeltext: "cins".tr),
                    ),
                    Row(
                      children: [
                        AnimatedToggleSwitch<bool>.dual(
                          current:
                              controllerRegisterUserself.genderSelect.value,
                          first: true,
                          second: false,
                          dif: 50.0,
                          borderColor: Colors.transparent,
                          borderWidth: 0.5,
                          height: 30,
                          fittingMode: FittingMode.preventHorizontalOverlapping,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  controllerRegisterUserself.genderSelect.value
                                      ? Colors.blueAccent
                                      : Colors.red,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (val) {
                            controllerRegisterUserself
                                .changeSelectedGender(val);
                            return Future.delayed(const Duration(seconds: 0));
                          },
                          colorBuilder: (b) =>
                              b ? Colors.transparent : Colors.transparent,
                          iconBuilder: (value) => value
                              ? Icon(Icons.man_2_outlined,
                                  color: Colors.blueAccent.withOpacity(0.8))
                              : Icon(
                                  Icons.woman_2_outlined,
                                  color: Colors.red.withOpacity(0.8),
                                ),
                          textBuilder: (value) => value
                              ? Center(
                                  child: CustomText(
                                  labeltext: 'Kisi',
                                  fontsize: 16,
                                  fontWeight: FontWeight.w800,
                                ))
                              : Center(
                                  child: CustomText(
                                  labeltext: "Qadin",
                                  fontsize: 16,
                                  fontWeight: FontWeight.w800,
                                )),
                        ),
                      ],
                    )
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomElevetedButton(
                  elevation: 5,
                  width: MediaQuery.of(context).size.width*0.7,
                  icon: Icons.verified_outlined,
                  fontWeight: FontWeight.bold,
                  borderColor: Colors.grey,
                  textColor: Colors.white,
                  textsize: 16,
                  surfaceColor: Colors.green,
                  height: 40,
                  cllback: () {
                    controllerRegisterUserself.regigisterUser(widget.lisanceId, widget.token, widget.companyId, widget.moduleId, widget.roleId,widget.phoneId);
                  },
                  label: "qeydiyyatdanKec".tr),
            )

          ],
        ),
      ),
    );
  }


}
