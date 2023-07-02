import 'package:flutter/material.dart';
import 'package:mobile/pages/add_product_page.dart';
import 'package:mobile/pages/cart_page.dart';
import 'package:mobile/pages/checkout_page.dart';
import 'package:mobile/pages/checkout_success_page.dart';
import 'package:mobile/pages/edit_profile_page.dart';
import 'package:mobile/pages/home/main_page.dart';
import 'package:mobile/pages/sign_in_page.dart';
import 'package:mobile/pages/sign_up_page.dart';
import 'package:mobile/pages/splash_page.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/providers/cart_provider.dart';
import 'package:mobile/providers/category_provider.dart';
import 'package:mobile/providers/image_product_provider.dart';
import 'package:mobile/providers/page_provider.dart';
import 'package:mobile/providers/product_provider.dart';
import 'package:mobile/providers/transaction_provider.dart';
import 'package:mobile/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main ()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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
        ChangeNotifierProvider(
          create: (context) => TransactionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),        
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImageProductProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => SplashPage(),
          "/sign-in": (context) => SignInPage(),
          "/sign-up": (context) => SignUpPage(),
          "/home": (context) => MainPage(),
          '/edit-profile': (context) => EditProfilePage(),
          '/add-product': (context) => AddProductPage(),
          '/cart': (context) => CartPage(),
          '/checkout': (context) => CheckoutPage(),
          '/checkout-success': (context) => CheckoutSuccessPage(),
        }
      ),
    );
  }
}
