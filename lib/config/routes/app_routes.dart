import 'package:flutter/material.dart';
import 'package:flutter_application_prgrado/config/routes/routes.dart';
import 'package:flutter_application_prgrado/presentation/pages/camera_managment/camera_managment.dart';
import 'package:flutter_application_prgrado/presentation/pages/home/home_page.dart';
import 'package:flutter_application_prgrado/presentation/pages/information_device/information_driver_page.dart';
import 'package:flutter_application_prgrado/presentation/pages/login/login_page.dart';
import 'package:flutter_application_prgrado/presentation/pages/splash/splash_page.dart';
import 'package:flutter_application_prgrado/presentation/pages/user_profile/user_profile.dart';

import '../../presentation/pages/register/register_page.dart';
import 'dafault.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _materialRoute(SplashPage());
      case Routes.login:
        return _materialRoute(const LoginPage());
      case Routes.register:
        return _materialRoute(const RegisterPage());
      case Routes.home:
        return _materialRoute(HomePage());
      case Routes.cameraManagment:
        return _materialRoute(const CameraManagmentPage());
      case Routes.informationDevicePage:
        return _materialRoute(const InformationDevicePage());

      default:
        return _materialRoute(const Default());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
