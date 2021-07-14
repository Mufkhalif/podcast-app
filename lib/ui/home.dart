import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:podcast_app/theme/theme.dart';
import 'package:podcast_app/widgets/cardTop.dart';
import 'package:podcast_app/widgets/cardVertical.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF7F8FA),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Color(0xffE5E5E5),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, //
        selectedLabelStyle: boldText.copyWith(color: primaryColor),
        unselectedLabelStyle: boldText.copyWith(color: Color(0xffE5E5E5)),
        items: [
          BottomNavigationBarItem(
            label: 'Explore',
            icon: Icon(Icons.explore_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Cari',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Simpan',
            icon: Icon(Icons.bookmark),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person_sharp),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.blue,
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment
                    .bottomLeft, // 10% of the width, so there are ten blinds.
                colors: [
                  Color(0xff2D51D0),
                  Color(0xff0B2990),
                ], // red to yellow
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: width - 30,
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Search Podcast',
                            style: regularText.copyWith(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(0.7),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Podcast in Trending',
                          style: boldText.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'See All',
                          style: regularText.copyWith(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 21),
                  Container(
                    height: 300,
                    child: ListView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      children: [
                        CardTop(),
                        CardTop(),
                        CardTop(),
                      ],
                    ),
                  ),
                  SizedBox(height: 31),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recommend for your',
                          style: boldText.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'See All',
                          style: regularText.copyWith(
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 21),
                  CardVertical(),
                  CardVertical(),
                  CardVertical(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
