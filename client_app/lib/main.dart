
import 'dart:async';
import 'package:client_app/di/components/app.component.dart';
import 'package:client_app/module_products/product_module.dart';
import 'package:client_app/module_splash/splash_module.dart';
import 'package:client_app/module_splash/splash_routes.dart';
import 'package:flutter/material.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  /// di
  final container = await AppComponent.create();

/// Your App Is Here ...
  runApp( container.app,);
}



class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  final SplashModule _splashModule;
  final ProductsModule _productsModule;
  MyApp(this._splashModule,this._productsModule);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
Timer? _timer;
  @override
  void initState() {


    super.initState();
  }

@override
void deactivate() {

  super.deactivate();
}
  @override
  Widget build(BuildContext context) {
    Map<String, WidgetBuilder> routes = {};
    routes.addAll(widget._splashModule.getRoutes());
    routes.addAll(widget._productsModule.getRoutes());
    return FutureBuilder<Widget>(
      initialData: Container(color: Colors.green),
      future: configuratedApp(routes),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        return snapshot.data!;
      },
    );
  }

  Future<Widget> configuratedApp(Map<String, WidgetBuilder> routes,) async {

    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Test',
        routes: routes,
        initialRoute: SplashRoutes.SPLASH_SCREEN,
      );
  }
  @override
  void dispose() {
    super.dispose();
  }
}


