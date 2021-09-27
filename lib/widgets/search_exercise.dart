import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchExercise extends StatelessWidget {
  Color darkPurple = const Color.fromRGBO(57, 53, 81, 1);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Deadlift",
                  style: GoogleFonts.montserrat(
                      color: darkPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Back",
                  style: GoogleFonts.montserrat(
                      color: const Color.fromRGBO(213, 214, 220, 1),
                      fontWeight: FontWeight.normal,
                      fontSize: 16))
            ],
          )
        ]));
  }
}
