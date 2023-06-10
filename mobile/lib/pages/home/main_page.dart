import 'package:flutter/material.dart';
import 'package:mobile/pages/home/chat_page.dart';
import 'package:mobile/pages/home/home_page.dart';
import 'package:mobile/pages/home/profile_page.dart';
import 'package:mobile/pages/home/wishlist_page.dart';
import 'package:mobile/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    Widget cartButton(){
      return FloatingActionButton(
        backgroundColor: secondaryColor,
        onPressed: (){
          Navigator.pushNamed(context, '/cart');
        },
        child: Image.asset('assets/icon_cart.png', width: 20,),
      );
    }

    Widget customBottomNav(){
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30),),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),  //effect dgn floating action btn
          notchMargin: 12,  //effect dgn floating action btn
          clipBehavior: Clip.antiAlias, //effect dgn floating action btn
          child: BottomNavigationBar(
            onTap: (value){
              setState(() {
                currentIndex = value;
              });
            },
            backgroundColor: backgroundColor4,
            type: BottomNavigationBarType.fixed, //agar background color bisa dipakai
            items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: Image.asset('assets/icon_home.png', width: 21,
                color: currentIndex == 0 ? primaryColor : Color(0xff808191), // warna item yg active
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: Image.asset('assets/icon_chat.png', width: 20,
                color: currentIndex == 1 ? primaryColor : Color(0xff808191),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(                
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: Image.asset('assets/icon_wishlist.png', width: 20,
                color: currentIndex == 2 ? primaryColor : Color(0xff808191),
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(                
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: Image.asset('assets/icon_profile.png', width: 18,
                color: currentIndex == 3 ? primaryColor : Color(0xff808191),
                ),
              ),
              label: '',
            ),
          ],),
        ),
      );
    }

    Widget body(){
      switch (currentIndex) {
        case 0:
          return HomePage();
        case 1:
          return ChatPage();  
        case 2:
          return WishlistPage();  
        case 3:
          return ProfilePage();  
        default:
          return HomePage();
      }
    }

    return Scaffold(
      backgroundColor: currentIndex == 0 ? backgroundColor1 : backgroundColor3,
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}