import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/models/session.dart';
import 'package:fitness_app/services/db.dart';
import 'package:fitness_app/widgets/prev_workout_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewPrevWorkout extends StatefulWidget {
  final Session session;

  const ViewPrevWorkout({Key? key, required this.session}) : super(key: key);
  @override
  State<ViewPrevWorkout> createState() => _ViewPrevWorkoutState(session);
}

class _ViewPrevWorkoutState extends State<ViewPrevWorkout> {
  final Session session;
  Color darkPurple = const Color.fromRGBO(57, 53, 81, 1);

  _ViewPrevWorkoutState(this.session);

  @override
  Widget build(BuildContext context) {
    Future<List<Exercise>> sessionExercises =
        DB.getSessionExercises(session.id);

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
              onPressed: () async {
                await DB.deleteSession(session.id);
                Navigator.pop(context);
              },
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            session.workoutName.toUpperCase(),
            style: GoogleFonts.montserrat(
                color: darkPurple, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
          initialData: const [],
          future: sessionExercises,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            return ListView(
                children: snapshot.data!
                    .map((exercise) => PrevWorkoutTile(
                          exercise: exercise,
                          workout_id: session.workoutId,
                          session_id: session.id,
                        ))
                    .toList());
          },
        ));
  }
}
