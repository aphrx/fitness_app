import 'package:fitness_app/models/workout.dart';
import 'package:fitness_app/screens/workout_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutList extends StatelessWidget {
  final Workout workout;
  Color darkPurple = const Color.fromRGBO(37, 34, 53, 1);

  WorkoutList({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: darkPurple),
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        padding: const EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Expanded(child: Container()),
          Container(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Text(
                  workout.name,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  workout.duration,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
              ])),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: const EdgeInsets.fromLTRB(60, 10, 60, 10)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WorkoutSession(
                            workout: workout,
                          )),
                );
              },
              child: Text(
                "START",
                style: GoogleFonts.montserrat(color: darkPurple),
              ))
        ]));
  }
}
