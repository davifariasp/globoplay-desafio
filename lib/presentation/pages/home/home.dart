import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:globoplay_mobile/presentation/pages/home/midas.dart';
import 'package:globoplay_mobile/presentation/pages/home/mylist.dart';
import 'package:globoplay_mobile/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pgIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pgIndex);
  }

  setPage(page) {
    setState(() {
      pgIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        toolbarHeight: 80,
        title: SvgPicture.asset(
          'lib/assets/globoplay-logo.svg',
          colorFilter: const ColorFilter.mode(
            white,
            BlendMode.srcIn,
          ),
          width: 200,
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: setPage,
        children: const [MidiasPage(), MyListPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pgIndex,
        iconSize: 30,
        backgroundColor: black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Minha lista',
          ),
        ],
        onTap: (page) {
          pageController.animateToPage(page,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
        selectedItemColor: white,
        unselectedItemColor: greyIcon,
      ),
    );
  }
}
