import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AlertWidget{


  static void notificationToast(String msg, Color bgcolor,Color textcolor, int time,context) {
    FToast fToast = FToast();
    fToast.init(context);

    Widget toast = TweenAnimationBuilder(
      tween:Tween<double>(begin: 1,end: 2),
      duration:const Duration(seconds: 1),
      curve: Curves.elasticInOut,
      //animation:;
      builder: (context,scale,child){
        return Transform.scale(scale: 1,child: child,);
      },
      child:  Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: bgcolor,
          ),
          child: Center(
            child: Text(msg,
              style: TextStyle(fontSize: 14,color: textcolor),
            ),
          )
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: time),
    );
  }
}