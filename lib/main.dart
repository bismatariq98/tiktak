import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tik_tak/providers/authProvider/authProvider.dart';
import 'package:tik_tak/providers/currentUSer/currentUserProvider.dart';
import 'package:tik_tak/providers/homeProviders/videosProvider.dart';
import 'package:tik_tak/providers/likeProvider/likeProvider.dart';
import 'package:tik_tak/screens/home_page_widget.dart';
import 'package:tik_tak/screens/login_page_widget.dart';
import 'package:tik_tak/screens/massage_page_widget.dart';
import 'package:tik_tak/screens/search_page_widget.dart';
import 'package:tik_tak/screens/upload_status_page_widget.dart';
import 'package:tik_tak/screens/user_profile_widget.dart';
import 'package:tik_tak/theme/tik_tak_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool displaySplashImage = true;
  @override
  //void state
  void initState() {
    super.initState();
    Future.delayed(
        Duration(seconds: 2), () => setState(() => displaySplashImage = false));
  }

  @override
  Widget build(context) {
    // return ChangeNotifierProvider<VideosProvider>(
    //   create: (_)=>VideosProvider(),
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VideosProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => currentUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LikeProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TikTak',
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', '')],
        theme: ThemeData(primarySwatch: Colors.blue),
        home: displaySplashImage
            ? Container(
                color: Colors.transparent,
                child: Builder(
                  builder: (context) => Image.asset(
                    'assets/images/Splash_Screen.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : LoginPageWidget(),
      ),
    );
  }
}

//this is class,forexoample ya change kia  h ap ny code mai to
//esko push krna h.
class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage, this.userID}) : super(key: key);

  final String initialPage;
  String userID;
//string
  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'HomePage';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': HomePageWidget(),
      'MassagePage': MassagePageWidget(),
      'UploadStatusPage': UploadStatusPageWidget(),
      'SearchPage': SearchPageWidget(),
      'UserProfile': UserProfileWidget(),
    };
    return Scaffold(
      body: tabs[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              size: 24,
            ),
            label: 'Home',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mark_chat_unread_rounded,
              size: 24,
            ),
            label: 'Inbox',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline_rounded,
              size: 50,
            ),
            activeIcon: Icon(
              Icons.add_circle_rounded,
              size: 50,
            ),
            label: '',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.filter_list_alt,
              size: 26,
            ),
            label: 'Search',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_rounded,
              size: 26,
            ),
            label: 'Profile',
            tooltip: '',
          )
        ],
        backgroundColor: TikTakTheme.tertiaryColor,
        currentIndex: tabs.keys.toList().indexOf(_currentPage),
        selectedItemColor: TikTakTheme.primaryColor,
        unselectedItemColor: Color(0x53FFFFFF),
        onTap: (i) => setState(() => _currentPage = tabs.keys.toList()[i]),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
