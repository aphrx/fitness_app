import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrevWorkoutTile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrevWorkoutTileState();
}

class _PrevWorkoutTileState extends State<PrevWorkoutTile> {
  Color darkPurple = const Color.fromRGBO(24, 22, 33, 1);

  int reps = 4;
  double weight = 44.5;
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
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("1",
                    style: GoogleFonts.montserrat(
                        color: darkPurple, fontSize: 16)),
                Text("4 reps",
                    style: GoogleFonts.montserrat(
                        color: darkPurple, fontSize: 16)),
                Text("55 lbs",
                    style:
                        GoogleFonts.montserrat(color: darkPurple, fontSize: 16))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("2",
                    style: GoogleFonts.montserrat(
                        color: darkPurple, fontSize: 16)),
                Text("3 reps",
                    style: GoogleFonts.montserrat(
                        color: darkPurple, fontSize: 16)),
                Text("60 lbs",
                    style:
                        GoogleFonts.montserrat(color: darkPurple, fontSize: 16))
              ],
            ),
          ),
        ]));
  }
}
