import 'package:flutter/material.dart';
import 'package:mobile/theme.dart';
import 'package:mobile/widgets/checkout_card.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  AppBar header(){
    return AppBar(
      backgroundColor: backgroundColor1,
      elevation: 0,
      centerTitle: true,
      title: Text('Checkout Details'),
    );
  }

  Widget content(BuildContext context){
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin
      ),
      children: [
        // NOTE LIST ITEMS
        Text('List Items', style: primaryTextStyle.copyWith(  
          fontSize: 16,
          fontWeight: medium,
        ),),
        CheckoutCard(),
        CheckoutCard(),

        // NOTE ADDRESS DETAIL
        Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor4,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Address Details', style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Image.asset('assets/icon_store_location.png', width: 40,),
                      Image.asset('assets/icon_line.png', height: 30,),
                      Image.asset('assets/icon_your_address.png', width: 40,),
                    ],
                  ),
                  SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Store Location', style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),),
                      Text('Adidas Core', style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),),
                      SizedBox(height: defaultMargin,),
                      Text('Your Address', style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),),
                      Text('Marsemoon', style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        // NOTE PAYMENT SUMMARY
        Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor4,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Payment Summary', style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: medium,
              ),),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Product Price', style: secondaryTextStyle.copyWith(
                    fontSize: 12,
                  ),),
                  Text('\$543.22', style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                  ),),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shipping', style: secondaryTextStyle.copyWith(
                    fontSize: 12,
                  ),),
                  Text('Free', style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                  ),),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Divider(
                thickness: 0.5,
                color: Color(0xff2E3141),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: priceTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),),
                  Text('\$543.22', style: priceTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),),
                ],
              ),
            ],
          ),
        ),

        // NOTE CHECKOUT BUTTON
        SizedBox(
          height: defaultMargin,
        ),
        Divider(
          thickness: 1,
          color: Color(0xff2E3141),
        ),
        Container(
          height: 50,
          width: double.infinity,
          margin: EdgeInsets.symmetric(
            vertical: defaultMargin,
          ),
          child: TextButton(
            onPressed: (){
              Navigator.pushNamedAndRemoveUntil(context, '/checkout-success', (route) => false);
            }, 
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          child: Text('Checkout Now', style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(context),
    );
  }
}