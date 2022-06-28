import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/widgets/categorries.dart';
import 'package:core/widgets/profile_text.dart';
import 'package:core/widgets/wisata_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:wisata/presentation/bloc/wisata_bloc.dart';
import 'package:wisata/presentation/pages/list_wisata_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: 200,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileNameTitle(),
                  const SizedBox(height: 5,),
                  const Text(
                    'Discover \nPesona Indonesia',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 40,
                      color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, SearchPage.routeName),
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.search),
                          Text('  Cari Wisata Terbaik dan UMKM Sekitar...')
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Categories(),
            Column(
              children: [
                const Divider(height: 5, thickness: 5),
                Stack(
                  children: [
                    SizedBox(
                      height: 340,
                      width: double.maxFinite,
                      child: BlocBuilder<WisataBloc, WisataState>(
                        builder: ((context, state) {
                          if (state is WisataLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is WisataLoaded) {
                            return CarouselSlider(
                                items: state.wisata
                                    .map((e) => WisataCard(wisata: e))
                                    .toList(),
                                options: CarouselOptions(
                                    aspectRatio: 1.5,
                                    viewportFraction: 0.9,
                                    autoPlay: true,
                                    autoPlayInterval: const Duration(seconds: 6),
                                    autoPlayAnimationDuration:
                                    const Duration(milliseconds: 900),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
                                    enableInfiniteScroll: true,
                                    initialPage: 2));
                          } else {
                            return const Text('Error');
                          }
                        }),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: _buildSubHeading(
                          title: "Wisata Terbaik",
                          onTap: () {
                            Navigator.pushNamed(
                                context, ListWisataPage.routeName);
                          }),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 5,
              thickness: 5,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSub("Majukan Wisata dan UMKM di Indonesia"),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      _cardView(),
                      const SizedBox(
                        width: 10,
                      ),
                      _cardView(),
                      const SizedBox(
                        width: 10,
                      ),
                      _cardView()
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 5,
              thickness: 5,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSub("Bantuan dan Cara Penggunaan"),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      _cardView(),
                      const SizedBox(
                        width: 10,
                      ),
                      _cardView(),
                      const SizedBox(
                        width: 10,
                      ),
                      _cardView()
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, Function()? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Lihat Semua',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  _buildSub(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container _cardView() {
    return Container(
      height: 100,
      width: 220,
      decoration: BoxDecoration(
          color: Colors.lightBlue, borderRadius: BorderRadius.circular(10)),
      child: const Center(
        child: Text('UMKM'),
      ),
    );
  }
}
