import 'package:flutter/material.dart';
import 'package:mobile/models/gallery_model.dart';
import 'package:mobile/models/message_model.dart';
import 'package:mobile/models/product_model.dart';
import 'package:mobile/pages/detail_chat_page.dart';
import 'package:mobile/theme.dart';

class ChatTile extends StatelessWidget {
  final MessageModel message;
  ChatTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailChatPage(product: UninitializedProductModel(id: 999, name: 'dummy', price: 10.0, description: 'dummy', galleries: [GalleryModel(id: 999, url: 'https://www.footlocker.id/media/catalog/product/cache/e81e4f913a1cad058ef66fea8e95c839/0/1/01-NIKE-F34KBNIK5-NIKDQ6513060-Black.jpg')]))));
      },
      child: Container(
      margin: EdgeInsets.only(top: 33),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/image_shop_logo.png', width: 54,),
              SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Shoe Store", 
                    style: primaryTextStyle.copyWith(
                      fontSize: 15,
                    ),
                    ),
                    Text(message.message, 
                    style: secondaryTextStyle.copyWith(
                      fontWeight: light,
                    ),
                    overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text('Now', style: secondaryTextStyle.copyWith(fontSize: 10),),
              SizedBox(height: 12,),
              Divider(
                thickness: 1,
                color: Color(0xff282939),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}