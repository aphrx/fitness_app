import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/models/workout.dart';
import 'package:fitness_app/services/db.dart';
import 'package:fitness_app/widgets/search_exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewWorkout extends StatefulWidget {
  final Workout workout;

  const ViewWorkout({Key? key, required this.workout}) : super(key: key);
  @override
  State<ViewWorkout> createState() => _ViewWorkoutState(workout);
}

class _ViewWorkoutState extends State<ViewWorkout> {
  final Workout workout;
  _ViewWorkoutState(this.workout);

  Color darkPurple = const Color.fromRGBO(57, 53, 81, 1);

  @override
  Widget build(BuildContext context) {
    Future<List<Exercise>> workoutExercises =
        DB.getWorkoutExercises(workout.id);

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
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: darkPurple),
            onPressed: () {
              DB.deleteWorkouts(workout.id);
              Navigator.pop(context);
            },
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          workout.name.toUpperCase(),
          style: GoogleFonts.montserrat(
              color: darkPurple, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(physics: ClampingScrollPhysics(), children: [
        FutureBuilder(
          initialData: const [],
          future: workoutExercises,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            return Column(
                children: snapshot.data!
                    .map((item) =>
                        SearchExercise(exercise: item, workoutId: workout.id))
                    .toList());
          },
        ),
      ]),
    );
  }
}
