import 'package:fitness_app/widgets/search_exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AddExercise extends StatefulWidget {
  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  Color darkPurple = const Color.fromRGBO(57, 53, 81, 1);
  String _trackingValue = "None";

  @override
  Widget build(BuildContext context) {
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
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Search'),
                    )),
                SearchExercise(),
                SearchExercise()
              ],
            ),
            ListView(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(color: darkPurple),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'EXERCISE NAME'),
                  ),
                ),
                Column(
                  children: [
                    RadioListTile(
                        title: Text("NONE",
                            style: GoogleFonts.montserrat(color: darkPurple)),
                        value: "NONE",
                        groupValue: _trackingValue,
                        onChanged: (String? value) {
                          setState(() {
                            _trackingValue = value!;
                          });
                        }),
                    RadioListTile(
                        title: Text("REPS X WEIGHT",
                            style: GoogleFonts.montserrat(color: darkPurple)),
                        value: "REPS X WEIGHT",
                        groupValue: _trackingValue,
                        onChanged: (String? value) {
                          setState(() {
                            _trackingValue = value!;
                          });
                        }),
                    RadioListTile(
                        title: Text("REPS",
                            style: GoogleFonts.montserrat(color: darkPurple)),
                        value: "REPS",
                        groupValue: _trackingValue,
                        onChanged: (String? value) {
                          setState(() {
                            _trackingValue = value!;
                          });
                        }),
                    RadioListTile(
                        title: Text("DURATION",
                            style: GoogleFonts.montserrat(color: darkPurple)),
                        value: "DURATION",
                        groupValue: _trackingValue,
                        onChanged: (String? value) {
                          setState(() {
                            _trackingValue = value!;
                          });
                        }),
                    RadioListTile(
                        title: Text("CUSTOM",
                            style: GoogleFonts.montserrat(color: darkPurple)),
                        value: "CUSTOM",
                        groupValue: _trackingValue,
                        onChanged: (String? value) {
                          setState(() {
                            _trackingValue = value!;
                          });
                        })
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: RawMaterialButton(
                      padding: const EdgeInsets.fromLTRB(120, 20, 120, 20),
                      elevation: 5,
                      fillColor: darkPurple,
                      onPressed: () {},
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
