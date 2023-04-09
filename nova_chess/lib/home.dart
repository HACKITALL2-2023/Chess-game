import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nova_chess/helper/routes.dart';
import 'package:nova_chess/scrollable_map_world.dart';
import 'package:nova_chess/custom_widgets/background_widget.dart';
import 'package:nova_chess/custom_widgets/custom_app_bar.dart';
import 'package:nova_chess/custom_widgets/custom_row_home.dart';
import 'package:nova_chess/custom_widgets/custom_text_widget.dart';

import 'custom_widgets/custom_button_blue.dart';
import 'custom_widgets/custom_text_field.dart';
import 'helper/navigation.dart';
import 'helper/user.dart';
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
  minigames,
  joinMultiplayer,
  history,
  replay
  friends
}

class _HomeScreenState extends State<HomeScreen>{
  final ScrollController _scrollViewController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final TextEditingController _gameIdFieldController = TextEditingController();
  bool _gameIDValide = true;
  
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
    },
    {
      'image': Image.asset('assets/rocket.png'),
      'text': 'Join Multiplayer',
      'type': ListItemsHome.joinMultiplayer
    },
    {
      'image': Image.asset('assets/digital clock.png'),
      'text': 'History',
      'type': ListItemsHome.history
    },
    {
      'image': Image.asset('assets/digital clock.png'),
      'text': 'Friends',
      'type': ListItemsHome.friends,
    },
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

  Future<void> _tryToJoinGame(UserLogIn user, context) async {
    DatabaseReference ref = database.ref('meciuri/${_gameIdFieldController.text}');
    DatabaseEvent databaseEvent = await ref.once();
    DataSnapshot snapshot = databaseEvent.snapshot;

    if (snapshot.value != null){
      user.gameId = _gameIdFieldController.text;
      await ref.update({
        'player2': 'mircea'
      });
      await Navigator.of(context).pushNamed(OwnRouter.multiplayerRoute, arguments: user);
    } else {
      setState(() {
        _gameIDValide = false;
      });
    }
  }

  void _navigationRoute(ListItemsHome type, UserLogIn user, double width, double height) async {
    if(type == ListItemsHome.tournaments){
      await Navigator.of(context).pushNamed(OwnRouter.tournamentsRoute);
    } else if(type == ListItemsHome.adventureMode){
      await Navigator.of(context).pushNamed(OwnRouter.scrollableMapWorldRoute);
    } else if(type == ListItemsHome.multiplayer) {
      user.player1 = true;
      user.gameId = '';
      await Navigator.of(context).pushNamed(OwnRouter.multiplayerRoute, arguments: user);
    } else if(type == ListItemsHome.joinMultiplayer) {
      user.player1 = false;
      user.gameId = '';
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game id'),
            content: Column(
              children: [
                CustomTextField(
                  context: context,
                  width: width * 0.8,
                  height: height * 0.1,
                  textEditingController: _gameIdFieldController,
                  onEditingComplete: (context) => {
                    setState(() {
                      FocusScope.of(context).unfocus();
                    })
                  },
                  onTap: () {
                    setState(() {
                      _gameIDValide = true;
                    });
                  },
                  errorBorder: false,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                if(!_gameIDValide)
                  const CustomTextWidgetError(
                    text: 'Wrong ID',
                    textSize: 14
                  )
              ],
            ),
            actions: [
              CustomButtonBlue(
                width: width * 0.3,
                height: height * 0.1,
                text: 'Join Game',
                textSize: 14,
                onPressed: () => _tryToJoinGame(user, context)
              )
            ],
          );
        }
      );
    } else if(type == ListItemsHome.history) {
      await Navigator.of(context).pushNamed(OwnRouter.historyRoute);
    }
  }

  @override
  void dispose(){
    _scrollViewController.removeListener(() {});
    _scrollViewController.dispose();
    _gameIdFieldController.removeListener(() { });
    _gameIdFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
	  final user = ModalRoute.of(context)!.settings.arguments as UserLogIn;

    FirebaseAuth.instance.currentUser!.isAnonymous ? _dataRow.removeAt(1) : null;

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
                  onPressed: () => _navigationRoute(row['type'], user, width, height),
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