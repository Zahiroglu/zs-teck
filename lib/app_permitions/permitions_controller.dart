import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class LocalPermissionsController {
  FirebaseMessaging messaging=FirebaseMessaging.instance;
  //firebase notifications
  Future<bool> checkForFirebaseNoticifations()async{
    bool status=false;
    messaging.getNotificationSettings().then((val){
      if(val.authorizationStatus==AuthorizationStatus.authorized){
        status= true;
      }else{
        status= false;
      }
    });
    return status;
  }

  Future<bool> reguestForFirebaseNoty() async {
    NotificationSettings settings=await messaging.requestPermission(
        alert: true,
        badge: true,
        announcement: true,
        sound: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true
    );
    if(settings.authorizationStatus==AuthorizationStatus.authorized){
      return true;
    }else{
      return false;
    }
  }

  // Method to check if location permission is granted
  Future<bool> checkLocationPermission() async {
    return await Permission.location.isGranted;
  }

  Future<bool> checkNotyPermission() async {
    return await Permission.notification.isGranted;
  }

  // Method to request location permission
  Future<void> requestLocationPermission() async {
    await Permission.location.request();
  }

  // Method to check if background location permission is granted
  Future<bool> checkBackgroundLocationPermission() async {
    if (await Permission.location.isGranted) {
      return await Permission.locationAlways.isGranted;
    }
    return false;
  }

  // Method to request background location permission
  Future<void> requestBackgroundLocationPermission() async {
    if (!(await Permission.location.isGranted)) {
      await Permission.locationAlways.request();
    }
    await Permission.locationAlways.request();

  }
  Future<void> requestNotyPermission() async {
    if (!(await Permission.notification.isGranted)) {
      await Permission.notification.request();
    }
    await Permission.notification.request();
  }
}