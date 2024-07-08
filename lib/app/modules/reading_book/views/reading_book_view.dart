import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reading_book_controller.dart';

class ReadingBookView extends GetView<ReadingBookController> {
  const ReadingBookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReadingBookView'),
        // centerTitle: true,
      ),
      key: controller.scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: controller.closeDrawer,
            )
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'ReadingBookView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
