import 'package:kidzo_app/Screens/packages/appInformation.dart';

class Children {
  String userId;
  String name;
  String email;
  String code;
  String latitude;
  String longitude;
  String parentid;
  List<Appinformation> appinformation;
  String password;
  bool screenLock;
  String token;
  

  Children(
      this.name,
      this.email,
      this.appinformation,
      this.code,
      this.latitude,
      this.longitude,
      this.userId,
      this.parentid,
      this.password,
      this.screenLock,
      this.token);

  Map<String, dynamic> toJSON() {
    return {
      'id': userId,
      'Name': name,
      'Email': email,
      'Password': password,
      'Parentid': parentid,
      'ParentCode': code,
      'latitude': latitude,
      'longitude': longitude,
      'appinfo': appinformation.map((e) => e.toJson()).toList(),
      'Screen locked': screenLock,
      'token': token
    };
  }
}
