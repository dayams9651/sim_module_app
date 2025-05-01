
import 'package:get/get.dart';
import 'package:mobile_code/view/home_view.dart';
import '../signUp/view/signUp_screen.dart';

class ApplicationPages {
  static const splashScreen = '/';
  static const homeScreen = '/homeScreen';

  static List<GetPage> getApplicationPages() => [
    GetPage(name: splashScreen, page: () => const SignupScreen()),
    GetPage(name: homeScreen, page: () => DashboardScreen()),
  ];
}
