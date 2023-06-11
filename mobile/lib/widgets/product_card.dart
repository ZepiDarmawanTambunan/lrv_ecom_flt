import 'package:flutter/material.dart';
import 'package:mobile/models/product_model.dart';
import 'package:mobile/pages/product_page.dart';
import 'package:mobile/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    print(product.galleries);
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(product: product)));
      },
      child: Container(
        width: 215,
        height: 278,
        margin: EdgeInsets.only(
          right: defaultMargin,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryTextColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            CachedNetworkImage(
              imageUrl: product.galleries[0].url,
              cacheManager: CacheManager(
                Config(
                  product.galleries[0].url,
                  stalePeriod: const Duration(days: 7)
                )
              ),
              width: 215,
              height: 150,
              fit: BoxFit.contain,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.category != null ? product.category!.name : 'none', style: secondaryTextStyle.copyWith(fontSize: 12),),
                  SizedBox(height: 6,),
                  Text(product.name, style: blackTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: semiBold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text('\$${product.price}', style: priceTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}