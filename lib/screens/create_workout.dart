import 'package:fitness_app/screens/add_exercise.dart';
import 'package:fitness_app/widgets/search_exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateWorkout extends StatefulWidget {
  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
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
          "NEW WORKOUT",
          style: GoogleFonts.montserrat(
              color: darkPurple, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: TextField(
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(color: darkPurple),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'WORKOUT NAME'),
            ),
          ),
          SearchExercise(),
          SearchExercise(),
          SearchExercise(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tooltip: 'Increment',
        extendedPadding: const EdgeInsets.all(110),
        icon: const Icon(Icons.plus_one),
        backgroundColor: darkPurple,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExercise()),
          );
        },
        label: Text(
          "ADD EXERCISE",
          style: GoogleFonts.montserrat(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
