import 'package:flutter/material.dart';
import 'package:mobile/pages/cart_page.dart';
import 'package:mobile/pages/checkout_page.dart';
import 'package:mobile/pages/checkout_success_page.dart';
import 'package:mobile/pages/detail_chat_page.dart';
import 'package:mobile/pages/edit_profile_page.dart';
import 'package:mobile/pages/home/main_page.dart';
import 'package:mobile/pages/sign_in_page.dart';
import 'package:mobile/pages/sign_up_page.dart';
import 'package:mobile/pages/splash_page.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/providers/cart_provider.dart';
import 'package:mobile/providers/product_provider.dart';
import 'package:mobile/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

void main () => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => SplashPage(),
          "/sign-in": (context) => SignInPage(),
          "/sign-up": (context) => SignUpPage(),
          "/home": (context) => MainPage(),
          '/detail-chat': (context) => DetailChatPage(),
          '/edit-profile': (context) => EditProfilePage(),
          '/cart': (context) => CartPage(),
          '/checkout': (context) => CheckoutPage(),
          '/checkout-success': (context) => CheckoutSuccessPage(),
        }
      ),
    );
  }
}
