import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mobile/models/product_model.dart';
import 'package:mobile/providers/product_provider.dart';
import 'package:mobile/providers/wishlist_provider.dart';
import 'package:mobile/theme.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;
  ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    
  ProductProvider productProvider = Provider.of<ProductProvider>(context); //familiar image from same category
  WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

  Widget indicator(int index){
    return Container(
      width: currentIndex == index ? 16 : 4,
      height: 4,
      margin: EdgeInsets.symmetric(
        horizontal: 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: currentIndex == index ? primaryColor : Color(0xffC4C4C4),
      ),
    );
  }

  Widget header(){
    int index = -1;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            left: defaultMargin,
            right: defaultMargin
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.chevron_left)),
              IconButton(onPressed: (){}, icon: Icon(Icons.shopping_bag,color: backgroundColor1,))
            ],
          ),
        ),
        CarouselSlider(
          items: widget.product.galleries.map((image) => CachedNetworkImage(
          cacheManager: CacheManager(
            Config(
              image.url,
              stalePeriod: const Duration(days: 7)
            )
          ),
            imageUrl: image.url,
            width: MediaQuery.of(context).size.width,
            height: 310,
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )).toList(),
          options: CarouselOptions(
            initialPage: 0,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.product.galleries.map((e) {
              index++;
              return indicator(index);
            }).toList(),
          ),
      ],
    );
  }

  Widget familiarShoesCard(String imageUrl){
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: 54,
      height: 54,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
      imageBuilder: (context, imageProvider) => Container(
        width: 54,
        height: 54,
        margin: EdgeInsets.only(
          right: 16,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget content(){

    int index = -1;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        color: backgroundColor1,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: defaultMargin,
              left: defaultMargin,
              right: defaultMargin
            ),
            child: Row(
              children: [
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.product.name, style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),),
                    Text(widget.product.category != null ? widget.product.category!.name : 'none', style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                    ),),
                  ],
                )),
                GestureDetector(
                  onTap: (){

                    wishlistProvider.setProduct(widget.product);

                    if(wishlistProvider.isWishlist(widget.product)){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: secondaryColor,
                          content: Text('Has been added to the wishlist', textAlign: TextAlign.center,),
                        ),
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: alertColor,
                          content: Text('Has been removed to the wishlist', textAlign: TextAlign.center,),
                        ),
                      );
                    }
                  },
                  child: Image.asset(
                    wishlistProvider.isWishlist(widget.product)
                    ? 'assets/button_wishlist_blue.png'
                    : 'assets/button_wishlist.png', width: 46,)),
              ],
            ),
          ),
          // NOTE: PRICE
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: 20,
              left: defaultMargin,
              right: defaultMargin,
            ),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor2,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Price starts from', style: primaryTextStyle,),
                Text('\$${widget.product.price}', style: priceTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),)
              ],
            ),
          ),

          // NOTE: DESCRIPTION
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: defaultMargin,
              left: defaultMargin,
              right: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Description', style: primaryTextStyle.copyWith(
                  fontWeight: medium,
                ),),
                SizedBox(
                  height: 12,
                ),
                Text(
                  widget.product.description,
                  style: subtitleTextStyle.copyWith(
                    fontWeight: light,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),

          // NOTE: FAMILIAR SHOES
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: defaultMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                ),
                child: Text('Familiar Shoes', style: primaryTextStyle.copyWith(
                  fontWeight: medium,
                ),),
                ),
                SizedBox(
                  height: 12,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: productProvider.products.map((item) {
                      index++;
                      return GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => ProductPage(product: item)));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3, // Menambahkan lebar
                          margin: EdgeInsets.only(
                            left: index == 0 ? defaultMargin : 0,
                          ),
                          child: familiarShoesCard(item.galleries[0].url),
                        ),
                      );
                    }, ).toList(),
                  ),
                ),
              ],
            ),
          ),

          // NOTE: BUTTONS
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(defaultMargin),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/button_chat.png'),),
                  ),
                ),
                SizedBox(width: 16,),
                Expanded(
                  child: Container(
                    height: 54,
                    child: TextButton(onPressed: (){},
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: primaryColor
                    ),
                    child: Text('Add to Cart', style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

    return Scaffold(
      backgroundColor: backgroundColor6,
      body: ListView(
        children: [
          header(),
          content(),
        ],
      ),
    );
  }
}