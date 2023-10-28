import 'package:get/get.dart';
import '../modelss/user.dart';
import '../widgets/event_pref.dart';

class CUser extends GetxController {
  Rx<User> _user = User(0, '', '', '', '', '').obs;

  User get user => _user.value;

  void getUser() async {
    User? user = await EventPref.getUser();
    _user.value = user!;
  }
}
