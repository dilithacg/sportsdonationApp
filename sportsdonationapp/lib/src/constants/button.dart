
import 'package:flutter/material.dart';
import 'package:sportsdonationapp/src/constants/colors.dart';


class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const RoundButton({Key? key ,
    required this.title,
    required this.onTap
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 360,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.sPrimaryColor,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Center(child: Text(title,style: TextStyle(color: Colors.white),),),
        ),
      ),
    );
  }
}



