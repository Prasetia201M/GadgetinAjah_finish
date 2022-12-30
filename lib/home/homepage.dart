// ignore_for_file: use_build_context_synchronously

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:gadgetinaja/API/object_class/category.dart';
import 'package:gadgetinaja/API/object_class/keranjang.dart';
import 'package:gadgetinaja/home/keranjang_page.dart';
import 'package:gadgetinaja/home/beranda_page.dart';
import 'package:gadgetinaja/Login/splash_login.dart';
import 'package:gadgetinaja/wishlist/wishlist_page.dart';
import 'package:gadgetinaja/Transaksi/pesanan.dart';
import 'package:gadgetinaja/models/profile.dart';
import 'package:gadgetinaja/services/icon_assets.dart';
import 'package:gadgetinaja/services/local_storages.dart';
import 'package:gadgetinaja/services/styles.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required this.listProducts,
    required this.listDataKategori,
    required this.getkeranjang,
    required this.selectedIndex,
  });
  List<ProductsGetKategoriById> listProducts;
  List<DataGetKategoriById> listDataKategori;
  GetKeranjang getkeranjang;
  int selectedIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool nightmode = Storages.getNightMode();
  @override
  Widget build(BuildContext context) {
    String nama = Storages.getName();
    var cart = context.watch<Cart>();
    return DefaultTabController(
      initialIndex: widget.selectedIndex,
      length: 4,
      child: Scaffold(
        backgroundColor: Warna().primer,
        appBar: widget.selectedIndex == 3
            ? null
            : AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 70,
                elevation: 0,
                backgroundColor: Warna().first,
                title: Tooltip(
                    message: 'GadgetinAja', child: Assets.logo(width: 130)),
                actions: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         PageTransition(
                  //           type: PageTransitionType.size,
                  //           alignment: Alignment.bottomCenter,
                  //           child: SearchPage(
                  //             listProducts: widget.listProducts,
                  //           ),
                  //         ));
                  //   },
                  //   child: Tooltip(
                  //       message: 'Cari Produk',
                  //       child: Assets.appbarIcon('search', width: 25)),
                  // ),
                  // const SizedBox(
                  //   width: 17,
                  // ),
                  // nama.isNotEmpty && cart.cart != 0
                  //     ? Badge(
                  //         badgeColor: Warna().font,
                  //         position: BadgePosition.topEnd(
                  //           top: 5,
                  //           end: -5,
                  //         ),
                  //         badgeContent: Text(
                  //           cart.cart.toString(),
                  //           // Storages.getLengthCart().toString(),
                  //           style: Font.style(color: Warna().primer),
                  //         ),
                  //         child: GestureDetector(
                  //           onTap: () async {
                  //             Navigator.push(
                  //                 context,
                  //                 PageTransition(
                  //                   type: PageTransitionType.scale,
                  //                   alignment: Alignment.bottomCenter,
                  //                   child: const Keranjang(),
                  //                 ));
                  //           },
                  //           child: Tooltip(
                  //               message: 'Cart',
                  //               child: Assets.appbarIcon('cart')),
                  //         ),
                  //       )
                  //     :
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.bottomCenter,
                            child: nama.isNotEmpty
                                ? Keranjang()
                                : SplashLogin(navigate: true),
                          ));
                    },
                    child: Tooltip(
                        message: 'Cart',
                        child: Assets.appbarIcon('cart', width: 25)),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // Tooltip(
                  //   message: "Night Mode / Light Mode",
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8),
                  //     child: DayNightSwitcherIcon(
                  //       isDarkModeEnabled: nightmode,
                  //       onStateChanged: (isDarkModeEnabled) async {
                  //         await Storages().setNightMode(
                  //           nightMode: nightmode == false ? true : false,
                  //         );
                  //         Navigator.pushReplacement(
                  //           context,
                  //           WaveTransition(
                  //             duration: const Duration(milliseconds: 500),
                  //             child: HomePage(
                  //               listProducts: widget.listProducts,
                  //               listDataKategori: widget.listDataKategori,
                  //               getkeranjang: widget.getkeranjang,
                  //               selectedIndex: widget.selectedIndex,
                  //             ),
                  //             center: const FractionalOffset(0.9, 0.0),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
        body: DoubleBack(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Beranda(
                          listProducts: widget.listProducts,
                          listDataKategori: widget.listDataKategori,
                        ),
                        nama.isNotEmpty
                            ? const WishList()
                            : SplashLogin(navigate: false),
                        nama.isNotEmpty
                            ? const Pesanan()
                            : SplashLogin(navigate: false),
                        nama.isNotEmpty
                            ? const Profile()
                            : SplashLogin(navigate: false),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(child: Container()),
                  Container(
                    decoration: BoxDecoration(
                      color: Warna().primerCard,
                      boxShadow: [
                        nightmode == false
                            ? BoxShadow(
                                blurRadius: 7,
                                color: Warna().shadow,
                                offset: const Offset(2, 4))
                            : const BoxShadow(),
                      ],
                    ),
                    height: 75,
                    child: TabBar(
                      onTap: (value) {
                        setState(() {
                          widget.selectedIndex = value;
                        });
                      },
                      labelColor: Warna().first,
                      indicatorColor: Colors.transparent,
                      tabs: [
                        Tab(
                          icon: Tooltip(
                            message: 'Beranda',
                            child: Assets.navbarIcon(
                                widget.selectedIndex != 0 ? 'home' : 'homeon'),
                          ),
                        ),
                        Tab(
                          icon: Tooltip(
                            message: 'Wishlist',
                            child: Assets.navbarIcon(widget.selectedIndex != 1
                                ? 'heart'
                                : 'hearton'),
                          ),
                        ),
                        Tab(
                          icon: Tooltip(
                            message: 'Transaksi',
                            child: Assets.navbarIcon(
                                widget.selectedIndex != 2 ? 'note' : 'noteon'),
                          ),
                        ),
                        Tab(
                          icon: Tooltip(
                            message: 'Profil',
                            child: Assets.navbarIcon(
                                widget.selectedIndex != 3 ? 'user' : 'useron'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
