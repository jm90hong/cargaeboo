import 'package:cargaeboo/config/my_color.dart';
import 'package:cargaeboo/model/car_model.dart';
import 'package:cargaeboo/screen/root_screen.dart';
import 'package:cargaeboo/util/my_floor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'model/parts_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarModel()),
        ChangeNotifierProvider(create: (_) => PartsModel()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ko', 'KR'),
        ],
        title: '카계부',
        theme: ThemeData(
          fontFamily: 'nt',
          primarySwatch: MyColor.mainMaterialColor,
        ),
        home: RootScreen(),
      ),
    );
  }
}

