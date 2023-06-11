import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/product_model.dart';
import 'package:mobile/providers/wishlist_provider.dart';
import 'package:mobile/theme.dart';
import 'package:provider/provider.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class WishlistCard extends StatelessWidget {
  WishlistCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      padding: EdgeInsets.only(
        top: 10,
        left: 20,
        bottom: 14,
        right: 20
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor4
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: product.galleries[0].url,
              cacheManager: CacheManager(
                Config(
                  product.galleries[0].url,
                  stalePeriod: const Duration(days: 7)
                )
              ),
              width: 60,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: primaryTextStyle.copyWith(
                  fontWeight: semiBold,
                ),),
                Text("\$${product.price}", style: priceTextStyle,),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              wishlistProvider.setProduct(product);
            },
            child: Image.asset('assets/button_wishlist_blue.png', width: 34,)),
        ],
      ),
    );
  }
}