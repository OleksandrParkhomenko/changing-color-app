import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _random = Random();
  final _userNameController = TextEditingController();
  final _formFadeDuration = Duration(milliseconds: 200);
  final _containerAnimationDuration = Duration(milliseconds: 1500);
  final _colorChangeDuration = Duration(milliseconds: 400);

  bool _formIsHidden = false;
  Color _color = Colors.indigo;
  String _userName;

  _getRandomColor() {
    return Color.fromRGBO(_random.nextInt(256), _random.nextInt(256),
        _random.nextInt(256), _random.nextDouble());
  }

  void changeColor() {
    setState(() {
      _color = _getRandomColor();
    });
  }

  void _getUserName() {
    setState(() {
      _userName = _userNameController.text;
      _userNameController.clear();
      _formIsHidden = true;
    });
  }

  void _reset() {
    setState(() {
      _formIsHidden = false;
      _userName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _formIsHidden ? changeColor : null,
        onDoubleTap: _formIsHidden ? _reset : null,
        child: AnimatedContainer(
          color: _color,
          duration: _colorChangeDuration,
          child: Container(
            alignment: Alignment.center,
            child: AnimatedContainer(
                width: _formIsHidden
                    ? MediaQuery.of(context).size.width * 0.8
                    : MediaQuery.of(context).size.width,
                height: _formIsHidden
                    ? MediaQuery.of(context).size.height * 0.6
                    : MediaQuery.of(context).size.height,
                color: Colors.white60,
                duration: _containerAnimationDuration,
                curve: Curves.fastOutSlowIn,
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      AnimatedOpacity(
                        duration: _formFadeDuration,
                        opacity: _formIsHidden ? 0.0 : 1.0,
                        child: Text(
                          "Welcome!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 0.0,
                                  color: Colors.black12,
                                  offset: Offset(2.0, 3.0),
                                ),
                              ]),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: AnimatedOpacity(
                          duration: _formFadeDuration,
                          opacity: _formIsHidden ? 1.0 : 0.0,
                          child: Text(
                            "Hey there, " +
                                (_userName != null && _userName != ""
                                    ? "$_userName!"
                                    : "anonymous :)") +
                                "\nTap the screen to change color." +
                                "\nDouble tap to reset.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 0.0,
                                    color: Colors.black12,
                                    offset: Offset(2.0, 3.0),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Flexible(
                        child: AnimatedOpacity(
                          duration: _formFadeDuration,
                          opacity: _formIsHidden ? 0.0 : 1.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              enabled: !_formIsHidden,
                              cursorColor: _color,
                              controller: _userNameController,
                              decoration: InputDecoration(
                                hintText: 'Enter your name',
                                hintStyle: TextStyle(color: _color),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        duration: _formFadeDuration,
                        opacity: _formIsHidden ? 0.0 : 1.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: _color,
                            onPrimary: Colors.white,
                          ),
                          child: Text(
                            "Let's start!",
                          ),
                          onPressed: _formIsHidden ? null : _getUserName,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
