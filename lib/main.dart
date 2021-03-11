import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:megashopadmin/config/palette.dart';
import 'package:megashopadmin/modals/user.dart';
import 'package:megashopadmin/screens/add/add_customer.dart';
import 'package:megashopadmin/screens/add/add_notes.dart';
import 'package:megashopadmin/screens/customers.dart';
import 'package:megashopadmin/screens/products.dart';
import 'package:megashopadmin/screens/wrapper.dart';
import 'package:megashopadmin/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        StreamProvider<UserData>.value(
          value: AuthServices().user,
          initialData: null,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Management',
      theme: ThemeData(
        primaryColor: Palette.appColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 2,
            textTheme: TextTheme(
              title: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            )),
        scaffoldBackgroundColor: Colors.grey[300],
      ),
      home: SplashScreen(
        seconds: 2,
        navigateAfterSeconds: new Wrapper(),
        image: new Image.network(
            'https://cdn.dribbble.com/users/6869698/screenshots/15243979/media/cd13469fe8529797602f8f2bbae295e4.jpg?compress=1&resize=800x600'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 150.0,
        loaderColor: Colors.white,
      ),
      routes: {
        ProductsPage.id: (_) => ProductsPage(),
        CustomersPage.id: (_) => CustomersPage(),
        AddCustomer.id: (_) => AddCustomer(),
        AddNotes.id: (_) => AddNotes(),
      },
    );
  }
}
