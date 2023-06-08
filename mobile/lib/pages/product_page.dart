import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile/theme.dart';

class ProductPage extends StatefulWidget {
  ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List images = ['assets/image_shoes.png', 'assets/image_shoes.png','assets/image_shoes.png'];
  final List familiarShoes = [
    'assets/image_shoes.png', 
    'assets/image_shoes.png',
    'assets/image_shoes.png',
    'assets/image_shoes.png', 
    'assets/image_shoes.png',
    'assets/image_shoes.png',
    'assets/image_shoes.png', 
    'assets/image_shoes.png',
    'assets/image_shoes.png',
    ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

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
          items: images.map((image) => Image.asset(image, 
            width: MediaQuery.of(context).size.width,
            height: 310,
            fit: BoxFit.cover,
            )).toList(), 
          options: CarouselOptions(
            initialPage: 0,
            onPageChanged: (index, reason){
              setState(() {
                currentIndex = index;
              });
            }
          ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.map((e) {
              index++;
              return indicator(index);
            }).toList(),
          ),
      ],
    );
  }

  Widget familiarShoesCard(String imageUrl){
    return Container(
      width: 54,
      height: 54,
      margin: EdgeInsets.only(
        right: 16,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imageUrl)),
        borderRadius: BorderRadius.circular(6),
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
                    Text('TERREX URBAN LOW', style: primaryTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),),
                    Text('Hiking', style: secondaryTextStyle.copyWith(
                      fontSize: 12,
                    ),),
                  ],
                )),
                Image.asset('assets/button_wishlist.png', width: 46,),
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
                Text('\$143,98', style: priceTextStyle.copyWith(
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
                  'Generate Lorem Ipsum placeholder text. Select the number of characters, words, sentences or paragraphs, and hit generate',
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
                    children: familiarShoes.map((image) {
                      index++;
                      return Container(
                        margin: EdgeInsets.only(
                          left: index == 0 ? defaultMargin : 0,
                        ),
                        child: familiarShoesCard(image),
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