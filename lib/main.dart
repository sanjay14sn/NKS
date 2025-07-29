import 'package:flutter/material.dart';
import 'package:nks_traders/backend/provider/cart_provider.dart';
import 'package:nks_traders/backend/provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:nks_traders/backend/Gorouter.dart';
import 'package:sizer/sizer.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
           ChangeNotifierProvider(create: (_) => LocationProvider()),
           ChangeNotifierProvider(create: (_) => QuantityProvider()), 
            // Add more providers here
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          ),
        );
      },
    );
  }
}
