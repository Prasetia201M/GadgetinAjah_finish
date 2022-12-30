// ignore_for_file: must_be_immutable, iterable_contains_unrelated_type, unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gadgetinaja/API/object_class/category.dart';
import 'package:gadgetinaja/home/integrate.dart';
import 'package:gadgetinaja/models/produk.dart';
import 'package:gadgetinaja/services/local_storages.dart';
import 'package:gadgetinaja/services/styles.dart';
import 'package:page_transition/page_transition.dart';

class Beranda extends StatelessWidget {
  Beranda({
    super.key,
    required this.listDataKategori,
    required this.listProducts,
  });

  List<DataGetKategoriById> listDataKategori;
  List<ProductsGetKategoriById> listProducts;
  bool nightmode = Storages.getNightMode();
  static final List<String> imgSlider = [
    'banner1.png',
    'banner2.png',
    'banner3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(
          const Duration(milliseconds: 100),
          () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const IntegrateAPI(),
                ));
          },
        );
      },
      child: Container(
        color: Warna().primer,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sponsored',
                    style: Font.style(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    "assets/banner/banner1.png",
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                'Spesial For You',
                style: Font.style(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 10 / 15,
              ),
              itemCount: listProducts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.size,
                            alignment: Alignment.center,
                            child: ProdukPage(id: listProducts[index].id!)));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: [
                        nightmode == false
                            ? BoxShadow(
                                blurRadius: 4,
                                color: Warna().shadow,
                                offset: const Offset(2, 4),
                              )
                            : const BoxShadow(),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Warna().primerCard,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Image.network(
                                      listProducts[index].image!,
                                    ),
                                  );
                                },
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  listProducts[index].image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 5,
                                bottom: 10,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Tooltip(
                                      message: listProducts[index].name!,
                                      child: Text(
                                        listProducts[index].name!,
                                        style: Font.style(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                  Tooltip(
                                    message: rupiah(listProducts[index].harga!),
                                    child: AutoSizeText(
                                      rupiah(listProducts[index].harga!),
                                      style: Font.style(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
