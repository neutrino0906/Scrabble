import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/cell.dart';
import 'dart:math';

// ignore: must_be_immutable
class PlayingGrid extends StatefulWidget {
  // const PlayingGrid({super.key});

  var highlighted = [];
  Map<int, String?> mp = {};

  PlayingGrid({required this.highlighted, required this.mp});

  @override
  State<PlayingGrid> createState() => _PlayingGridState();
}

class _PlayingGridState extends State<PlayingGrid>
    with TickerProviderStateMixin {
  final Color _primaryColor = const Color.fromARGB(255, 218, 218, 218);

  // final Color _selectedColor = const Color.fromARGB(255, 255, 255, 0);

  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width,
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 100,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 10),
          itemBuilder: (ctx, i) {
            return widget.mp[i] != null
                ? Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 87, 179, 255),
                  ),
                    margin: const EdgeInsets.all(1),
                    child: Stack(
                      children: [
                        // Text('$i'),
                        Center(
                          child: Text(
                            widget.mp[i] != null ? '${widget.mp[i]}' : " ",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 0, 87, 158)),
                          ),
                        ),
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      widget.highlighted.clear();
                      widget.highlighted.add(i);
                      if (_status == AnimationStatus.dismissed) {
                        _controller.forward();
                      } else {
                        _controller.reverse();
                      }

                      // print(highlighted);
                      return Provider.of<Single_cell>(context, listen: false)
                          .changeSelected(
                              !Provider.of<Single_cell>(context, listen: false)
                                  .selected);
                    },
                    child: widget.highlighted.contains(i)
                        ? Transform(
                            alignment: FractionalOffset.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.0015)
                              ..rotateY(pi * _animation.value),
                            child: Card(
                              child: _animation.value <= 0.5
                                  ? Container(
                                      color: Colors.yellow,
                                      // width: 240,
                                      // height: 300,
                                      child: Center(
                                          child: Text(
                                        widget.mp[i] != null
                                            ? '${widget.mp[i]}'
                                            : " ",
                                        style: const TextStyle(
                                            fontSize: 25, color: Colors.black),
                                      )))
                                  : Transform.scale(
                                      scaleX: -1,
                                      child: Container(
                                          color: Colors.yellow,
                                          // width: 240,
                                          // height: 300,
                                          child: Center(
                                              child: Text(
                                            widget.mp[i] != null
                                                ? '${widget.mp[i]}'
                                                : " ",
                                            style: const TextStyle(
                                                fontSize: 25,
                                                color: Colors.black),
                                          ))),
                                    ),
                            ),
                          )
                        : Container(
                                margin: const EdgeInsets.all(1),
                                color: _primaryColor,
                                child: const Text(" ")),
                  );
          }),
    );
  }
}
