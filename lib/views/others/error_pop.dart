import 'package:flutter_easyloading/flutter_easyloading.dart';

//Shows Error PopUp whenver Called
void errorPopup(String err) {
  EasyLoading.dismiss();
  EasyLoading.showError(err, dismissOnTap: true);
}
