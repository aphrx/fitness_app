import 'package:fitness_app/widgets/workout_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutSession extends StatefulWidget {
  @override
  State<WorkoutSession> createState() => _WorkoutSessionState();
}

class _WorkoutSessionState extends State<WorkoutSession> {
  Color darkPurple = const Color.fromRGBO(57, 53, 81, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 245, 249, 1),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(57, 53, 81, 1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "BACK",
          style: GoogleFonts.montserrat(
              color: darkPurple, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          WorkoutTile(),
          WorkoutTile(),
          WorkoutTile(),
          const SizedBox(
            height: 20,
          ),
          Container(
              margin: const EdgeInsets.all(15),
              child: RawMaterialButton(
                padding: const EdgeInsets.fromLTRB(130, 20, 130, 20),
                elevation: 5,
                fillColor: Colors.green,
                onPressed: () => Navigator.pop(context),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "COMPLETE",
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
