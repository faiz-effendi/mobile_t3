import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late Stopwatch stopwatch;
  late Timer t;
  List<String> flags = []; // List to hold the flags
  bool isRunning = false;

  void handleStartStop() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }
    setState(() {
      isRunning = stopwatch.isRunning;
    });
  }

  String returnFormattedText() {
    var milli = stopwatch.elapsed.inMilliseconds;

    String milliseconds = (milli % 1000).toString().padLeft(3, "0"); // for milliseconds
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0"); // for seconds
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0"); // for minutes

    return "$minutes:$seconds:$milliseconds";
  }

  // Function to add flag
  void addFlag() {
    var milli = stopwatch.elapsed.inMilliseconds;
    String flagTime = returnFormattedText();
    setState(() {
      flags.add("Flag at $flagTime");
    });
  }

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    t = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {
                  handleStartStop();
                },
                padding: EdgeInsets.all(0),
                child: Container(
                  height: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xff0395eb),
                      width: 4,
                    ),
                  ),
                  child: Text(
                    returnFormattedText(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              CupertinoButton(
                onPressed: () {
                  stopwatch.reset();
                  setState(() {
                    flags.clear(); // Clear flags on reset
                  });
                },
                padding: EdgeInsets.all(0),
                child: Text(
                  "Reset",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CupertinoButton(
                onPressed: () {
                  if (isRunning) {
                    addFlag();
                  }
                },
                padding: EdgeInsets.all(0),
                child: Text(
                  "Flag",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Display list of flags
              if (flags.isNotEmpty) 
                Column(
                  children: flags.map((flag) => Text(flag)).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
