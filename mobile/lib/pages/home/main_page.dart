import 'package:flutter/material.dart';
import 'package:mobile/pages/home/chat_page.dart';
import 'package:mobile/pages/home/home_page.dart';
import 'package:mobile/pages/home/profile_page.dart';
import 'package:mobile/pages/home/wishlist_page.dart';
import 'package:mobile/providers/page_provider.dart';
import 'package:mobile/theme.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  @override
  Widget build(BuildContext context) {
  PageProvider pageProvider = Provider.of<PageProvider>(context);

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
              pageProvider.currentIndex = value;
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
                color: pageProvider.currentIndex == 0 ? primaryColor : Color(0xff808191), // warna item yg active
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
                color: pageProvider.currentIndex == 1 ? primaryColor : Color(0xff808191),
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
                color: pageProvider.currentIndex == 2 ? primaryColor : Color(0xff808191),
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
                color: pageProvider.currentIndex == 3 ? primaryColor : Color(0xff808191),
                ),
              ),
              label: '',
            ),
          ],),
        ),
      );
    }

    Widget body(){
      switch (pageProvider.currentIndex) {
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

    return WillPopScope(
      onWillPop: () async {
        // Mencegah penekanan tombol kembali dengan mengembalikan nilai false
        return false;
      },
      child: Scaffold(
        backgroundColor: pageProvider.currentIndex == 0 ? backgroundColor1 : backgroundColor3,
        floatingActionButton: cartButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: customBottomNav(),
        body: body(),
      ),
    );
  }
}