import 'package:fitness_app/models/session.dart';
import 'package:fitness_app/models/workout.dart';
import 'package:fitness_app/screens/create_workout.dart';
import 'package:fitness_app/screens/view_prev_workout.dart';
import 'package:fitness_app/screens/view_workout.dart';
import 'package:fitness_app/screens/workout_session.dart';
import 'package:fitness_app/services/db.dart';
import 'package:fitness_app/widgets/prev_workout_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Workout>> myWorkouts = DB.getWorkouts();
  Future<List<Session>> prevSessions = DB.getSessions();

  var uuid = const Uuid();
  Color darkPurple = const Color.fromRGBO(57, 53, 81, 1);

  Widget pastWorkoutTitle(int count) {
    if (count == 0) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 30),
        Container(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: Text(
            "PAST WORKOUTS",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: darkPurple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 245, 249, 1),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        // leading: const Icon(
        //   Icons.menu,
        //   color: Color.fromRGBO(57, 53, 81, 1),
        // ),
        actions: [
          IconButton(
              onPressed: () {
                String workoutId = uuid.v1().toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CreateWorkout(workoutId: workoutId)),
                ).then((_) => setState(() {
                      myWorkouts = DB.getWorkouts();
                    }));
              },
              icon: Icon(Icons.add, color: darkPurple))
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "MY WORKOUTS",
          style: GoogleFonts.montserrat(
              color: darkPurple, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(physics: ClampingScrollPhysics(), children: [
        SizedBox(
            height: 250,
            child: FutureBuilder(
              initialData: const [],
              future: myWorkouts,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return ListView.builder(
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      Workout workout = snapshot.data[index];
                      return RawMaterialButton(
                          onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewWorkout(
                                          workout: workout,
                                        )),
                              ).then((_) => setState(() {
                                    myWorkouts = DB.getWorkouts();
                                  })),
                          child: Container(
                              height: 250,
                              width: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: darkPurple),
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(child: Container()),
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(children: [
                                          Text(
                                            workout.name,
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ])),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                            padding: const EdgeInsets.fromLTRB(
                                                60, 10, 60, 10)),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WorkoutSession(
                                                      workout: workout,
                                                    )),
                                          ).then((value) => setState(() {
                                                prevSessions = DB.getSessions();
                                              }));
                                        },
                                        child: Text(
                                          "START",
                                          style: GoogleFonts.montserrat(
                                              color: darkPurple),
                                        ))
                                  ])));
                    });
              },
            )),
        FutureBuilder(
          initialData: const [],
          future: prevSessions,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            return Column(children: [
              pastWorkoutTitle(snapshot.data!.length),
              Column(
                  children: snapshot.data!
                      .map((session) => RawMaterialButton(
                          elevation: 0,
                          onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ViewPrevWorkout(session: session)),
                              ).then((value) => setState(() {
                                    prevSessions = DB.getSessions();
                                  })),
                          child: PreviousWorkoutList(session: session)))
                      .toList())
            ]);
          },
        ),
        const SizedBox(height: 20)
      ]),
    );
  }
}
