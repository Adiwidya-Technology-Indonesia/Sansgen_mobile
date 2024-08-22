import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sansgen/model/user/user.dart';
import 'package:sansgen/provider/payment.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../model/payment/request_post.dart';

class PaymentBuyController extends GetxController with StateMixin<ModelUser> {
  final PaymentProvider paymentProvider;

  PaymentBuyController({required this.paymentProvider});

  @override
  void onInit() {
    fetchDataProfil();
    super.onInit();
  }

  Future launchURL(String url) async => await canLaunchUrlString(url)
      ? await launchUrlString(url)
      : log('Could not launch $url');

  Future postPayment() async {
    EasyLoading.show(status: 'Loading');
    paymentProvider.postRedirect().then((v) async {
      if (v.redirectUrl != null) {
        EasyLoading.dismiss();
        launchURL(v.redirectUrl!);
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Token Kosong');
        return;
      }
    }).onError((e, st) {
      EasyLoading.dismiss();
      log(e.toString());
      EasyLoading.showError('Pembayaran Gagal');
      return;
    });
  }

  void fetchDataProfil() {
    try {
      if (Get.arguments == null) {
        change(null, status: RxStatus.empty());
      } else {
        change(Get.arguments as ModelUser, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
