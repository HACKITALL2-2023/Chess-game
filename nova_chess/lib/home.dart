import 'package:flutter/material.dart';
import 'package:nova_chess/helper/routes.dart';
import 'package:nova_chess/scrollable_map_world.dart';
import 'package:nova_chess/custom_widgets/background_widget.dart';
import 'package:nova_chess/custom_widgets/custom_app_bar.dart';
import 'package:nova_chess/custom_widgets/custom_row_home.dart';
import 'package:nova_chess/custom_widgets/custom_text_widget.dart';

import 'helper/navigation.dart';
import 'home_tournaments.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum ListItemsHome{
  adventureMode,
  multiplayer,
  liveChess,
  puzzles,
  tournaments,
  coaches,
  minigames
}

class _HomeScreenState extends State<HomeScreen>{
  final ScrollController _scrollViewController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  final List _dataRow = [
    {
      'image': Image.asset('assets/rocket.png'),
      'text': 'Adventure Mode',
      'type': ListItemsHome.adventureMode
    },
    {
      'image': Image.asset('assets/rocket.png'),
      'text': 'Multiplayer',
      'type': ListItemsHome.multiplayer
    }
    // {
    //   'image': Image.asset('assets/digital clock.png'),
    //   'text': 'Live Chess',
    //   'type': ListItemsHome.liveChess
    // },
    // {
    //   'image': Image.asset('assets/puzzle_piece.png'),
    //   'text': 'Puzzles',
    //   'type': ListItemsHome.puzzles
    // },
    // {
    //   'image': Image.asset('assets/trophy.png'),
    //   'text': 'Tournaments',
    //   'type': ListItemsHome.tournaments
    // },
    // {
    //   'image': Image.asset('assets/whistle.png'),
    //   'text': 'Coaches',
    //   'type': ListItemsHome.coaches
    // },
    // {
    //   'image': Image.asset('assets/joystick.png'),
    //   'text': 'Minigames',
    //   'type': ListItemsHome.minigames
    // },
  ];

  void _navigationRoute(ListItemsHome type) async {
    if(type == ListItemsHome.tournaments){
      await Navigator.of(context).pushNamed(OwnRouter.tournamentsRoute);
    } else if(type == ListItemsHome.adventureMode){
      await Navigator.of(context).pushNamed(OwnRouter.scrollableMapWorldRoute);
    } else if(type == ListItemsHome.multiplayer) {
      await Navigator.of(context).pushNamed(OwnRouter.multiplayerRoute);
    }
  }

  @override
  void dispose(){
    _scrollViewController.removeListener(() {});
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
	final user = ModalRoute.of(context)!.settings.arguments as UserLogIn?;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 19, 10, 51),
      appBar: CustomAppBar(
        showAppbar: true,
        scaffoldKey: scaffoldKey,
        width: width,
        height: height
      ),
      endDrawer: Drawer(
        child: Container(),
      ),
      body: BackgroundWidget(
        height: height,
        width: width,
        child: SingleChildScrollView(
          controller: _scrollViewController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(var row in _dataRow)
                CustomRowHome(
                  width: width,
                  height: height,
                  imageButton: row['image'],
                  buttonText: row['text'],
                  onPressed: () => _navigationRoute(row['type']),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: width * 0.4,
                    height: height * 0.21,
                    child: Image.asset('assets/cal_meteorit.png'),
                  ),
                  Container(
                    width: width * 0.12,
                    height: width * 0.12,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(25, 144, 162, 255).withOpacity(0.03)
                    ),
                    child: const CustomTextWidgetWhite(
                      text: '?',
                      textSize: 30,
                    ),
                  ),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}