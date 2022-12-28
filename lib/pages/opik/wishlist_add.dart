// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:gadgetinaja/API/json_future/json_future.dart';
import 'package:gadgetinaja/API/object_class/wishlist.dart';
import 'package:gadgetinaja/pages/opik/splash_login.dart';
import 'package:gadgetinaja/services/icon_assets.dart';
import 'package:gadgetinaja/services/local_storages.dart';
import 'package:gadgetinaja/services/styles.dart';
import 'package:wave_transition/wave_transition.dart';

class WishlistAdd extends StatefulWidget {
  WishlistAdd({
    super.key,
    required this.id,
  });
  int id;

  @override
  State<WishlistAdd> createState() => _WishlistAddState();
}

class _WishlistAddState extends State<WishlistAdd> {
  String nama = Storages.getName();
  @override
  Widget build(BuildContext context) {
    return nama.isEmpty
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                WaveTransition(
                  duration: const Duration(milliseconds: 700),
                  child: const SplashLogin(
                    navigate: true,
                  ),
                  center: const FractionalOffset(0.5, 0),
                ),
              );
            },
            child: Assets.navbarIcon('heart'),
          )
        : FutureBuilder<GetWishlist>(
            future: JsonFuture().getWishlist(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState != ConnectionState.waiting &&
                  snapshot.data != null) {
                return GestureDetector(
                  onTap: () async {
                    if (snapshot.data!.data!
                            .map(
                              (e) => e.product != null ? e.product!.id : {},
                            )
                            .contains(
                              widget.id,
                            ) !=
                        true) {
                      CreateWishlist wishlist = await JsonFuture()
                          .createWishlist(productId: widget.id.toString());
                      snackBar(context,
                          text: wishlist.info ??
                              wishlist.message ??
                              "TERJADI KESALAHAN");
                      setState(() {});
                    }
                  },
                  child: snapshot.data!.data != null
                      ? Assets.navbarIcon(
                          snapshot.data!.data!
                                  .map(
                                    (e) =>
                                        e.product != null ? e.product!.id : {},
                                  )
                                  .contains(
                                    widget.id,
                                  )
                              ? 'hearton'
                              : 'heart',
                        )
                      : Text(
                          'err',
                          style: Font.style(color: Warna().shadow),
                        ),
                );
              } else {
                return Center(
                  child: Container(),
                );
              }
            },
          );
  }
}
