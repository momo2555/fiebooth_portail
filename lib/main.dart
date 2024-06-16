import 'package:fiebooth_portail/controllers/fiebooth_controller.dart';
import 'package:fiebooth_portail/theme/main_theme.dart';
import 'package:fiebooth_portail/views/download_all_view.dart';
import 'package:fiebooth_portail/views/logs_view.dart';
import 'package:fiebooth_portail/views/photo_view.dart';
import 'package:fiebooth_portail/views/signin_view.dart';
import 'package:fiebooth_portail/views/home_view.dart';
import 'package:flutter/material.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      title: 'Fiebooth Portail',
      theme: MainTheme.defaultTheme,
      navigatorKey: globalNavigatorKey,
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    FieboothController fieboothController = FieboothController();
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return StreamBuilder(
            stream: fieboothController.getUserConnected(),
            builder: (context, snapshot) {
              if(snapshot.data != null) {
                return const HomeView();
              }else{
                return const SigninView();
              }
              
            },
          );
        });
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeView());
      case '/photo':
        return MaterialPageRoute(
            builder: (context) => PhotoView(
                  photo: settings.arguments as String,
                ));
      case '/logs':
        return  MaterialPageRoute(
            builder: (context) => const LogsView()
        );
      case '/download_all':
        return MaterialPageRoute(
          builder: (context) {
            return DownloadAllView(user: settings.arguments as String);
          },
        );
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
