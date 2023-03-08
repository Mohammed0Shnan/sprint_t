

import 'package:client_app/di/components/app.component.dart';
import 'package:client_app/main.dart';
import 'package:client_app/module_products/product_module.dart';
import 'package:client_app/module_products/ui/screens/products_screen.dart';
import 'package:client_app/module_splash/screen/splash_screen.dart';
import 'package:client_app/module_splash/splash_module.dart';

class AppComponentInjector implements AppComponent {
  AppComponentInjector._();

  static Future<AppComponent> create() async {
    final injector = AppComponentInjector._();
    return injector;
  }

  MyApp _createApp() => MyApp(
      _createSplashModule(),
      _createProductModule()
  );


  SplashModule _createSplashModule() =>
      SplashModule(SplashScreen());
  ProductsModule _createProductModule() =>
      ProductsModule(ProductsScreen());


  MyApp get app {
    return _createApp();
  }
}
