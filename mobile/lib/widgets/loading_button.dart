import 'package:flutter/material.dart';
import '../theme.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(onPressed: (){}, child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 16, height: 16, child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(
                primaryTextColor,
              ),
            )),
            SizedBox(width: 6,),
            Text("Loading", style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),),
          ],
        ),
        style: TextButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        )),
        ),
      );
  }
}