import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/cart_model.dart';
import 'package:mobile/theme.dart';

class CheckoutCard extends StatelessWidget {
  CheckoutCard({super.key, required this.cart});
  final CartModel cart;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 12
      ),
      decoration: BoxDecoration(
        color: backgroundColor4,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(cart.product.galleries[0].url),
                  onError: (_, __) => Icon(Icons.error),
                ),
              ),
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cart.product.name, style: primaryTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
                overflow: TextOverflow.ellipsis,),
                SizedBox(height: 2,),
                Text('\$${cart.product.price}', style: priceTextStyle,),
              ],
            ),
          ),
          SizedBox(width: 12,), // handle text klo panjang diberi jarak
          Text('${cart.quantity} Items', style: secondaryTextStyle.copyWith(
            fontSize: 12,
          ),),
        ],
      ),
    );
  }
}