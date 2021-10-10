import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/models/exercise_entry.dart';
import 'package:fitness_app/services/db.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrevWorkoutTile extends StatefulWidget {
  final Exercise exercise;
  final String workout_id;
  final String session_id;

  const PrevWorkoutTile(
      {Key? key,
      required this.exercise,
      required this.workout_id,
      required this.session_id})
      : super(key: key);
  @override
  State<StatefulWidget> createState() =>
      _PrevWorkoutTileState(exercise, workout_id, session_id);
}

class _PrevWorkoutTileState extends State<PrevWorkoutTile> {
  final Exercise exercise;
  final String workout_id;
  final String session_id;
  Color darkPurple = const Color.fromRGBO(24, 22, 33, 1);

  int reps = 4;
  double weight = 44.5;

  _PrevWorkoutTileState(this.exercise, this.workout_id, this.session_id);

  Widget rowController(var item, int i) {
    if (exercise.trackingOption == 1) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(i.toString(),
            style: GoogleFonts.montserrat(color: darkPurple, fontSize: 16)),
        Text(item.reps.toString() + " reps",
            style: GoogleFonts.montserrat(color: darkPurple, fontSize: 16)),
        Text(item.weights.toString() + " lbs",
            style: GoogleFonts.montserrat(color: darkPurple, fontSize: 16))
      ]);
    } else if (exercise.trackingOption == 2) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(i.toString(),
            style: GoogleFonts.montserrat(color: darkPurple, fontSize: 16)),
        Text(item.reps.toString() + " reps",
            style: GoogleFonts.montserrat(color: darkPurple, fontSize: 16))
      ]);
    } else if (exercise.trackingOption == 3) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(i.toString(),
            style: GoogleFonts.montserrat(color: darkPurple, fontSize: 16)),
        Text(item.duration.toString(),
            style: GoogleFonts.montserrat(color: darkPurple, fontSize: 16))
      ]);
    }
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(i.toString(),
          style: GoogleFonts.montserrat(color: darkPurple, fontSize: 16)),
      Text("Completed",
          style: GoogleFonts.montserrat(color: darkPurple, fontSize: 16))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Future<List<ExerciseEntry>> exerciseReps =
        DB.getExerciseEntryRep(workout_id, exercise.id, session_id);
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
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: FutureBuilder(
                initialData: const [],
                future: exerciseReps,
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  return Column(
                      children: snapshot.data!
                          .map((item) => Container(
                              padding: const EdgeInsets.all(10),
                              child: rowController(
                                  item, snapshot.data!.indexOf(item) + 1)))
                          .toList());
                }),
          ),
        ]));
  }
}
