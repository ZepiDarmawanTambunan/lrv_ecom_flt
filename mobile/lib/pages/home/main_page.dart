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
        onPressed: (){},
        child: Image.asset('assets/icon_cart.png', width: 20,),
      );
    }

    Widget customBottomNav(){
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30),),
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            onTap: (value){
              setState(() {
                currentIndex = value;
              });
            },
            backgroundColor: backgroundColor4,
            type: BottomNavigationBarType.fixed, //agar background color active
            items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: Image.asset('assets/icon_home.png', width: 21,
                color: currentIndex == 0 ? primaryColor : Color(0xff808191),
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
          break;
        case 1:
          return ChatPage();  
          break;
        case 2:
          return WishlistPage();  
          break;
        case 3:
          return ProfilePage();  
          break;
        default:
          return HomePage();
      }
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}