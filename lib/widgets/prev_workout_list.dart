import 'package:fitness_app/models/session.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviousWorkoutList extends StatelessWidget {
  final Session session;
  Color darkPurple = const Color.fromRGBO(57, 53, 81, 1);

  PreviousWorkoutList({Key? key, required this.session}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(session.workoutName,
                      style: GoogleFonts.montserrat(
                          color: darkPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(session.date,
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(213, 214, 220, 1),
                          fontWeight: FontWeight.normal,
                          fontSize: 16)),
                  Text(session.duration,
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(213, 214, 220, 1),
                          fontWeight: FontWeight.normal,
                          fontSize: 16))
                ],
              )
            ])));
  }
}
