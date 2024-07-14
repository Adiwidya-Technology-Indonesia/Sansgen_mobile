import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/user/user.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/payment_direct.dart';

import '../../../../provider/user.dart';

class PaymentBuyController extends GetxController with StateMixin<ModelUser>{

final UserProvider userProvider;

  PaymentBuyController({required this.userProvider});

  void payment(BuildContext context) {
    Get.bottomSheet(
      ignoreSafeArea: false,
      isScrollControlled: true,
      Container(
        height: 450,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const Gap(10),
            Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)),
            ),
            Padding(
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
                      const Text('Rp100.000',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  const Gap(10),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: context.colorScheme.secondary,
                  ),
                  const Gap(20),
                  Text('Pilih Metode Pembayaran',style: context.titleLargeBold.copyWith(color: context.colorScheme.secondary),),
                  const Gap(20),
                  paymentDirect(img: 'assets/images/Dana.png'),
                  const Gap(20),
                  paymentDirect(img: 'assets/images/Gopay.png'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onInit() async {
    await fetchDataProfil();
    super.onInit();
  }

  Future<void> fetchDataProfil() async {
    await userProvider.fetchUserId().then((v) async {
      if (v.data == null) {
        change(null, status: RxStatus.empty());
      } else {
        change(v.data, status: RxStatus.success());
      }
    }).onError((e, st) {
      change(null, status: RxStatus.error(e.toString()));
    });
  }
}
