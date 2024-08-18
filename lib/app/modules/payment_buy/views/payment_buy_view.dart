import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sansgen/utils/ext_context.dart';
import 'package:sansgen/widgets/avatar_widget.dart';

import '../../../routes/app_pages.dart';
import '../controllers/payment_buy_controller.dart';

class PaymentBuyView extends GetView<PaymentBuyController> {
  const PaymentBuyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Scaffold(
        appBar: appBar(context: context, image: state!.image!),
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
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: controller.postPayment,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              'Bayar',
              style: context.titleMedium
                  .copyWith(color: context.colorScheme.primary),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar({required BuildContext context, required String image}) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: context.colorScheme.primary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: ()=> Get.offAllNamed(Routes.DASHBOARD,arguments: 3),
            child: AvatarWidget(
              image: image,
              height: 50.0,
              width: 50,
            ),
          ),
          const Text(
            'Premium',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 50.0,
            width: 50,
          ),
        ],
      ),
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
