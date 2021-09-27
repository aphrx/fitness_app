import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewWorkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(37, 34, 53, 1),
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10)),
              onPressed: () {},
              child: Text(
                "Start Workout",
                style: GoogleFonts.montserrat(),
              ))
        ]));
  }
}
