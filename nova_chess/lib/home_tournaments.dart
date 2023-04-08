// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:nova_chess/custom_widgets/background_widget.dart';
// import 'package:nova_chess/custom_widgets/custom_app_bar.dart';
// import 'package:nova_chess/custom_widgets/custom_button_blue.dart';
// import 'package:nova_chess/custom_widgets/custom_text_widget.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class HomeTournaments extends StatefulWidget{
//   const HomeTournaments({super.key});
//
//   @override
//   State<HomeTournaments> createState() => _HomeTournamentsState();
//
// }
//
// class _HomeTournamentsState extends State<HomeTournaments>{
//   bool _notifyUser = false;
//   final ScrollController _scrollViewController = ScrollController();
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   Future<void> _customInit() async{
//     final pref = await  SharedPreferences.getInstance();
//     _notifyUser = pref.getBool('notify_user') ?? false;
//   }
//
//   Future<void> _onPressedNotify() async{
//     setState(() {
//       _notifyUser = true;
//     });
//
//     final pref = await SharedPreferences.getInstance();
//     await pref.setBool('notify_user', _notifyUser);
//   }
//
//   @override
//   void initState(){
//     super.initState();
//     _customInit();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double width = MediaQuery.of(context).size.width;
//     final double height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       key: scaffoldKey,
//         backgroundColor: const Color.fromARGB(255, 19, 10, 51),
//         appBar: CustomAppBar(
//         showAppbar: true,
//         scaffoldKey: scaffoldKey,
//         width: width,
//         height: height
//       ),
//       endDrawer: Drawer(
//         child: Container(),
//       ),
//       body: BackgroundWidget(
//         height: height,
//         width: width,
//         child: SingleChildScrollView(
//           controller: _scrollViewController,
//           child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     CustomTextWidgetWhite(
//                       text: 'Your next ',
//                       textSize: 20
//                     ),
//                     CustomTextWidgetWhite(
//                       text: 'event',
//                       textSize: 20,
//                       fontWeight: FontWeight.w700,
//                     ),
//                     CustomTextWidgetWhite(
//                       text: ' starts in:',
//                       textSize: 20
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.025,
//                 ),
//                 Stack(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircularCountDownTimer(
//                           duration: 11647,
//                           date: '12 Mar 2023',
//                           fillColor: const Color.fromARGB(255, 86, 100, 172),
//                           height: width* 0.4,
//                           ringColor: const Color.fromARGB(255, 28, 24, 45),
//                           width: height * 0.4,
//                           isReverse: true,
//                           isReverseAnimation: true,
//                           strokeWidth: 6,
//                           strokeCap: StrokeCap.round,
//                           textFormat: CountdownTextFormat.HH_MM_SS,
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Container(
//                           width: width * 0.4,
//                           height: width * 0.4,
//                           alignment: Alignment.center,
//                           child: Image.asset(
//                             'assets/right_arrow.png',
//                             width: width * 0.05,
//                             height: height * 0.05,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.043,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         Container(
//                           width: width * 0.3,
//                           height: width * 0.3,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(19.63),
//                             color: const Color.fromARGB(25, 144, 162, 255).withOpacity(0.03),
//                           ),
//                           child: Container(
//                             padding: EdgeInsets.fromLTRB(
//                               width * 0.076,
//                               height * 0.038,
//                               width * 0.076,
//                               height * 0.038
//                             ),
//                             child: Image.asset('assets/trophy.png'),
//                           ),
//                         ),
//                         const CustomTextWidgetWhite(
//                           text: 'Tournaments',
//                           textSize: 18,
//                         )
//                       ],
//                     ),
//                     SizedBox(
//                       width: width * 0.13,
//                     ),
//                     Column(
//                       children: [
//                         Container(
//                           width: width * 0.3,
//                           height: width * 0.3,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(19.63),
//                             color: const Color.fromARGB(25, 144, 162, 255).withOpacity(0.03),
//                           ),
//                           child: Image.asset('assets/payment.png'),
//                         ),
//                         const CustomTextWidgetWhite(
//                           text: 'Payments',
//                           textSize: 18
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: height * 0.061,
//                 ),
//                 Container(
//                   width: width,
//                   height: height * 0.27,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: const Color.fromARGB(25, 144, 162, 255).withOpacity(0.03)
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const CustomTextWidgetWhite(
//                         text: 'NEW FEATURES',
//                         textSize: 25,
//                         fontWeight: FontWeight.w700,
//                         fontFamily: 'Sarabun',
//                       ),
//                       const CustomTextWidgetWhite(
//                         text: 'COMING SOON',
//                         textSize: 36,
//                         fontWeight: FontWeight.w800,
//                         fontFamily: 'Sarabun',
//                       ),
//                       SizedBox(
//                         height: height * 0.024,
//                       ),
//                       if (_notifyUser)
//                         Container(
//                           padding: const EdgeInsets.fromLTRB(11, 4, 12, 5),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5.25),
//                             border: Border.all(
//                               color: const Color.fromARGB(255, 255, 255, 255)
//                             )
//                           ),
//                           child: const CustomTextWidgetWhite(
//                             text: 'We will keep you posted!',
//                             textSize: 20,
//                           ),
//                         )
//                       else
//                         CustomButtonBlue(
//                           width: width * 0.38,
//                           height: height * 0.046,
//                           text: 'Notify me!',
//                           textSize: 20,
//                           onPressed: _onPressedNotify,
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//     );
//   }
//
// }