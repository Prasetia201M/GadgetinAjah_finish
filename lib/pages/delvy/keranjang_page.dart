// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:gadgetinaja/API/json_future/json_future.dart';
import 'package:gadgetinaja/pages/delvy/pembayaran_page.dart';
import 'package:gadgetinaja/pages/delvy/produk_page.dart';
import 'package:gadgetinaja/services/styles.dart';
import 'package:wave_transition/wave_transition.dart';

import '../../API/object_class/keranjang.dart';

class Keranjang extends StatefulWidget {
  const Keranjang({
    Key? key,
  }) : super(key: key);

  @override
  State<Keranjang> createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  // GetKategori kategori;
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    return Scaffold(
        backgroundColor: Warna().primer,
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          elevation: 0,
          title: Text(
            "Cart Page",
            style: Font.style(color: Colors.white),
          ),
          backgroundColor: Warna().first,
          foregroundColor: Warna().primer,
          centerTitle: false,
        ),
        body: FutureBuilder<GetKeranjang>(
            future: JsonFuture().getKeranjang(),
            builder: (context, snapshotGetKeranjang) {
              if (snapshotGetKeranjang.hasData &&
                  snapshotGetKeranjang.connectionState !=
                      ConnectionState.waiting &&
                  snapshotGetKeranjang.data != null) {
                if (snapshotGetKeranjang.data!.data != null) {
                  List<DataGetKeranjang> datakeranjang =
                      snapshotGetKeranjang.data!.data!;
                  int total = 0;
                  datakeranjang.map(
                    (e) {
                      int harga = e.product!.harga!;
                      int quantity = e.qty!;
                      int totalsementara = harga * quantity;
                      total += totalsementara;
                      return total;
                    },
                  ).toList();
                  return datakeranjang.isEmpty
                      ? Center(child: lottieAsset('error'))
                      : Column(
                          children: [
                            Expanded(
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  Container(
                                    color: Color.fromARGB(255, 251, 245, 220),
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.delivery_dining,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 30),
                                            child: Text(
                                              "Dapatkan Cashback Hingga 100% Ketika Pembelian 10 Produk!",
                                              style: Font.style(
                                                  color: Colors.red,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(left: 15),
                                  //   child: Align(
                                  //     alignment: Alignment.centerLeft,
                                  //     child: Row(
                                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         Text(
                                  //           "Total Keranjang",
                                  //           style: Font.style(
                                  //               fontWeight: FontWeight.bold,
                                  //               color: Warna().font,
                                  //               fontSize: 20),
                                  //         ),
                                  //         Padding(
                                  //           padding: const EdgeInsets.only(right: 30),
                                  //           child: Text(
                                  //             "${datakeranjang.length}",
                                  //             style: Font.style(
                                  //                 fontWeight: FontWeight.bold,
                                  //                 color: Warna().font,
                                  //                 fontSize: 20),
                                  //           ),
                                  //         ),

                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: datakeranjang.length,
                                      itemBuilder: (context, index) {
                                        DataGetKeranjang keranjang =
                                            datakeranjang[index];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              WaveTransition(
                                                duration: const Duration(
                                                    milliseconds: 700),
                                                child: ProdukPage(
                                                    id: datakeranjang[index]
                                                        .productId!),
                                                center: const FractionalOffset(
                                                    0.5, 0),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            color: Warna().primerCard,
                                            shadowColor: Warna().shadow,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 10,
                                                vertical: 20,
                                              ),
                                              child: Row(
                                                children: [
                                                  Center(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image(
                                                        width: 60,
                                                        height: 60,
                                                        image: NetworkImage(
                                                            keranjang.product!
                                                                .image!),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            keranjang
                                                                .product!.name!,
                                                            style: Font.style(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 17,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                          ),
                                                          SizedBox(height: 4,),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                            rupiah(
                                                              keranjang.product!
                                                                  .harga!,
                                                            ),
                                                            style: Font.style(
                                                                color: Colors.red,
                                                                fontSize: 17),
                                                          ),
                                                              Text(
                                                                "${keranjang.qty!} pcs",
                                                                style:
                                                                    Font.style(
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(45),
                                                    ),
                                                    
                                                    child: IconButton(
                                                      icon: const Icon(
                                                        Icons
                                                            .delete_forever,
                                                        color: Colors.white,
                                                        size: 25,
                                                      ),
                                                      onPressed: () async {
                                                        DeleteKeranjang
                                                            deleteKeranjang =
                                                            await JsonFuture()
                                                                .deleteKeranjang(
                                                          id: keranjang.id!
                                                              .toString(),
                                                        );
                                                        if (deleteKeranjang
                                                                .code ==
                                                            '00') {
                                                          cart.removecart = 1;
                                                          await Notifikasi.notif(
                                                              title:
                                                                  'Hapus Keranjang',
                                                              body:
                                                                  deleteKeranjang
                                                                      .info!);
                                                        }
                                                        snackBar(
                                                          context,
                                                          text: deleteKeranjang
                                                                  .info ??
                                                              "TERJADI KESALAHAN",
                                                        );
                                                        setState(() {});
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              color: Warna().primerCard,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Total ",
                                            style: Font.style(
                                                fontWeight: FontWeight.bold,
                                                color: Warna().font,
                                                fontSize: 17),
                                          ),
                                          Text(
                                            "( ${datakeranjang.length} Produk )",
                                            style: Font.style(
                                              // fontWeight: FontWeight.bold,
                                              color: Warna().font,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        rupiah(total),
                                        style: Font.style(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(type: PageTransitionType.size, alignment: Alignment.bottomCenter, child: PembayaranPage(
                                                dataKeranjang:
                                                    snapshotGetKeranjang.data!,
                                                total: total),),
                                        );
                                      },
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all<
                                                EdgeInsets>(
                                            const EdgeInsets.symmetric(
                                                vertical: 15)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Warna().icon),
                                        
                                      ),
                                      child: Text(
                                        "Beli Semua",
                                        style: Font.style(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                } else {
                  return Center(
                    child: lottieAsset(
                      'error',
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Warna().terang,
                  ),
                );
              }
            }));
  }
}
