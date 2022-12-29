// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:gadgetinaja/API/json_future/json_future.dart';
import 'package:gadgetinaja/API/object_class/barang.dart';
import 'package:gadgetinaja/API/object_class/keranjang.dart';
import 'package:gadgetinaja/pages/delvy/create_produk_page.dart';
import 'package:gadgetinaja/pages/delvy/keranjang_page.dart';
import 'package:gadgetinaja/pages/opik/splash_login.dart';
import 'package:gadgetinaja/pages/opik/star_penjual.dart';
import 'package:gadgetinaja/pages/opik/wishlist_add.dart';
import 'package:gadgetinaja/services/icon_assets.dart';
import 'package:gadgetinaja/services/local_storages.dart';
import 'package:gadgetinaja/services/styles.dart';
import 'package:wave_transition/wave_transition.dart';

class ProdukPage extends StatefulWidget {
  ProdukPage({
    required this.id,
    Key? key,
  }) : super(key: key);

  int id;

  @override
  State<ProdukPage> createState() => _ProdukPage();
}

class _ProdukPage extends State<ProdukPage> {
  bool nightmode = Storages.getNightMode();
  String nama = Storages.getName();
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Warna().primer,
        extendBodyBehindAppBar: true,
        body: FutureBuilder<GetBarangById>(
            future: JsonFuture().getBarangById(id: widget.id.toString()),
            builder: (context, snapshotBarang) {
              if (snapshotBarang.hasData &&
                  snapshotBarang.connectionState != ConnectionState.waiting &&
                  snapshotBarang.data != null) {
                if (snapshotBarang.data!.data != null) {
                  DataGetBarangById databarang = snapshotBarang.data!.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Image(
                                            image:
                                                NetworkImage(databarang.image!),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(25),
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Image(
                                        image: NetworkImage(databarang.image!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BackButton(
                                        color: Warna().icon,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        databarang.name!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: Font.style(
                                            fontWeight: FontWeight.bold,
                                            color: Warna().font,
                                            fontSize: 25),
                                      ),
                                      WishlistAdd(
                                        id: widget.id,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    rupiah(databarang.harga!),
                                    style: Font.style(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Detail Produk",
                                    style: Font.style(
                                        fontWeight: FontWeight.bold,
                                        color: Warna().font,
                                        fontSize: 18),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Stok",
                                            maxLines: 5,
                                            style: Font.style(
                                                color: Warna().font,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "Kategori",
                                            maxLines: 5,
                                            style: Font.style(
                                                color: Warna().font,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            "Rating",
                                            maxLines: 5,
                                            style: Font.style(
                                                color: Warna().font,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ": ${databarang.stock!}",
                                            maxLines: 5,
                                            style: Font.style(
                                                color: Warna().font,
                                                fontSize: 15),
                                          ),
                                          Text(
                                            ": ${databarang.category!.name!}",
                                            maxLines: 5,
                                            style: Font.style(
                                                color: Warna().font,
                                                fontSize: 15),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                ":",
                                                maxLines: 5,
                                                style: Font.style(
                                                    color: Warna().font,
                                                    fontSize: 15),
                                              ),
                                              ReviewStar(
                                                id: widget.id,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Deskripsi Produk",
                                    style: Font.style(
                                        fontWeight: FontWeight.bold,
                                        color: Warna().font,
                                        fontSize: 18),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    thickness: 1,
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        modalbottom(context, databarang),
                                    child: Text(
                                      databarang.deskripsi!,
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.fade,
                                      style: Font.style(
                                          color: Warna().font, fontSize: 15),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Warna().primerCard,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: nama == 'Admin 2'
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            WaveTransition(
                                              duration: const Duration(
                                                  milliseconds: 700),
                                              child: CreateUpdateProdukPage(
                                                id: databarang.id,
                                                image: databarang.image,
                                                category_id: databarang
                                                    .categoryId
                                                    .toString(),
                                                deskripsi: databarang.deskripsi,
                                                harga:
                                                    databarang.harga.toString(),
                                                name: databarang.name,
                                                stock:
                                                    databarang.stock.toString(),
                                              ),
                                              center: const FractionalOffset(
                                                  0.5, 0),
                                            ),
                                          );
                                        },
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsets>(
                                            const EdgeInsets.symmetric(
                                              vertical: 15,
                                            ),
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Warna().icon),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  const BorderRadius.horizontal(
                                                left: Radius.circular(50),
                                              ),
                                              side: BorderSide(
                                                  color: Warna().icon),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "PERBARUI",
                                          style: Font.style(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () async {
                                          DeleteBarang deleteBarang =
                                              await JsonFuture().deleteBarang(
                                            id: widget.id.toString(),
                                          );
                                          snackBar(
                                            context,
                                            text: deleteBarang.info ??
                                                'TERJADI KESALAHAN',
                                          );
                                          if (deleteBarang.code == '00') {
                                            Navigator.pushReplacement(
                                              context,
                                              WaveTransition(
                                                duration: const Duration(
                                                    milliseconds: 700),
                                                child:
                                                    ProdukPage(id: widget.id),
                                                center: const FractionalOffset(
                                                    0.5, 0.5),
                                              ),
                                            );
                                          }
                                        },
                                        style: ButtonStyle(
                                          padding: MaterialStateProperty.all<
                                              EdgeInsets>(
                                            const EdgeInsets.symmetric(
                                              vertical: 15,
                                            ),
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 3,
                                                  color: Warna().icon),
                                              borderRadius:
                                                  const BorderRadius.horizontal(
                                                right: Radius.circular(50),
                                              ),
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "HAPUS",
                                          style: Font.style(
                                            fontSize: 18,
                                            color: Warna().icon,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : PlusMinus(
                                  qty: databarang.stock ?? 0,
                                  id: widget.id,
                                ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: lottieAsset('error'),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Warna().terang,
                  ),
                );
              }
            }),
      ),
    );
  }

  Future<dynamic> modalbottom(
      BuildContext context, DataGetBarangById databarang) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => makeDismisibble(
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.6,
          builder: (_, contoller) => Container(
            decoration: BoxDecoration(
                color: Warna().primerCard,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20))),
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: ListView(
              controller: contoller,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        databarang.name!,
                        style: Font.style(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Deskripsi",
                      style:
                          Font.style(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      databarang.deskripsi!,
                      textAlign: TextAlign.justify,
                      style: Font.style(fontSize: 15),
                    ),
                    const SizedBox(height: 15)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeDismisibble({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(onTap: () {}, child: child),
      );
}

class PlusMinus extends StatefulWidget {
  PlusMinus({
    Key? key,
    required this.qty,
    required this.id,
  }) : super(key: key);

  int qty;
  int id;

  @override
  State<PlusMinus> createState() => _PlusMinusState();
}

class _PlusMinusState extends State<PlusMinus> {
  int counter = 1;
  @override
  void initState() {
    if (widget.qty == 0) counter = widget.qty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String nama = Storages.getName();
    var cart = context.watch<Cart>();
    return Row(
      // mainAxisAlignment: MainAxisAlignment.s,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (counter > 1) {
                  setState(() {
                    counter -= 1;
                  });
                }
              },
              child: Assets.lainnyaIcon(
                'count_minus',
                height: 30,
                color: Warna().icon,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                counter.toString(),
                style: Font.style(fontSize: 30, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (counter < widget.qty) {
                  setState(() {
                    counter += 1;
                  });
                }
              },
              child: Assets.lainnyaIcon(
                'count_plus',
                height: 30,
                color: Warna().icon,
              ),
            ),
          ],
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextButton(
              onPressed: () async {
                if (nama.isEmpty) {
                  Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const SplashLogin(navigate: true),
                      ));
                } else {
                  CreateKeranjang keranjang =
                      await JsonFuture().createKeranjang(
                    productId: widget.id.toString(),
                    qty: counter.toString(),
                  );
                  snackBar(
                    context,
                    text: keranjang.info ??
                        keranjang.message ??
                        'TERJADI KESALAHAN',
                  );
                  if (keranjang.code == '00') {
                    cart.addcart = 1;
                    Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const Keranjang(),
                        ));
                  }
                }
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Warna().icon),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                      color: Warna().icon,
                    ),
                  ),
                ),
              ),
              child: Text(
                "ADD CART",
                style: Font.style(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
