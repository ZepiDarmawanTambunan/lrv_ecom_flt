import 'package:flutter/material.dart';
import 'package:mobile/providers/product_provider.dart';
import 'package:mobile/theme.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    getInit();
    super.initState();
  }

  getInit()async{
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    Navigator.pushReplacementNamed(context, '/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/image_splash.png'),),
          ),
        ),
      ),
    );
  }
}