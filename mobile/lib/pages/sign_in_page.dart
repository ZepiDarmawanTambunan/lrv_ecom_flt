import 'package:flutter/material.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/theme.dart';
import 'package:mobile/widgets/loading_button.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> initializeAuthProvider() async {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    var hasToken = await authProvider.initializeAuthProvider();
    if (hasToken && authProvider.user != null) {
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  void initState() {
    super.initState();
    initializeAuthProvider();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSignIn() async{
    // if(validateAndSave()){
    //   print(true);
    // }

    setState(() {
      isLoading = true;
    });

    if(await authProvider.login(
        email: emailController.text, 
        password: passwordController.text)){
          emailController.text = '';
          passwordController.text = '';
        Navigator.pushNamed(context, '/home');
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
            Text('Login', style: primaryTextStyle.copyWith(fontSize: 24,fontWeight: semiBold,),),
            SizedBox(height: 2,),
            Text('Sign In to Continue', style: subtitleTextStyle,)
          ],
        ),
      );
    }

    Widget emailInput(){
      return Container(
        margin: EdgeInsets.only(top: 70),
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
                      style: primaryTextStyle,
                      controller: emailController,
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
                      obscureText: true,
                      controller: passwordController,
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

    Widget signInButton(){
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(onPressed: handleSignIn, 
        child: Text("Sign In", style: primaryTextStyle.copyWith(
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
        margin: EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Don\'t have an account? ',
            style: subtitleTextStyle.copyWith(
              fontSize: 12,
            ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/sign-up');
              },
              child: Text("Sign Up", style: purpleTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor1,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(),
                emailInput(),
                passwordInput(),
                isLoading ? LoadingButton() : signInButton(),
                Spacer(),
                footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}