import 'package:fitness_app/screens/create_workout.dart';
import 'package:fitness_app/widgets/prev_workout_list.dart';
import 'package:fitness_app/widgets/workout_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color darkPurple = const Color.fromRGBO(57, 53, 81, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 245, 249, 1),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: const Icon(
          Icons.menu,
          color: Color.fromRGBO(57, 53, 81, 1),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateWorkout()),
                );
              },
              icon: Icon(Icons.add, color: darkPurple))
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "MY WORKOUTS",
          style: GoogleFonts.montserrat(
              color: darkPurple, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(children: [
        SizedBox(
          height: 250,
          child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return WorkoutList();
              }),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Text(
                "PAST WORKOUTS",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: darkPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            PreviousWorkoutList(),
            PreviousWorkoutList(),
            PreviousWorkoutList(),
          ],
        ),
      ]),
    );
  }
}
