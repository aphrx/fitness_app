import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkoutTile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorkoutTileState();
}

class _WorkoutTileState extends State<WorkoutTile> {
  Color darkPurple = const Color.fromRGBO(24, 22, 33, 1);

  int reps = 4;
  double weight = 44.5;
  @override
  Widget build(BuildContext context) {
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
              Text("Deadlift",
                  style: GoogleFonts.montserrat(
                      color: darkPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Back",
                  style: GoogleFonts.montserrat(
                      color: const Color.fromRGBO(213, 214, 220, 1),
                      fontWeight: FontWeight.normal,
                      fontSize: 16))
            ],
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("1",
                    style: GoogleFonts.montserrat(
                        color: darkPurple, fontSize: 16)),
                Text("4 reps",
                    style: GoogleFonts.montserrat(
                        color: darkPurple, fontSize: 16)),
                Text("55 lbs",
                    style:
                        GoogleFonts.montserrat(color: darkPurple, fontSize: 16))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("2",
                    style: GoogleFonts.montserrat(
                        color: darkPurple, fontSize: 16)),
                Text("3 reps",
                    style: GoogleFonts.montserrat(
                        color: darkPurple, fontSize: 16)),
                Text("60 lbs",
                    style:
                        GoogleFonts.montserrat(color: darkPurple, fontSize: 16))
              ],
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(37, 34, 53, 1),
                  padding: const EdgeInsets.fromLTRB(128, 10, 128, 10)),
              onPressed: () {
                showBottomSheet(
                    context: context,
                    builder: (context) => StatefulBuilder(
                        builder: (BuildContext c, setState) =>
                            ListView(shrinkWrap: true, children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                  color: darkPurple,
                                ),
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Text(
                                      "REPS",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                reps -= 1;
                                              });
                                            },
                                            icon: const Icon(Icons.remove,
                                                color: Colors.white)),
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
                                          icon: const Icon(Icons.add,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      "WEIGHT",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                weight -= 0.5;
                                              });
                                            },
                                            icon: const Icon(Icons.remove,
                                                color: Colors.white)),
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
                                          icon: const Icon(Icons.add,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    RawMaterialButton(
                                      padding: const EdgeInsets.fromLTRB(
                                          130, 20, 130, 20),
                                      elevation: 5,
                                      fillColor: Colors.white,
                                      onPressed: () => Navigator.pop(context),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        "ADD SET",
                                        style: GoogleFonts.montserrat(
                                            color: darkPurple),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ])));
              },
              child: Text(
                "ADD SET",
                style: GoogleFonts.montserrat(),
              )),
        ]));
  }
}
