


import 'package:zs_teck/companents/new_models/user_permitions_model.dart';

import '../companents/new_models/logged_usermodel.dart';

class UserPermitionsHelper {
  static String canEnterOtherMerchCustomers="canEnterOtherMerchCustomers";


  bool hasUserPermition(String perCode,List<UserPermitionsModel> listPermitions)  {
   return  listPermitions.any((element)=>element.perCode==perCode);
  }
  bool hasCompanyConfig(String perCode,LoggedUserModel model)  {
   // return model.companyConfigModel!.where((e)=>e.confCode==perCode).first;
    //return  listPermitions.any((element)=>element.code==perCode);
    return false;
  }

}