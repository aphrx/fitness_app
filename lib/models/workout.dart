class Workout {
  String id;
  String name;
  String date;
  String duration;

  Workout(
      {required this.id,
      required this.name,
      required this.date,
      required this.duration});

  factory Workout.fromMap(Map<String, dynamic> parsedJson) {
    return Workout(
      id: parsedJson['id'],
      name: parsedJson['name'],
      date: parsedJson['date'],
      duration: parsedJson['duration'],
    );
  }

  static List<Workout> listfromMap(List<dynamic> list) {
    List<Workout> rows = list.map((i) => Workout.fromMap(i)).toList();
    return rows;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'date': date,
      'duration': duration
    };
    return map;
  }
}
