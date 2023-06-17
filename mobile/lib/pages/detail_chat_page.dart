import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile/models/gallery_model.dart';
import 'package:mobile/models/message_model.dart';
import 'package:mobile/models/product_model.dart';
import 'package:mobile/providers/auth_provider.dart';
import 'package:mobile/services/message_service.dart';
import 'package:mobile/theme.dart';
import 'package:mobile/widgets/chat_bubble.dart';
import 'package:provider/provider.dart';

class DetailChatPage extends StatefulWidget {
  ProductModel product;
  DetailChatPage({super.key, required this.product});

  @override
  State<DetailChatPage> createState() => _DetailChatPageState();
}

class _DetailChatPageState extends State<DetailChatPage> {
  TextEditingController messageController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleAddMessage()async{
      await MessageService().addMessage(user: authProvider.user, 
      isFromUser: true, message: messageController.text, product: widget.product);
      setState(() {
        widget.product = UninitializedProductModel(id: 999, name: 'dummy', price: 10.0, description: 'dummy', galleries: [GalleryModel(id: 999, url: 'https://www.footlocker.id/media/catalog/product/cache/e81e4f913a1cad058ef66fea8e95c839/0/1/01-NIKE-F34KBNIK5-NIKDQ6513060-Black.jpg')]);
        messageController.text = '';
      });
    }

    PreferredSizeWidget header() {
      return PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: backgroundColor1,
          centerTitle: false,
          title: Row(
            children: [
              Image.asset(
                'assets/image_shop_logo_online.png',
                width: 50,
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shoe Store',
                    style: primaryTextStyle.copyWith(
                      fontWeight: medium,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Online',
                    style: secondaryTextStyle.copyWith(
                      fontWeight: light,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget productPreview(){
      return Container(
        width: 225,
        height: 74,
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor5,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: primaryColor,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: widget.product.galleries[0].url,
                width: 54,
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.product.name, style: primaryTextStyle, overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 2,),
                  Text("\$${widget.product.price}", style: priceTextStyle.copyWith(fontWeight: medium),),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                setState(() {
                  widget.product = UninitializedProductModel(id: 999, name: 'dummy', price: 10.0, description: 'dummy', galleries: [GalleryModel(id: 999, url: 'https://www.footlocker.id/media/catalog/product/cache/e81e4f913a1cad058ef66fea8e95c839/0/1/01-NIKE-F34KBNIK5-NIKDQ6513060-Black.jpg')]);
                });
              },
              child: Image.asset('assets/button_close.png', width: 22,)),
          ],
        ),
      );
    }

    Widget chatInput(){
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.product is UninitializedProductModel ? SizedBox() : productPreview(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: backgroundColor4,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: messageController,
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                          hintText: "Type Message...",
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: handleAddMessage,
                  child: Image.asset('assets/button_send.png', width: 45,)),
              ],
            ),
          ],
        ),
      );
    }

    Widget content(){
      return StreamBuilder<List<MessageModel>>(
        stream: MessageService().getMessagesByUserId(userId: authProvider.user.id),
        builder: (context, snapshot) {

          if(snapshot.hasData){
            return ListView(
              children: [
                Padding(
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: snapshot.data!.map((MessageModel message) => ChatBubble(
                  isSender: message.isFromUser,
                  text: message.message,
                  product: message.product,
                              )).toList(),
                  ),
                ),
              chatInput(),
              ],
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      body: content(),
    );
  }
}