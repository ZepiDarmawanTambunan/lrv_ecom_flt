import 'package:flutter/material.dart';
import 'package:mobile/providers/cart_provider.dart';
import 'package:mobile/theme.dart';
import 'package:mobile/widgets/cart_card.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
  CartProvider cartProvider = Provider.of<CartProvider>(context);
    
    AppBar header(){
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text('Your Cart'),
        elevation: 0,
      );
    }

    Widget emptyCart(){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon_empty_cart.png', width: 80,),
            SizedBox(
              height: 12,
            ),
            Text("Let's find your favorite shoes", style: secondaryTextStyle,),
            Container(
              width: 154,
              height: 55,
              margin: EdgeInsets.only(top: 20),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                }, child: Text('Explore Store', style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),),),
            ),
          ],
        ),
      );
    }

    Widget content(){
      return ListView(
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin
        ),
        children: cartProvider.carts.map((cart) => CartCard(cart: cart)).toList(),
      );
    }

    Widget customBottomNav(){
      return Container(
        height: 180,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal', style: primaryTextStyle,),
                  Text('\$${cartProvider.totalPrice()}', style: priceTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              thickness: 0.5,
              color: subtitleColor,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: (){
                  Navigator.pushNamed(context, '/checkout');
                }, child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text('Continue to Checkout', style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),),
                Icon(Icons.arrow_forward, color: primaryTextColor,),
              ],),),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: cartProvider.carts.length == 0 ? emptyCart() : content(),
      bottomNavigationBar: cartProvider.carts.length == 0 ? SizedBox() : customBottomNav(),
    );
  }
}