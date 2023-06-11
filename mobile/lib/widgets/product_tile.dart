import 'package:flutter/material.dart';
import 'package:mobile/models/product_model.dart';
import 'package:mobile/pages/product_page.dart';
import 'package:mobile/theme.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(product: product)));
      },
      child: Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          bottom: defaultMargin,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: product.galleries[0].url,
                cacheManager: CacheManager(
                  Config(
                    product.galleries[0].url,
                    stalePeriod: const Duration(days: 7)
                  )
                ),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.category != null ? product.category!.name : 'none category', style: secondaryTextStyle.copyWith(
                  fontSize: 12,
                ),),
                SizedBox(height: 6,),
                Text(product.name, style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                ),
                SizedBox(
                  height: 6,
                ),
                Text('\$${product.price}', style: priceTextStyle.copyWith(
                  fontWeight: medium
                ),),
              ],
            ))
          ],
        ),
      ),
    );
  }
}