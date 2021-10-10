class ExerciseEntry {
  String id;
  String workoutId;
  String exerciseId;
  String sessionId;
  int reps;
  double weights;
  String duration;
  String customText;
  String performedTime;

  ExerciseEntry(
      {required this.id,
      required this.workoutId,
      required this.exerciseId,
      required this.sessionId,
      required this.reps,
      required this.weights,
      required this.duration,
      required this.customText,
      required this.performedTime});

  factory ExerciseEntry.fromMap(Map<String, dynamic> parsedJson) {
    return ExerciseEntry(
      id: parsedJson['id'],
      workoutId: parsedJson['workoutId'],
      exerciseId: parsedJson['exerciseId'],
      sessionId: parsedJson['sessionId'],
      reps: parsedJson['reps'],
      weights: parsedJson['weights'],
      duration: parsedJson['duration'],
      customText: parsedJson['customText'],
      performedTime: parsedJson['performedTime'],
    );
  }

  static List<ExerciseEntry> listfromMap(List<dynamic> list) {
    List<ExerciseEntry> rows =
        list.map((i) => ExerciseEntry.fromMap(i)).toList();
    return rows;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'workoutId': workoutId,
      'exerciseId': exerciseId,
      'sessionId': sessionId,
      'reps': reps,
      'weights': weights,
      'duration': duration,
      'customText': customText,
      'performedTime': performedTime
    };
    return map;
  }
}
