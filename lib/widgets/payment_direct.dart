import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sansgen/app/routes/app_pages.dart';

GestureDetector paymentDirect({required String img}){
  return GestureDetector(
    onTap: (){
      Get.toNamed(Routes.PAYMENT_DETAILS);
    },
    child: Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding:EdgeInsets.only(left: 10,right:10 ),
        child: Row(
          children: [
            Image.asset(img,width: 100,),
          ],
        ),
      ),
    ),
  );
}