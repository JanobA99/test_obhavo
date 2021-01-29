import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_obhavo/Styles.dart';
import 'package:test_obhavo/theme/theme.dart';
import 'package:test_obhavo/utils/screenController.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var darkModeOn = prefs.getBool('darkMode') ?? false;
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(
            darkModeOn ? Styles.themeData(true) : Styles.themeData(false),
            darkModeOn),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeNotifier.getTheme(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
bool themeDark=false;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    bool send = (themeNotifier.getTheme() ==
        Styles.themeData(
          true,
        ));
    void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
      (value)
          ? themeNotifier.setTheme(
          Styles.themeData(
            true,
          ),
          true)
          : themeNotifier.setTheme(
          Styles.themeData(
            false,
          ),
          false);
      var prefs = await SharedPreferences.getInstance();
      prefs.setBool('darkMode', value);
    }
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: OrientationBuilder(
        builder: (context, orientation){
          if(orientation == Orientation.portrait){
            return buildStackPortrait(context, send);
          }else{
            return buildStack(context, send);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {
          onThemeChanged(themeDark, themeNotifier);
          themeDark=!themeDark;
        },
        child: Icon(Icons.settings_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

Stack buildStack(BuildContext context, bool send) {
  return Stack(
    children: [
      Container(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Image.asset(
          send ?   "assets/background.png" : "assets/background_light.png",
          fit: BoxFit.contain,
          color: Color(0xfffafafa),
        ),
      ),
      Container(
        height: screenHeight(context),
        width: screenWidth(context),
        padding: EdgeInsets.symmetric(vertical: screenHeight(context)/32),
        color: Theme.of(context).shadowColor,
        child: Column(
          children: <Widget>[
            Container(
              height: screenHeight(context) * 3 / 4-screenHeight(context)/32,
              width: screenWidth(context),
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context) / 12),
              child: Stack(
                children: [
                  Container(
                    width: screenWidth(context),
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight(context) * 1 / 9),
                    margin: EdgeInsets.only(top: screenHeight(context) * 1 / 9, bottom:  screenHeight(context) * 1 / 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        border:
                        Border.all(color: Color(0xff0065d7), width: 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "21 : 15",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: screenHeight(context) * 1 / 4,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "12 май",
                              style: TextStyle(
                                  color: Theme.of(context).textSelectionColor,
                                  fontSize: screenHeight(context) * 1 / 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: screenHeight(context)/18,
                            ),
                            Text(
                              "Сешанба",
                              style: TextStyle(
                                  color: Theme.of(context).textSelectionColor,
                                  fontSize: screenHeight(context) * 1 / 15,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: screenHeight(context) * 2 / 9,
                        width: screenHeight(context) * 1.5 / 9,
                        child: Image.asset(
                          "assets/gerb.png",
                          height: screenHeight(context) * 2 / 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: screenHeight(context) * 1 / 4-screenHeight(context)/32,
              width: screenWidth(context),
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth(context) / 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/overcast.png",
                    height: screenHeight(context) * 1 / 6,
                  ),
                  Text(
                    "+27\u00B0",
                    style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontSize: screenHeight(context) * 1 / 6,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "Тошкент",
                    style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontSize: screenHeight(context) * 1 / 15,
                        fontWeight: FontWeight.w300),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ],
  );
}

  Stack buildStackPortrait(BuildContext context, bool send) {
    return Stack(
      children: [
        Container(
          height: screenHeight(context),
          width: screenWidth(context),
          child: Image.asset(
          send ?   "assets/background.png" : "assets/background_light.png",
            fit: BoxFit.cover,
            color: Color(0xfffafafa),
          ),
        ),
        Container(
          height: screenHeight(context),
          width: screenWidth(context),
          padding: EdgeInsets.symmetric(vertical: screenHeight(context)/32),
          color: Theme.of(context).shadowColor,
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight(context) * 3 / 4-screenHeight(context)/32,
                width: screenWidth(context),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth(context) / 12),
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth(context),
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight(context) * 1 / 9),
                      margin: EdgeInsets.only(top: screenHeight(context) * 1 / 9, bottom:  screenHeight(context) * 1 / 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          border:
                              Border.all(color: Color(0xff0065d7), width: 2)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "11 : 27",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: screenHeight(context) * 1 / 9,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "12 май",
                            style: TextStyle(
                                color: Theme.of(context).textSelectionColor,
                                fontSize: screenHeight(context) * 1 / 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Сешанба",
                            style: TextStyle(
                                color: Theme.of(context).textSelectionColor,
                                fontSize: screenHeight(context) * 1 / 15,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: screenHeight(context) * 2 / 9,
                          width: screenHeight(context) * 1.5 / 9,
                          child: Image.asset(
                            "assets/gerb.png",
                            height: screenHeight(context) * 2 / 9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight(context) * 1 / 4-screenHeight(context)/32,
                width: screenWidth(context),
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth(context) / 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: screenHeight(context) * 1 / 4,
                      width:
                          screenWidth(context) / 2 - screenWidth(context) / 6,
                      child: Image.asset(
                        "assets/overcast.png",
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "+27\u00B0",
                          style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontSize: screenHeight(context) * 1 / 9,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "Тошкент",
                          style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontSize: screenHeight(context) * 1 / 18,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
