import 'dart:async';
import 'dart:js';
import 'package:fiebooth_portail/controllers/fiebooth_controller.dart';
import 'package:fiebooth_portail/theme/main_theme.dart';
import 'package:fiebooth_portail/views/photo_view.dart';
import 'package:fiebooth_portail/views/signin_view.dart';
import 'package:fiebooth_portail/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*SystemChrome.setPreferredOrientations([DeviceOrzerfdeientation.landscapeRight])  b 
      .then((_) {
    */
  runApp(const MyApp()); /*
  });*/
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
    //UserConnection _userConnection = UserConnection();
    FieboothController _fieboothController = FieboothController();
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return StreamBuilder(
            stream: _fieboothController.getUserConnected(),
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
      /*return MaterialPageRoute(
            builder: (context) => StreamBuilder(
                  stream: _userConnection.userStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        //if a user is connected show the client page
                        return Container();
                        
                      } else {
                        //if not showing sign in page
                        return SigninView();
                      }
                    }

                    return Container();
                  },
                ));*/
      /*case '/signup_code':
        return MaterialPageRoute(
            builder: (context) => SignupCodePage(
                  user: settings.arguments as UserProfileModel,
                ));*/

      /* case '/newPost/confirmation':
        return MaterialPageRoute(
            builder: (context) => const NewPostConfirmationPage());
      case '/post':
        return MaterialPageRoute(
            builder: (context) =>
                PostPage(post: settings.arguments as PostModel));
      case '/channel':
        return MaterialPageRoute(
            builder: (context) =>
                ChannelPage(channel: settings.arguments as ChannelModel));
      case '/signup':
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case '/loading':
        if (settings.arguments != null) {
          Map<String, dynamic>? args =
              settings.arguments as Map<String, dynamic>;
          String? text = args.containsKey('text') ? args['text'] : null;
          Duration timeOffset = args.containsKey('timeOffset')
              ? args['timeOffset']
              : Duration.zero;
          Function()? callBack =
              args.containsKey('callBack') ? args['callBack'] : null;
          return MaterialPageRoute(
              builder: (context) => LoaderPage(
                    text: text,
                    timeOffset: timeOffset,
                    callBack: callBack,
                  ));
        } else {
          return MaterialPageRoute(
              builder: (context) => LoaderPage(
                    timeOffset: Duration(seconds: 1),
                  ));
        }
      */
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
