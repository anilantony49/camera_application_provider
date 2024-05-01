import 'package:camera_application1/models/models.dart';
import 'package:camera_application1/screen/details_screen.dart';
import 'package:camera_application1/screen/my_home_page.dart';
import 'package:camera_application1/widgets/my_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx)=>ImageFile(),
      child: MaterialApp(
        title: 'Flutter gallary',
        theme: ThemeData.dark(),
        home: const MyHomePage(),
        routes: {
          MyInputScreen.routName:(ctx)=>MyInputScreen(),
          DetailsScreen.routeName:(ctx)=>DetailsScreen()
        },
      ),
    );
  }
}

