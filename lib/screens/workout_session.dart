import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/models/session.dart';
import 'package:fitness_app/models/workout.dart';
import 'package:fitness_app/screens/add_exercise.dart';
import 'package:fitness_app/services/db.dart';
import 'package:fitness_app/widgets/workout_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:uuid/uuid.dart';

class WorkoutSession extends StatefulWidget {
  final Workout workout;

  const WorkoutSession({Key? key, required this.workout}) : super(key: key);
  @override
  State<WorkoutSession> createState() => _WorkoutSessionState(workout);
}

class _WorkoutSessionState extends State<WorkoutSession> {
  final Workout workout;
  Color darkPurple = const Color.fromRGBO(57, 53, 81, 1);
  var uuid = const Uuid();
  String session_id = "";
  int minutes = 0;
  _WorkoutSessionState(this.workout);
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    session_id = uuid.v1();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  String getDuration(int minutes) {
    if (minutes < 60) {
      return minutes.toString() + " mins";
    }
    return (minutes / 60).toString() +
        " h " +
        (minutes % 60).toString() +
        " mins";
  }

  @override
  Widget build(BuildContext context) {
    String time = "";
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
            icon: const Icon(
              Icons.add,
              color: Color.fromRGBO(57, 53, 81, 1),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddExercise(workoutId: workout.id)),
              ).then((_) => setState(() {
                    workoutExercises = DB.getWorkoutExercises(workout.id);
                  }));
            },
          ),
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
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Center(
              child: Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
                  child: StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: 0,
                      builder: (context, snap) {
                        final value = snap.data;
                        minutes = (StopWatchTimer.getRawMinute(value!));
                        time = (minutes.toString()) +
                            ":" +
                            StopWatchTimer.getDisplayTimeSecond(value);
                        return Text(
                          time,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(
                              color: darkPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 90),
                        );
                      }))),
          FutureBuilder(
            initialData: const [],
            future: workoutExercises,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              return Column(
                  children: snapshot.data!
                      .map((item) => WorkoutTile(
                          session: session_id,
                          exercise: item,
                          workout: workout))
                      .toList());
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              margin: const EdgeInsets.all(15),
              child: RawMaterialButton(
                padding: const EdgeInsets.fromLTRB(130, 20, 130, 20),
                elevation: 5,
                fillColor: Colors.green,
                onPressed: () {
                  Session s = Session(
                      id: session_id,
                      workoutId: workout.id,
                      workoutName: workout.name,
                      date: DateFormat('yyyy MMM dd').format(DateTime.now()),
                      duration: getDuration(minutes));
                  DB.insertSession(s);
                  Navigator.pop(context);
                },
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
