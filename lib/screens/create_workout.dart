import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/models/workout.dart';
import 'package:fitness_app/screens/add_exercise.dart';
import 'package:fitness_app/widgets/search_exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitness_app/services/db.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateWorkout extends StatefulWidget {
  final String workoutId;

  const CreateWorkout({Key? key, required this.workoutId}) : super(key: key);
  @override
  State<CreateWorkout> createState() => _CreateWorkoutState(workoutId);
}

class _CreateWorkoutState extends State<CreateWorkout> {
  final String workoutId;

  Color darkPurple = const Color.fromRGBO(57, 53, 81, 1);
  String workoutName = "";
  int exerciseCounter = 0;

  _CreateWorkoutState(this.workoutId);

  @override
  Widget build(BuildContext context) {
    Future<List<Exercise>> workoutExercises = DB.getWorkoutExercises(workoutId);
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
        actions: [
          IconButton(
              onPressed: () async {
                exerciseCounter++;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddExercise(workoutId: workoutId)),
                ).then((_) => setState(() {
                      workoutExercises = DB.getWorkoutExercises(workoutId);
                    }));
              },
              icon: Icon(Icons.add, color: darkPurple))
        ],
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
              onChanged: (value) {
                workoutName = value;
              },
            ),
          ),
          FutureBuilder(
            initialData: const [],
            future: workoutExercises,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              return Column(
                  children: snapshot.data!
                      .map((item) =>
                          SearchExercise(exercise: item, workoutId: workoutId))
                      .toList());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tooltip: 'Increment',
        extendedPadding: const EdgeInsets.all(90),
        icon: const Icon(Icons.check),
        backgroundColor: darkPurple,
        onPressed: () async {
          if (workoutName.isNotEmpty && exerciseCounter > 0) {
            Workout workout = Workout(
                id: workoutId,
                name: workoutName,
                date: "date",
                duration: "duration");
            await DB.insertWorkout(workout);
            Navigator.pop(context);
          }
        },
        label: Text(
          "CREATE WORKOUT",
          style: GoogleFonts.montserrat(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
