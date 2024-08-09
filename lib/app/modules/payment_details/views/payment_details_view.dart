import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sks_ticket_view/sks_ticket_view.dart';

import '../controllers/payment_details_controller.dart';

class PaymentDetailsView extends GetView<PaymentDetailsController> {
  const PaymentDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Payment Details'),
        centerTitle: true,
      ),
      body: Stack(alignment: Alignment.topCenter, children: [
        receipt(context),
        CircleAvatar(
          radius: 42,
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 50,
          ),
        )
      ]),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(30),
          Container(
            width: 300,
            height: 50,
            child: ElevatedButton(onPressed: () {}, child: Text('Selesai')),
          ),
        ],
      ),
    );
  }

  Padding receipt(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SKSTicketView(
        backgroundPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(vertical: 100, horizontal: 0),
        drawArc: false,
        triangleAxis: Axis.vertical,
        borderRadius: 6,
        drawDivider: true,
        trianglePos: .5,
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text('Payment Total',
                    style: context.titleSmall
                        .copyWith(color: context.colorScheme.secondary)),
                Text(
                  '\$12.00',
                  style: context.titleLargeBold,
                ),
                Gap(20),
               txtReceipt(context: context, label: 'Date', content: '12 May 2024'),
                Gap(20),
               txtReceipt(context: context, label: 'Details', content: 'Premium Sansgen'),
                Gap(20),
               txtReceipt(context: context, label: 'Reference num', content: 'A06453826151'),
                Gap(20),
               txtReceipt(context: context, label: 'Account', content: 'Rahmat Hidayat'),
               Gap(100),
               txtReceipt(context: context, label: 'Total Payment', content: '\$11.00'),
               Gap(20),
               txtReceipt(context: context, label: 'Admin fee', content: '\$1.00'),
               Gap(20),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',style: context.titleSmall.copyWith(color: context.colorScheme.secondary),),
                  Text('\$12.00',style: context.titleSmallBold.copyWith(color: context.colorScheme.surface))
                ],
              )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row txtReceipt({required BuildContext context,required String label,required String content}) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label,style: context.titleSmall.copyWith(color: context.colorScheme.secondary),),
                  Text(content,style: context.titleSmall,)
                ],
              );
  }
}
