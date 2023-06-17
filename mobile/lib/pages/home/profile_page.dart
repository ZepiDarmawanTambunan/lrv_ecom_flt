import 'package:flutter/material.dart';
import 'package:mobile/models/user_model.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/providers/page_provider.dart';
import 'package:mobile/theme.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Widget header(BuildContext context){

    
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    UserModel user = authProvider.user;

    handleLogout() async{
      if(await authProvider.logout()){
          pageProvider.currentIndex = 0;
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: primaryColor,
            content: Text('Berhasil Logout', textAlign: TextAlign.center,),),
            );
      }
    }

    return AppBar(
      backgroundColor: backgroundColor1,
      automaticallyImplyLeading: false,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Container(
          padding: EdgeInsets.all(defaultMargin),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: 'https://static.vecteezy.com/system/resources/previews/000/574/512/original/vector-sign-of-user-icon.jpg',
                cacheManager: CacheManager(
                  Config(
                    'https://static.vecteezy.com/system/resources/previews/000/574/512/original/vector-sign-of-user-icon.jpg',
                    stalePeriod: const Duration(days: 7)
                  )
                ),
                imageBuilder: (context, imageProvider) => Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(width: 16,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hallo, ${user.name}", style: primaryTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),),
                  Text('@${user.username}', style: subtitleTextStyle.copyWith(
                    fontSize: 16,
                  ),),
                ],
              ),),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/sign-in', (route) => false);
                },
                child: GestureDetector(
                  onTap: handleLogout,
                  child: Image.asset('assets/button_exit.png', width: 20,),
                  )
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget menuItem(String text){
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: secondaryTextStyle.copyWith(fontSize: 13),),
          Icon(
            Icons.chevron_right,
            color: primaryTextColor,
          ),
        ],
      ),
    );
  }

  Widget content(BuildContext context){
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        decoration: BoxDecoration(
          color: backgroundColor3
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("Account", style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/edit-profile');
              },
              child: menuItem('Edit Profile')),
            menuItem('Your Orders'),
            menuItem('Help'),
            SizedBox(height: 30,),
            Text("General", style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),),
            menuItem('Privacy & Policy'),
            menuItem('Term of Service'),
            menuItem('Rate App'),
          ],
        ),
      ), 
      );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header(context),
        content(context),
      ],
    );
  }
}