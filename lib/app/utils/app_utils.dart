import 'package:chatapp_ksn/services/share_preference.dart';

class AppFont {
  static const String poppins = 'Poppins';
}

Future<String> getSharedPreferenceValue(String key) async {
  return await SharedPrefService.instance.getPrefStringValue(key) ?? "";
}
