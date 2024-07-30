import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../app_permitions/permitions_controller.dart';
import '../../../global_widgets/custom_eleveted_button.dart';
import '../../../global_widgets/custom_responsize_textview.dart';
import '../../../routs/rout_controller.dart';
import '../../../services/local_databases_services/local_users_services.dart';

class LoginMobileFirstScreen extends StatefulWidget {
  const LoginMobileFirstScreen({Key? key}) : super(key: key);

  @override
  State<LoginMobileFirstScreen> createState() => _LoginMobileFirstScreenState();
}

class _LoginMobileFirstScreenState extends State<LoginMobileFirstScreen> {
  List<SliderModel> mySLides = [];
  int slideIndex = 0;
  late PageController controller;
  LocalUserServices userLocalService=LocalUserServices();
  LocalPermissionsController localPermissionsController=LocalPermissionsController();
  bool backLocationPermition=false;
  bool notificationPermition=false;
  bool notificationFirebasePermition=false;
  bool dataLoading=false;


  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  initState()  {
    // TODO: implement initState
    super.initState();
    //mySLides = getSlides();
    controller = PageController(initialPage: slideIndex);
    controller.addListener(() => _changeIndex());
    fillRequestList();
  }

  fillRequestList() async {
    setState(() {
      dataLoading=true;
    });
    backLocationPermition=await localPermissionsController.checkBackgroundLocationPermission();
    if(!backLocationPermition){
      mySLides.add(SliderModel(
        desc: "Hormetli istifadeci,program is vaxti canli izlemeni temin etmek ucun gps icazesine ehtiyac duyur"
            ".Programin duzgun islemesi ucun arxa panel gpz izleme icazesini vermeyiniz lazimdir."
            "Eks halda program islemeyecekdir.Program ayarlarindan 'Hemise icaze ver'-i secin",
        title: "Gps izleme icazesi",
        imageAssetPath: "lottie/lottie_permition_request.json"
      ));
    }
    notificationPermition=await localPermissionsController.checkNotyPermission();
    notificationFirebasePermition=await localPermissionsController.checkForFirebaseNoticifations();
     if(!notificationPermition){
       mySLides.add(SliderModel(
           desc: "Hormetli istifadeci,program bildirisleri gostere bilmek ucun bildiris icazesine ehtiyac duyur.Zehmet olmasa icaze verin",
           title: "Bildirişler icazesi",
           imageAssetPath: "lottie/lottie_notification.json"
       ));
     }
    notificationFirebasePermition=await localPermissionsController.checkForFirebaseNoticifations();
     if(!notificationFirebasePermition){
       mySLides.add(SliderModel(
           desc: "Hormetli istifadeci,sirket daxili bildirislerin size vaxtinda gonderilmesi ucun icazeye ehtoyac var.Zehmet olmasa icaze verin",
           title: "Server bildirişler icazesi",
           imageAssetPath: "lottie/lotie_fire_mesaje.json"
       ));

     }
    setState(() {
      dataLoading=false;
    });
  }

  _changeIndex() {
    setState(() {
      slideIndex == controller.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: dataLoading?const Center(child: CircularProgressIndicator(color: Colors.blue,),): Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller,
                    onPageChanged: (index) {
                      setState(() {
                        slideIndex = index;
                      });
                    },
                    children: <Widget>[
                      SlideTile(
                        permissionsController: localPermissionsController,
                        model: mySLides[0],siraSayil: 0,listCount: mySLides.length,callBack: (v){
                        controller.animateToPage(v, duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
                      },),
                      SlideTile(
                        permissionsController: localPermissionsController,
                        model: mySLides[1],siraSayil: 1,listCount: mySLides.length,callBack: (v){},),
                      SlideTile(
                        permissionsController: localPermissionsController,
                        model: mySLides[2],siraSayil: 2,listCount: mySLides.length,callBack: (v){},),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // bottomSheet: slideIndex == mySLides.length - 1
          //     ? Container(
          //         margin:
          //             const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: <Widget>[
          //             const Spacer(),
          //             const Spacer(),
          //             Row(
          //               children: [
          //                 for (int i = 0; i < mySLides.length; i++)
          //                   i == slideIndex
          //                       ? _buildPageIndicator(true)
          //                       : _buildPageIndicator(false),
          //               ],
          //             ),
          //             const Spacer(),
          //             CustomElevetedButton(
          //                 cllback: () async {
          //                   Get.offNamed(RouteHelper.mobileLisanceScreen);
          //                   await userLocalService.addValueForAppFistTimeOpen(true);
          //                 },
          //                 label: "giris".tr,
          //                 surfaceColor: Colors.blue.withOpacity(0.3),
          //                 width: 200,
          //                 height: 20,
          //                 elevation: 6),
          //           ],
          //         ),
          //       )
          //     : Container(
          //         margin:
          //             const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: <Widget>[
          //             Row(
          //               children: [
          //                 for (int i = 0; i < mySLides.length; i++)
          //                   i == slideIndex
          //                       ? _buildPageIndicator(true)
          //                       : _buildPageIndicator(false),
          //               ],
          //             ),
          //             CustomElevetedButton(
          //                 cllback: () {
          //                   controller.animateToPage(slideIndex + 1,
          //                       duration: const Duration(milliseconds: 400),
          //                       curve: Curves.linear);
          //                 },
          //                 label: "next".tr,
          //                 surfaceColor: Colors.green.withOpacity(0.3),
          //                 width: 100,
          //                 height: 20,
          //                 elevation: 10),
          //           ],
          //         ),
          //       )
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
  SliderModel model;
  int siraSayil;
  int listCount;
  Function(int) callBack;
  LocalPermissionsController permissionsController;

  SlideTile({required this.permissionsController,required this.model, required this.siraSayil, required this.listCount,required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 10,
              child: Lottie.asset(model.getImageAssetPath()!,filterQuality: FilterQuality.medium,fit: BoxFit.fill)),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 1,
            child: CustomText(
                color: Colors.blue.withOpacity(0.8),
                labeltext: model.getTitle()!,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                fontsize: 24,
                latteSpacer: 0.1,
                maxline: 2),
          ),
          const SizedBox(height: 5,),
          Expanded(
            flex: 4,
            child: CustomText(
                labeltext: model.getDesc()!,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.normal,
                fontsize: 20,
                maxline: 5),
          ),
          const SizedBox(height: 5,),
          CustomElevetedButton(
            fontWeight: FontWeight.bold,
            icon: Icons.verified,
            textColor: Colors.blue,
            borderColor: Colors.black,
            elevation: 10,
            height: 40,
              width: MediaQuery.of(context).size.width*0.5,
              cllback: () async {
              switch(siraSayil){
                case 0:
                  if(siraSayil!=listCount){
                    await permissionsController.checkBackgroundLocationPermission().then((v) async {
                      await permissionsController.checkBackgroundLocationPermission().then((val){
                        if(val){
                          callBack.call(siraSayil+1);
                        }
                      });
                    });
                  }
                  break;
              }


              }, label: "Icaze ver")
        ],
      ),
    );
  }
}

class SliderModel {
  String? imageAssetPath;
  String? title;
  String? desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String? getImageAssetPath() {
    return imageAssetPath;
  }

  String? getTitle() {
    return title;
  }

  String? getDesc() {
    return desc;
  }
}
