import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';

class PaymentBuyController extends GetxController {
  void Payment(BuildContext context) {
    Get.bottomSheet(
      ignoreSafeArea: false,
      isScrollControlled: true,
      Container(
        height: 700,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Gap(10),
            Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: context.titleLargeBold,
                        ),
                        Text('Rp100.000',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Gap(10),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: context.colorScheme.secondary,
                    ),
                    Gap(20),
                    Text('Pilih Metode Pembayaran',style: context.titleLargeBold.copyWith(color: context.colorScheme.secondary),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
