// ignore_for_file: no_logic_in_create_state, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:make_a_word/main.dart';
// import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoadingScreen extends StatefulWidget {
  int no_of_players = 2;
  LoadingScreen({required this.no_of_players});
  @override
  _LoadingScreenState createState() => _LoadingScreenState(no_of_players: no_of_players);
}

class _LoadingScreenState extends State<LoadingScreen> {
  int no_of_players=2;
  _LoadingScreenState({required this.no_of_players});
  @override
  void initState() {
    super.initState();
    // Simulate a delay to display the splash screen
    Future.delayed(const Duration(seconds: 5), () {
      Get.off(() {
        return Homepage(no_of_players: no_of_players,);
      }, transition: Transition.fade, duration: const Duration(seconds: 3));
    });
  }

  // late final AnimationController _cont = AnimationController(
  //     duration: Duration(milliseconds: 500),
  //     // value: 0.5,
  //     vsync: this);

  // late final Animation<double> _animation =
  //     CurvedAnimation(parent: _cont, curve: Curves.easeIn);

  // Route _createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => Homepage(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  // const begin = Offset(0.0, 1.0);
  // const end = Offset.zero;
  // final tween = Tween(begin: begin, end: end);
  // final offsetAnimation = animation.drive(tween);
  // const curve = Curves.ease;

  // var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return FadeTransition(
  //         opacity: _animation,
  //         child: child,
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width / 2,
                child: Image.asset(
                    "assets/lastLoading.gif")), // Specify your animation file here
            const SizedBox(height: 20),
            const Text(
              'Scrabble',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
