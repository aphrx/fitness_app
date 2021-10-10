import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/models/exercise_entry.dart';
import 'package:fitness_app/models/workout.dart';
import 'package:fitness_app/services/db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:uuid/uuid.dart';

class WorkoutTile extends StatefulWidget {
  final Exercise exercise;
  final Workout workout;
  final String session;

  const WorkoutTile(
      {Key? key,
      required this.exercise,
      required this.workout,
      required this.session})
      : super(key: key);
  @override
  State<StatefulWidget> createState() =>
      _WorkoutTileState(exercise, workout, session);
}

class _WorkoutTileState extends State<WorkoutTile> {
  final Exercise exercise;
  final Workout workout;
  final String session;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  Color darkPurple = const Color.fromRGBO(24, 22, 33, 1);
  var uuid = const Uuid();
  int reps = 4;
  double weight = 44.5;

  _WorkoutTileState(this.exercise, this.workout, this.session);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  Widget repWeightBottomSheet(setState) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: darkPurple,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "REPS",
            textAlign: TextAlign.left,
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      reps -= 1;
                    });
                  },
                  icon: const Icon(Icons.remove, color: Colors.white)),
              Text(
                reps.toString(),
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 90),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    reps += 1;
                  });
                },
                icon: const Icon(Icons.add, color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "WEIGHT",
            textAlign: TextAlign.left,
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      weight -= 0.5;
                    });
                  },
                  icon: const Icon(Icons.remove, color: Colors.white)),
              Text(
                weight.toStringAsFixed(1),
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 90),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    weight += 0.5;
                  });
                },
                icon: const Icon(Icons.add, color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 20),
          RawMaterialButton(
            padding: const EdgeInsets.fromLTRB(130, 20, 130, 20),
            elevation: 5,
            fillColor: Colors.white,
            onPressed: () {
              ExerciseEntry e = ExerciseEntry(
                  id: uuid.v1(),
                  sessionId: session,
                  workoutId: workout.id,
                  exerciseId: exercise.id,
                  reps: reps,
                  weights: weight,
                  duration: "N/A",
                  customText: "N/A",
                  performedTime: "N/A");
              DB.insertExerciseEntry(e);
              Navigator.pop(context);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              "ADD ENTRY",
              style: GoogleFonts.montserrat(color: darkPurple),
            ),
          )
        ],
      ),
    );
  }

  Widget repBottomSheet(setState) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: darkPurple,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "REPS",
            textAlign: TextAlign.left,
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      reps -= 1;
                    });
                  },
                  icon: const Icon(Icons.remove, color: Colors.white)),
              Text(
                reps.toString(),
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 90),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    reps += 1;
                  });
                },
                icon: const Icon(Icons.add, color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 20),
          RawMaterialButton(
            padding: const EdgeInsets.fromLTRB(130, 20, 130, 20),
            elevation: 5,
            fillColor: Colors.white,
            onPressed: () {
              ExerciseEntry e = ExerciseEntry(
                  id: uuid.v1(),
                  sessionId: session,
                  workoutId: workout.id,
                  exerciseId: exercise.id,
                  reps: reps,
                  weights: 0,
                  duration: "N/A",
                  customText: "N/A",
                  performedTime: "N/A");
              DB.insertExerciseEntry(e);
              Navigator.pop(context);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              "ADD ENTRY",
              style: GoogleFonts.montserrat(color: darkPurple),
            ),
          )
        ],
      ),
    );
  }

  Widget noneBottomSheet(setState) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: darkPurple,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "ENTRY",
            textAlign: TextAlign.left,
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 20),
          RawMaterialButton(
            padding: const EdgeInsets.fromLTRB(130, 20, 130, 20),
            elevation: 5,
            fillColor: Colors.white,
            onPressed: () {
              ExerciseEntry e = ExerciseEntry(
                  id: uuid.v1(),
                  sessionId: session,
                  workoutId: workout.id,
                  exerciseId: exercise.id,
                  reps: reps,
                  weights: 0,
                  duration: "N/A",
                  customText: "N/A",
                  performedTime: "N/A");
              DB.insertExerciseEntry(e);
              Navigator.pop(context);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              "ADD ENTRY",
              style: GoogleFonts.montserrat(color: darkPurple),
            ),
          )
        ],
      ),
    );
  }

  Widget durationBottomSheet(setState) {
    String time = "";
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: darkPurple,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "DURATION",
            textAlign: TextAlign.left,
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: 0,
              builder: (context, snap) {
                final value = snap.data;
                time = StopWatchTimer.getDisplayTimeMinute(value!) +
                    ":" +
                    StopWatchTimer.getDisplayTimeSecond(value);
                return Text(
                  time,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 90),
                );
              }),
          const SizedBox(height: 20),
          RawMaterialButton(
            padding: const EdgeInsets.fromLTRB(130, 20, 130, 20),
            elevation: 5,
            fillColor: Colors.white,
            onPressed: () {
              ExerciseEntry e = ExerciseEntry(
                  id: uuid.v1(),
                  sessionId: session,
                  workoutId: workout.id,
                  exerciseId: exercise.id,
                  reps: reps,
                  weights: 0,
                  duration: time,
                  customText: "N/A",
                  performedTime: "N/A");
              DB.insertExerciseEntry(e);
              Navigator.pop(context);
              _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              "ADD ENTRY",
              style: GoogleFonts.montserrat(color: darkPurple),
            ),
          )
        ],
      ),
    );
  }

  Widget sheetController(setState) {
    if (exercise.trackingOption == 0) {
      return noneBottomSheet(setState);
    } else if (exercise.trackingOption == 1) {
      return repWeightBottomSheet(setState);
    } else if (exercise.trackingOption == 2) {
      return repBottomSheet(setState);
    } else if (exercise.trackingOption == 3) {
      return durationBottomSheet(setState);
    }
    return Container();
  }

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
        DB.getExerciseEntryRep(workout.id, exercise.id, session);

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
                initialData: [],
                future: exerciseReps,
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  return Column(
                      children: snapshot.data!
                          .map((item) => Container(
                              padding: EdgeInsets.all(10),
                              child: rowController(
                                  item, snapshot.data!.indexOf(item) + 1)))
                          .toList());
                }),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(37, 34, 53, 1),
                  padding: const EdgeInsets.fromLTRB(120, 10, 119, 10)),
              onPressed: () async {
                final PersistentBottomSheetController bottomSheetController =
                    showBottomSheet(
                        context: context,
                        builder: (context) => StatefulBuilder(
                            builder: (BuildContext c, setState) => ListView(
                                shrinkWrap: true,
                                children: [sheetController(setState)])));
                await bottomSheetController.closed;
                setState(() {
                  exerciseReps =
                      DB.getExerciseEntryRep(workout.id, exercise.id, session);
                });
              },
              child: Text(
                "ADD ENTRY",
                style: GoogleFonts.montserrat(),
              )),
        ]));
  }
}
