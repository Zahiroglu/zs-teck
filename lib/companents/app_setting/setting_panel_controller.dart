
import 'package:get/get.dart';
import '../../services/local_databases_services/local_users_services.dart';
import '../new_models/user_model.dart';

class SettingPanelController extends GetxController{
  Rx<UserModel> modelModule = UserModel().obs;
  LocalUserServices localUserServices=LocalUserServices();


   @override
  void onInit() {
     getCurrentLoggedUserFromLocale();
    // TODO: implement onInit
    super.onInit();
  }

   Future<void> getCurrentLoggedUserFromLocale([UserModel? model]) async{
     if(model!=null){
       modelModule.value=model;
     }else {
       localUserServices.init();
       modelModule.value = localUserServices
           .getLoggedUser()
           .userModel!;
     }


     print("getCurrentLoggedUserFromLocale :"+modelModule.value.toString());
     update();
   }


}