import 'package:get/get.dart';

import '../modules/activityLogs/bindings/activity_logs_binding.dart';
import '../modules/activityLogs/views/activity_logs_view.dart';
import '../modules/create_user/bindings/create_user_binding.dart';
import '../modules/create_user/views/create_user_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/otpPage/bindings/otp_page_binding.dart';
import '../modules/otpPage/views/otp_page_view.dart';
import '../modules/password_details/bindings/password_details_binding.dart';
import '../modules/password_details/views/password_details_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/user_password_info/bindings/user_password_info_binding.dart';
import '../modules/user_password_info/views/user_password_info_view.dart';
import '../modules/user_passwords/bindings/user_passwords_binding.dart';
import '../modules/user_passwords/views/user_passwords_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP_PAGE,
      page: () => const OtpPageView(),
      binding: OtpPageBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_USER,
      page: () => CreateUserView(),
      binding: CreateUserBinding(),
    ),
    GetPage(
      name: _Paths.USER_PASSWORDS,
      page: () => const UserPasswordsView(),
      binding: UserPasswordsBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_DETAILS,
      page: () => const PasswordDetailsView(),
      binding: PasswordDetailsBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.USER_PASSWORD_INFO,
      page: () => const UserPasswordInfoView(),
      binding: UserPasswordInfoBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITY_LOGS,
      page: () => const ActivityLogsView(),
      binding: ActivityLogsBinding(),
    ),
  ];
}
