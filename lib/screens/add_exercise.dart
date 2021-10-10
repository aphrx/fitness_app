import 'package:fitness_app/data/muscles_list.dart';
import 'package:fitness_app/data/tracking_list.dart';
import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/models/workout_exercise_relation.dart';
import 'package:fitness_app/services/db.dart';
import 'package:fitness_app/widgets/search_exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class AddExercise extends StatefulWidget {
  final String workoutId;

  const AddExercise({Key? key, required this.workoutId}) : super(key: key);
  @override
  State<AddExercise> createState() => _AddExerciseState(workoutId);
}

class _AddExerciseState extends State<AddExercise> {
  final String workoutId;
  var uuid = const Uuid();
  String exerciseName = "";

  Color darkPurple = const Color.fromRGBO(57, 53, 81, 1);
  String _trackingValue = "";
  String _search = "";
  String _primaryMuscle = "";
  String _secondaryMuscle = "";

  _AddExerciseState(this.workoutId);

  @override
  Widget build(BuildContext context) {
    Future<List<Exercise>> exercises = DB.getExercises(_search);

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(244, 245, 249, 1),
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            bottom: TabBar(
                unselectedLabelColor: darkPurple,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: darkPurple),
                tabs: [
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: darkPurple, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "SEARCH",
                          style: GoogleFonts.montserrat(),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: darkPurple, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "CUSTOM",
                          style: GoogleFonts.montserrat(),
                        ),
                      ),
                    ),
                  ),
                ]),
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
              "ADD EXERCISE",
              style: GoogleFonts.montserrat(
                  color: darkPurple, fontWeight: FontWeight.bold),
            ),
          ),
          body: TabBarView(children: [
            ListView(
              children: [
                Container(
                    padding: const EdgeInsets.all(15),
                    child: TextField(
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        setState(() {
                          _search = value;
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'SEARCH'),
                    )),
                FutureBuilder(
                  initialData: const [],
                  future: exercises,
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    return Column(
                        children: snapshot.data!
                            .map((item) => SearchExercise(
                                exercise: item, workoutId: workoutId))
                            .toList());
                  },
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: ListView(children: [
                          TextField(
                            onChanged: (value) => exerciseName = value,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(color: darkPurple),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'EXERCISE NAME'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: darkPurple, width: 0.5)),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              alignment: Alignment.center,
                              hint: Center(
                                child: Text(
                                  _primaryMuscle == ""
                                      ? "PRIMARY MUSCLE"
                                      : _primaryMuscle,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(),
                                ),
                              ),
                              underline: const SizedBox(),
                              items: muscles.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                      child: Text(value.toUpperCase(),
                                          textAlign: TextAlign.center)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _primaryMuscle = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: darkPurple, width: 0.5)),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              alignment: Alignment.center,
                              hint: Center(
                                child: Text(
                                  _secondaryMuscle == ""
                                      ? "SECONDARY MUSCLE"
                                      : _secondaryMuscle,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(),
                                ),
                              ),
                              underline: const SizedBox(),
                              items: muscles.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Center(
                                      child: Text(value.toUpperCase(),
                                          textAlign: TextAlign.center)),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _secondaryMuscle = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: darkPurple, width: 0.5)),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              alignment: Alignment.center,
                              hint: Center(
                                child: Text(
                                  _trackingValue == ""
                                      ? "TRACKING"
                                      : _trackingValue,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(),
                                ),
                              ),
                              underline: SizedBox(),
                              items: tracking.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                      margin: EdgeInsets.all(20),
                                      child: Center(
                                          child: Text(value.toUpperCase(),
                                              textAlign: TextAlign.center))),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _trackingValue = value!;
                                });
                              },
                            ),
                          ),
                        ]))),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: RawMaterialButton(
                      padding: const EdgeInsets.fromLTRB(120, 20, 120, 20),
                      elevation: 5,
                      fillColor: darkPurple,
                      onPressed: () async {
                        if (exerciseName.isNotEmpty &&
                            _primaryMuscle != "" &&
                            _trackingValue != "") {
                          String exerciseId = uuid.v1();
                          Exercise exercise = Exercise(
                              id: exerciseId,
                              name: exerciseName,
                              primaryMuscle: _primaryMuscle,
                              secondaryMuscle: _secondaryMuscle,
                              trackingOption: tracking.indexOf(_trackingValue));

                          print(tracking.indexOf(_trackingValue));

                          WorkoutExerciseRelation wer = WorkoutExerciseRelation(
                              id: uuid.v1().toString(),
                              workoutId: workoutId,
                              exerciseId: exerciseId);

                          await DB.insertExercise(exercise);
                          await DB.insertWorkoutExerciseRelation(wer);
                          Navigator.pop(context);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "ADD EXERCISE",
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                    ))
              ],
            )
          ]),
        ));
  }
}
