class Session {
  String id;
  String workoutId;
  String workoutName;
  String date;
  String duration;

  Session(
      {required this.id,
      required this.workoutId,
      required this.workoutName,
      required this.date,
      required this.duration});

  factory Session.fromMap(Map<String, dynamic> parsedJson) {
    return Session(
      id: parsedJson['id'],
      workoutId: parsedJson['workoutId'],
      workoutName: parsedJson['workoutName'],
      date: parsedJson['date'],
      duration: parsedJson['duration'],
    );
  }

  static List<Session> listfromMap(List<dynamic> list) {
    List<Session> rows = list.map((i) => Session.fromMap(i)).toList();
    return rows;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'workoutId': workoutId,
      'workoutName': workoutName,
      'date': date,
      'duration': duration,
    };
    return map;
  }
}
