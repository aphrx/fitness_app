import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/models/workout_exercise_relation.dart';
import 'package:fitness_app/services/db.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class SearchExercise extends StatelessWidget {
  final Exercise exercise;
  final String workoutId;

  var uuid = const Uuid();

  Color darkPurple = const Color.fromRGBO(57, 53, 81, 1);

  SearchExercise({Key? key, required this.exercise, required this.workoutId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: RawMaterialButton(
            padding: const EdgeInsets.all(20),
            fillColor: Colors.white,
            elevation: 0,
            onPressed: () async {
              WorkoutExerciseRelation wer = WorkoutExerciseRelation(
                  id: uuid.v1().toString(),
                  workoutId: workoutId,
                  exerciseId: exercise.id);
              await DB.insertWorkoutExerciseRelation(wer);
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(exercise.name,
                      style: GoogleFonts.montserrat(
                          color: darkPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 16))
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exercise.primaryMuscle,
                      style: GoogleFonts.montserrat(
                          color: const Color.fromRGBO(213, 214, 220, 1),
                          fontWeight: FontWeight.normal,
                          fontSize: 16))
                ],
              )
            ])));
  }
}
