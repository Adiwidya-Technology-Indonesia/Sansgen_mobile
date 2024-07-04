import 'package:get/get.dart';

class KategoriController extends GetxController {
  final List<String> kategoriList = [
    'Fiksi',
    'Non-Fiksi',
    'Edukasi',
    'Sejarah',
    'Teknologi',
    'Sains',
    'Biografi',
    'Komik',
  ];

  final List<Map<String, String>> bookList = [
    {
      'name': 'Buku A',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Fiksi',
    },
    {
      'name': 'Buku B',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Non-Fiksi',
    },
    {
      'name': 'Buku C',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Edukasi',
    },
    {
      'name': 'Buku D',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Sejarah',
    },
    {
      'name': 'Buku E',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Teknologi',
    },
    {
      'name': 'Buku F',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Sains',
    },
    {
      'name': 'Buku G',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Biografi',
    },
  ];
}
