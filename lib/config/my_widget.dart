
import 'package:cargaeboo/config/my_color.dart';
import 'package:flutter/material.dart';


class FullContainer extends StatelessWidget {


  Color backgroundColor;
  Widget child;
  FullContainer({
    this.backgroundColor=Colors.white,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: backgroundColor,
      child: child,
    );
  }
}


class LongButton extends StatelessWidget {

  double width;
  double height;
  Function onTap;
  double borderRadius;
  String text;
  Color backgroundColor;

  LongButton({
    this.height=50,
    required this.onTap,
    this.width=double.infinity,
    this.borderRadius=0,
    required this.text,
    required this.backgroundColor
  });



  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: (){
          onTap();
        },
        child: Container(
            width: width,
            height: height,
            child: Center(child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,fontSize: 15),),)
        ),
      ),
    );
  }
}