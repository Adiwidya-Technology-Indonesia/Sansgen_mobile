import 'package:get/get.dart';
import 'package:sansgen/app/modules/riwayat/views/belum_baca.dart';
import 'package:sansgen/app/modules/riwayat/views/sudah_baca.dart';

class RiwayatController extends GetxController {
  final currentIndex = 0.obs;
  void setCurrentIndex(int index) => currentIndex.value = index;
  get getSelectedIndex => currentIndex.value;

  final listPage = [
    const BelumSelesaiDiBaca(),
    const SudahSelesaiDiBaca(),
  ];

  final List<Map<String, String>> bookList = [
    {
      'name': 'Buku A',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Fiksi',
      'sinopsis':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    },
    {
      'name': 'Buku B',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Non-Fiksi',
      'sinopsis':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    },
    {
      'name': 'Buku C',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Edukasi',
      'sinopsis':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    },
    {
      'name': 'Buku D',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Sejarah',
      'sinopsis':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    },
    {
      'name': 'Buku E',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Teknologi',
      'sinopsis':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    },
    {
      'name': 'Buku F',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Sains',
      'sinopsis':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    },
    {
      'name': 'Buku G',
      'image':
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//94/MTA-75108153/no-brand_buku-jangan-mulai-bisnis-sebelum-baca-buku-ini-cara-sederhana-tapi-am_full01.jpg',
      'kategori': 'Biografi',
      'sinopsis':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
    },
  ];
}
