class Exercise {
  String id;
  String name;
  String primaryMuscle;
  String secondaryMuscle;
  int trackingOption;

  Exercise({
    required this.id,
    required this.name,
    required this.primaryMuscle,
    required this.secondaryMuscle,
    required this.trackingOption,
  });

  factory Exercise.fromMap(Map<String, dynamic> parsedJson) {
    return Exercise(
      id: parsedJson['id'],
      name: parsedJson['name'],
      primaryMuscle: parsedJson['primaryMuscle'],
      secondaryMuscle: parsedJson['secondaryMuscle'],
      trackingOption: parsedJson['trackingOption'],
    );
  }

  static List<Exercise> listfromMap(List<dynamic> list) {
    List<Exercise> rows = list.map((i) => Exercise.fromMap(i)).toList();
    return rows;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'primaryMuscle': primaryMuscle,
      'secondaryMuscle': secondaryMuscle,
      'trackingOption': trackingOption,
    };
    return map;
  }
}
