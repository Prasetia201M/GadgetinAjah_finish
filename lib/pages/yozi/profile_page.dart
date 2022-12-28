import 'package:flutter/material.dart';
import 'package:gadgetinaja/API/json_future/json_future.dart';
import 'package:gadgetinaja/pages/delvy/create_produk_page.dart';
import 'package:gadgetinaja/pages/delvy/list_alamat_page.dart';
import 'package:gadgetinaja/pages/yozi/login_page.dart';
import 'package:gadgetinaja/services/local_storages.dart';
import 'package:gadgetinaja/services/styles.dart';
import 'package:wave_transition/wave_transition.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Warna().primer,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: defaultPadding * 2),
            Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Image(
                    image: AssetImage(
                      'assets/img/img2.png',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      CircleAvatar(
                        backgroundColor: Warna().icon,
                        radius: 45,
                        child: Text(
                          Storages.getName().substring(0, 1).toUpperCase(),
                          style: Font.style(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        Storages.getName().toUpperCase(),
                        style: Font.style(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        Storages.getEmail(),
                        style: Font.style(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Storages.getName() != 'Admin 2'
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        WaveTransition(
                          duration: const Duration(milliseconds: 700),
                          child: ListAlamatPage(),
                          center: const FractionalOffset(0.9, 0.0),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Card(
                        color: Warna().primerCard,
                        child: ListTile(
                          title: Text(
                            'Shipping Address',
                            style: Font.style(),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Warna().font,
                          ),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        WaveTransition(
                          duration: const Duration(milliseconds: 700),
                          child: CreateUpdateProdukPage(),
                          center: const FractionalOffset(0.9, 0.0),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Card(
                        color: Warna().primerCard,
                        child: ListTile(
                          title: Text(
                            'Tambah Produk',
                            style: Font.style(),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Warna().font,
                          ),
                        ),
                      ),
                    ),
                  ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Warna().primerCard,
                      title: Text(
                        'LOGOUT',
                        style: Font.style(),
                        textAlign: TextAlign.center,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      actions: [
                        ElevatedButton(
                          autofocus: true,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Warna().icon,
                          ),
                          child: Icon(
                            Icons.clear_rounded,
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await Notifikasi.notif(
                              title: 'Logout Akun',
                              body:
                                  'Logout dari Akun ${Storages.getEmail()} Berhasil',
                            );
                            await JsonFuture().logout();
                            snackBar(context, text: 'Logout Berhasil');
                            if (Storages.getToken().isEmpty) {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                WaveTransition(
                                  duration: const Duration(milliseconds: 700),
                                  child: const LoginScreen(),
                                  center: const FractionalOffset(0.5, 0.0),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const CircleBorder(),
                            backgroundColor: Warna().primerCard,
                          ),
                          child: Icon(Icons.done, color: Warna().icon),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  color: Warna().primerCard,
                  child: ListTile(
                    title: Text(
                      'Logout',
                      style: Font.style(),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Warna().font,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
