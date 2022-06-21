import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/data/models/wisata_model.dart';
import 'package:core/widgets/fetchUmkm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailPage extends StatelessWidget {
  static const routeName = "/detailpage";
  final Wisata wisata;
  const DetailPage({Key? key, required this.wisata}) : super(key: key);
  static Route route({required Wisata wisata}) {
    return MaterialPageRoute(
      // ignore: prefer_const_constructors
      settings: RouteSettings(name: routeName),
      // ignore: prefer_const_constructors
      builder: (_) => DetailPage(
        wisata: wisata,
      ),
    );
  }

  Future addToWishlist() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("wishlist-wisata");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": wisata.name,
      "address": wisata.address,
      "provincy": wisata.provincy,
      "category": wisata.category,
      "description": wisata.description,
      "imgUrl": wisata.imgUrl,
    }).then((value) =>
        SnackBar(content: Text('Wisata Berhasil Masuk ke Wishlist')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [],
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  height: 50,
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    '${wisata.name}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                )),
            pinned: true,
            backgroundColor: Colors.lightBlue,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                wisata.imgUrl,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    IconName(
                      text: '${wisata.category}',
                      icon: Icons.local_cafe,
                    ),
                    IconName(
                      text: '${wisata.address}',
                      icon: Icons.pin_drop_outlined,
                    ),
                    IconName(
                        text: '${wisata.provincy}',
                        icon: Icons.local_activity_outlined),
                  ],
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.maxFinite,
                    child: Text(
                      '${wisata.description}',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Text('UMKM Sekitar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Container(
                  height: 500,
                  child: fetchUmkm('umkm', wisata.name),
                )
              ],
            ),
          ))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          child: InkWell(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: EdgeInsets.all(10),
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightBlue),
              child: Center(
                  child: Text(
                    'Tambah Whislist',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
          ),
          onTap: () => addToWishlist(),
        ),
      ),
    );
  }
}

class IconName extends StatelessWidget {
  final String text;
  final IconData? icon;
  const IconName({Key? key, required this.text, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 22,
          color: Colors.lightBlue,
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: 290,
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
