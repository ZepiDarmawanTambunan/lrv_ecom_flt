import 'package:flutter/material.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/theme.dart';
import 'package:mobile/widgets/loading_button.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    // textform add validator 
    // bool validateAndSave() {
    //   final form = _formKey.currentState;
    //   if (form!.validate()) {
    //     form.save();
    //     return true;
    //   }
    //   return false;
    // }

    handleSignUp() async{
      // if(validateAndSave()){
      //   print(true);
      // }

      setState(() {
        isLoading = true;
      });

      if(await authProvider.register(name: nameController.text, 
          username: usernameController.text, 
          email: emailController.text, 
          password: passwordController.text)){
            nameController.text = '';
            usernameController.text = '';
            emailController.text = '';
            passwordController.text = '';
          Navigator.pushReplacementNamed(context, '/home');
      }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: alertColor,
            content: Text('Gagal Terjadi kesalahan', textAlign: TextAlign.center,),),
            );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget header(){
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Sign Up', style: primaryTextStyle.copyWith(fontSize: 24,fontWeight: semiBold,),),
            SizedBox(height: 2,),
            Text('Register and Happy Shoping', style: subtitleTextStyle,),
          ],
        ),
      );
    }

    Widget nameInput(){
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Full Name", style: primaryTextStyle.copyWith(
              fontSize: 16, fontWeight: medium,
            ),),
            SizedBox(height: 12,),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16,),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset('assets/icon_name.png',width: 17,),
                    SizedBox(width: 16,),
                    Expanded(child: TextFormField(
                      controller: nameController,
                      style: primaryTextStyle,//input collapsed = input tanpa border/kosongan
                      decoration: InputDecoration.collapsed(hintText: "Your Full Name", hintStyle: subtitleTextStyle),
                    ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget usernameInput(){
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Username", style: primaryTextStyle.copyWith(
              fontSize: 16, fontWeight: medium,
            ),),
            SizedBox(height: 12,),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16,),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset('assets/icon_username.png',width: 17,),
                    SizedBox(width: 16,),
                    Expanded(child: TextFormField(
                      controller: usernameController,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(hintText: "Your Username", hintStyle: subtitleTextStyle),
                    ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget emailInput(){
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email Address", style: primaryTextStyle.copyWith(
              fontSize: 16, fontWeight: medium,
            ),),
            SizedBox(height: 12,),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16,),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset('assets/icon_email.png',width: 17,),
                    SizedBox(width: 16,),
                    Expanded(child: TextFormField(
                      controller: emailController,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(hintText: "Your Email Address", hintStyle: subtitleTextStyle),
                    ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget passwordInput(){
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Password", style: primaryTextStyle.copyWith(
              fontSize: 16, fontWeight: medium,
            ),),
            SizedBox(height: 12,),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 16,),
              decoration: BoxDecoration(
                color: backgroundColor2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    Image.asset('assets/icon_password.png',width: 17,),
                    SizedBox(width: 16,),
                    Expanded(child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(hintText: "Your Password", hintStyle: subtitleTextStyle),
                    ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget signUpButton(){
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(onPressed: handleSignUp, child: Text("Sign Up", style: primaryTextStyle.copyWith(
          fontSize: 16,
          fontWeight: medium,
        ),),
        style: TextButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        )),
        ),
      );
    }

    Widget footer(){
      return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1, ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already have an account? ',
            style: subtitleTextStyle.copyWith(
              fontSize: 12,
            ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Text("Sign In", style: purpleTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),),
            ),
          ],
        ),
      );
    }

    return Scaffold( 
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                header(),
                nameInput(),
                usernameInput(),
                emailInput(),
                passwordInput(),
                isLoading ? LoadingButton() : signUpButton(),
                footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}