import 'package:kidzo_app/Screens/packages/appInformation.dart';

class Children {
  String userId;
  String name;
  String email;
  String code;
  String location;
  String parentid;
  List<Appinformation> appinformation;
  String password;

  Children(this.name, this.email, this.appinformation, this.code,
      this.location, this.userId, this.parentid, this.password);

  Map<String, dynamic> toJSON() {
    return {
      'id': userId,
      'Name': name,
      'Email': email,
      'Password': password,
      'Parentid': parentid,
      'ParentCode': code,
      'Location': '',
      'appinfo': appinformation.map((e) => e.toJson()).toList()
    };
  }
}
