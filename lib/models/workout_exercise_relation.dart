class WorkoutExerciseRelation {
  String id;
  String workoutId;
  String exerciseId;

  WorkoutExerciseRelation(
      {required this.id, required this.workoutId, required this.exerciseId});

  factory WorkoutExerciseRelation.fromMap(Map<String, dynamic> parsedJson) {
    return WorkoutExerciseRelation(
        id: parsedJson['id'],
        workoutId: parsedJson['workoutId'],
        exerciseId: parsedJson['exerciseId']);
  }

  static List<WorkoutExerciseRelation> listfromMap(List<dynamic> list) {
    List<WorkoutExerciseRelation> rows =
        list.map((i) => WorkoutExerciseRelation.fromMap(i)).toList();
    return rows;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'workoutId': workoutId,
      'exerciseId': exerciseId
    };
    return map;
  }
}
