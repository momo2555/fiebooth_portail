import 'package:fiebooth_portail/components/photos_length_indicator.dart';
import 'package:fiebooth_portail/components/photos_menu.dart';
import 'package:fiebooth_portail/components/simple_text.dart';
import 'package:fiebooth_portail/controllers/fiebooth_controller.dart';
import 'package:fiebooth_portail/utils/dialog_utils.dart';
import 'package:fiebooth_portail/utils/global_utils.dart';
import 'package:fiebooth_portail/views/pages/action_page.dart';
import 'package:fiebooth_portail/views/pages/photos_page.dart';
import 'package:fiebooth_portail/views/pages/settings_page.dart';
import 'package:flutter/material.dart';

class PageInfo {
  final Widget page;
  final Widget leftIcon;
  final Widget? rightIcon;
  final Widget title;
  final Widget menu;
  final Color topBgColor;
  final Widget floatingButton;
  PageInfo(
      {required this.page,
      required this.leftIcon,
      required this.title,
      required this.menu,
      required this.floatingButton,
      required this.topBgColor,
      this.rightIcon});
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<PageInfo> _pages = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final FieboothController _fieboothController = FieboothController();
  //UserConnection _userConnection = UserConnection();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Globals.homeIndex.value = 0;
  }

  void _initPages(context) {
    Widget photos_lefticon = Container();
    if (FieboothController.loggedUser!.userIsAdmin ?? false) {
      photos_lefticon = IconButton(
        color: Theme.of(context).primaryColorLight,
        icon: const Icon(
          Icons.menu,
          size: 40,
        ),
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
      );
    }
    if (FieboothController.loggedUser!.userIsGuest ?? false) {
      photos_lefticon = IconButton(
        color: Theme.of(context).primaryColorLight,
        icon: const Icon(
          Icons.logout,
          size: 40,
        ),
        onPressed: () {
          showConfirmDialog(
              "Vous êtes sur le point de vous déconnecter", "Déconnexion", () {
            _fieboothController.userLogout();
            Navigator.pop(context);
          });
        },
      );
    }
    if (_pages.isEmpty) {
      _pages = [
        PageInfo(
          title: SimpleText.BigTitle("Photos"),
          topBgColor: Theme.of(context).primaryColor,
          leftIcon: photos_lefticon,
          page: PhotosPage(),
          menu: Container(),
          floatingButton: Container(),
          rightIcon: PhotosLengthIndicator(),
        ),
        PageInfo(
          title: SimpleText.BigTitle("Config"),
          topBgColor: Theme.of(context).colorScheme.primary,
          leftIcon: Container(),
          page: SettingsPage(),
          menu: Container(),
          floatingButton: Container(),
        ),
        PageInfo(
          title: SimpleText.BigTitle("Action"),
          topBgColor: Theme.of(context).colorScheme.primary,
          leftIcon: Container(),
          page: ActionPage(),
          menu: Container(),
          floatingButton: Container(),
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Globals.homeIndex,
      builder: (context, value, widget) {
        
        _initPages(context);
        PageInfo page = _pages[value];
        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              toolbarHeight: 80,
              title: page.title,
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: page.topBgColor,
              elevation: 0,
              leadingWidth: 40,
              leading: page.leftIcon,
              actions: [
                page.rightIcon ?? Container(),
              ],
            ),
            bottomNavigationBar: !(FieboothController.loggedUser!.userIsGuest ??
                    false)
                ? BottomNavigationBar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    elevation: 0,
                    //fixedColor: Theme.of(context).backgroundColor,
                    selectedItemColor:
                        Theme.of(context).colorScheme.onSecondary,
                    unselectedItemColor: Theme.of(context).primaryColorLight,
                    currentIndex: Globals.homeIndex.value,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    //selectedFontSize: 15,
                    //unselectedFontSize: 15,

                    iconSize: 28,
                    selectedLabelStyle:
                        TextStyle(fontFamily: "Smoothie Shoppe", fontSize: 18),
                    unselectedLabelStyle:
                        TextStyle(fontFamily: "Smoothie Shoppe", fontSize: 18),
                    items: [
                      BottomNavigationBarItem(
                        icon: Globals.homeIndex.value == 0
                            ? const Icon(Icons.photo_rounded)
                            : const Icon(Icons.photo_rounded),
                        label: "Photos",
                        backgroundColor: Theme.of(context).primaryColorLight,
                      ),
                      BottomNavigationBarItem(
                        icon: Globals.homeIndex.value == 1
                            ? const Icon(Icons.settings_rounded)
                            : const Icon(Icons.settings_rounded),
                        label: "Config",
                        backgroundColor: Theme.of(context).primaryColorLight,
                      ),
                      BottomNavigationBarItem(
                        icon: Globals.homeIndex.value == 2
                            ? const Icon(Icons.shield_rounded)
                            : const Icon(Icons.shield_rounded), //GeIcons.personBlack,
                        label: "Action",
                        backgroundColor: Theme.of(context).primaryColorLight,
                      ),
                    ],
                    onTap: (int index) {
                      Globals.homeIndex.value = index;
                    },
                  )
                : null,
            floatingActionButton: SizedBox(
              height: 60,
              child: page.floatingButton,
            ),
            drawer: const Drawer(
              child: PhotosMenu(),
            ),
            body: page.page,
          ),
        );
      },
    );
  }
}
