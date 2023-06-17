import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/cart_model.dart';
import 'package:mobile/providers/cart_provider.dart';
import 'package:mobile/theme.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  CartCard({super.key, required this.cart});
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    
  CartProvider cartProvider = Provider.of<CartProvider>(context);

    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(image:CachedNetworkImageProvider(cart.product.galleries[0].url),),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cart.product.name, style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),),
                  Text('\$${cart.product.price}', style: priceTextStyle,),
                ],
              )),
              Column(
                children: [
                  GestureDetector(
                    onTap: (){cartProvider.addQuantity(cart.id);},
                    child: Image.asset('assets/button_add.png', width: 16,)),
                  SizedBox(height: 2,),
                  Text("${cart.quantity}", style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                  ),),
                  SizedBox(height: 2,),
                  GestureDetector(
                    onTap: (){cartProvider.reduceQuantity(cart.id);},
                    child: Image.asset('assets/button_min.png', width: 16,)),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: (){
              cartProvider.removeCart(cart.id);
            },
            child: Row(
              children: [
                Image.asset('assets/icon_remove.png', width: 10,),
                SizedBox(width: 4,),
                Text('Remove', style: alertTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: light,
                ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}