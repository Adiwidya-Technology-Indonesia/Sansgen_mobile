import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:get/get.dart';

import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/avatar_widget.dart';

import '../controllers/payment_buy_controller.dart';

class PaymentBuyView extends GetView<PaymentBuyController> {
  const PaymentBuyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => Scaffold(
        appBar: appBar(context:context,image: state!.image),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              txtMain(
                  txt:
                      'Nikmati Pengalaman Membaca Tanpa Batas dengan Aku Premium di Sansgen!',
                  context: context),
              txtDot(
                  txtDot:
                      'Sebagai pengguna premium, Anda memiliki akses tak terbatas ke seluruh koleksi buku di Sansgen. Dari buku sejarah, biografi, hingga buku-buku ilmiah, semuanya tersedia untuk Anda baca kapan saja dan di mana saja. Tidak ada lagi batasan jumlah buku yang bisa Anda nikmati setiap bulannya!',
                  context: context),
              txtDot(
                  txtDot:
                      'Update dan Rekomendasi Eksklusif, Dapatkan rekomendasi buku terbaru dan terpopuler yang disesuaikan dengan preferensi Anda. Pengguna premium selalu menjadi yang pertama mendapatkan notifikasi tentang buku-buku baru yang dirilis dan event-event eksklusif yang diadakan oleh Sansgen.',
                  context: context),
              const SizedBox(
                height: 10,
              ),
              txtMain(
                  txt:
                      'Jangan lewatkan kesempatan untuk meningkatkan pengalaman membaca Anda! Berlangganan Akun Premium hanya dengan membayar \$12 di aplikasi baca buku Sansgen sekarang dan rasakan sendiri perbedaannya.',
                  context: context),
              const Gap(180),
              ElevatedButton(
                onPressed: () {
                  controller.payment(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  'Simpan',
                  style: context.titleMedium
                      .copyWith(color: context.colorScheme.primary),
                ),
              )
            ],
          ),
        )));
  }

  AppBar appBar({required BuildContext context, required String image}) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: context.colorScheme.primary,
      title: Row(
        children: [
           GestureDetector(
              onTap: Get.back,
              child: AvatarWidget(image: image,height: 50.0,)),
          const Gap(73),
          const Text(
            'Premium',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  SizedBox txtMain({required String txt, required BuildContext context}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            txt,
            style: context.titleMedium,
          ),
        ],
      ),
    );
  }

  SizedBox txtDot({required String txtDot, required BuildContext context}) {
    return SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              '•',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(txtDot, style: context.titleMedium, softWrap: true))
          ],
        ));
  }
}
