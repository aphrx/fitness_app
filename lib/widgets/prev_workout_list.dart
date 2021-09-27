import 'package:fitness_app/screens/view_workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviousWorkoutList extends StatelessWidget {
  Color darkPurple = const Color.fromRGBO(57, 53, 81, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: RawMaterialButton(
            padding: const EdgeInsets.all(20),
            fillColor: Colors.white,
            elevation: 0,
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewWorkout()),
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Back",
                      style: GoogleFonts.montserrat(
                          color: darkPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("21 Sept 2021",
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(213, 214, 220, 1),
                          fontWeight: FontWeight.normal,
                          fontSize: 16))
                ],
              )
            ])));
  }
}
