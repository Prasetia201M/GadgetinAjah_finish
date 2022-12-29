import 'package:flutter/material.dart';
import 'package:gadgetinaja/API/json_future/json_future.dart';
import 'package:gadgetinaja/pages/delvy/create_produk_page.dart';
import 'package:gadgetinaja/pages/delvy/list_alamat_page.dart';
import 'package:gadgetinaja/pages/yozi/login_page.dart';
import 'package:gadgetinaja/services/local_storages.dart';
import 'package:gadgetinaja/services/styles.dart';
import 'package:page_transition/page_transition.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Warna().first,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Stack(
              children: [
                Image(
                  image: AssetImage(
                    'assets/img/bg2.jpg',
                  ),
                  fit: BoxFit.contain,
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      // CircleAvatar(
                      //   backgroundColor: Warna().icon,
                      //   radius: 45,
                      //   child: Text(
                      //     Storages.getName().substring(0, 1).toUpperCase(),
                      //     style: Font.style(
                      //       fontSize: 35,
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        height: MediaQuery.of(context).size.height / 6,
                        width: MediaQuery.of(context).size.width,
                        child: lottieAsset('profile'),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        Storages.getName().toUpperCase(),
                        style: Font.style(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        Storages.getEmail(),
                        style: Font.style(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
              child: Text(
                "Menu Halaman",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                color: Warna().primerCard,
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text(
                    'Atur Profile',
                    style: Font.style(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Storages.getName() != 'Admin 2'
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: ListAlamatPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        color: Warna().primerCard,
                        child: ListTile(
                          leading: Icon(Icons.location_on_sharp),
                          title: Text(
                            'Atur Alamat',
                            style: Font.style(),
                          ),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: CreateUpdateProdukPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                color: Warna().primerCard,
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    'Settings',
                    style: Font.style(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Warna().primerCard,
                      title: Text(
                        'Keluar dari akun?',
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
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: LoginScreen(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: const CircleBorder(),
                            backgroundColor: Warna().first,
                          ),
                          child: Icon(Icons.done, color: Colors.white),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  color: Warna().primerCard,
                  child: ListTile(
                    title: Text(
                      'Logout',
                      style: Font.style(),
                    ),
                    leading: Icon(Icons.logout),
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
