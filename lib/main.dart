import 'package:blurhashimageplaceholder/provider/app_provider.dart';
import 'package:blurhashimageplaceholder/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance()
      .then((value) => runApp(MyApp(value.getStringList("blurHashs"))));
}

class MyApp extends StatelessWidget {
  final stringList;

  MyApp(this.stringList);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<AppProvider>(
        create: (context) => AppProvider(),
        child: HomeScreen(),
      ),
    );
  }
}
