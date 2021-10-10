import 'dart:async';
import 'package:fitness_app/models/exercise.dart';
import 'package:fitness_app/models/exercise_entry.dart';
import 'package:fitness_app/models/session.dart';
import 'package:fitness_app/models/workout.dart';
import 'package:fitness_app/models/workout_exercise_relation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {
  static Future<Database> database = init();

  static Future<Database> init() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'database10.db'),
      onCreate: (db, version) async {
        print("Creating db");
        db.execute(
          'CREATE TABLE Exercises(id TEXT PRIMARY KEY, name TEXT, primaryMuscle TEXT, secondaryMuscle TEXT, trackingOption INTEGER)',
        );
        db.execute(
          'CREATE TABLE Workouts(id TEXT PRIMARY KEY, name TEXT, date TEXT, duration TEXT)',
        );
        db.execute(
          'CREATE TABLE WorkoutExerciseRelation(id TEXT PRIMARY KEY, workoutId TEXT, exerciseId TEXT)',
        );
        db.execute(
          'CREATE TABLE ExerciseEntry(id TEXT PRIMARY KEY, workoutId TEXT, exerciseId TEXT, sessionId TEXT, reps INTEGER, weights REAL, duration TEXT, customText TEXT, performedTime TEXT)',
        );
        db.execute(
          'CREATE TABLE Sessions(id TEXT PRIMARY KEY, workoutId TEXT, workoutName TEXT, date TEXT, duration TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertExercise(Exercise exercise) async {
    final db = await database;
    await db.insert(
      'Exercises',
      exercise.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Exercise>> getExercises(String search) async {
    final db = await database;
    search = "%" + search + "%";

    final List<Map<String, dynamic>> maps = await db
        .rawQuery("SELECT * FROM Exercises WHERE name LIKE ?", [search]);

    return List.generate(maps.length, (i) {
      return Exercise.fromMap(maps[i]);
    });
  }

  static Future<List<Exercise>> getWorkoutExercises(String workoutId) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        """SELECT Exercises.* FROM Exercises INNER JOIN WorkoutExerciseRelation ON Exercises.id = WorkoutExerciseRelation.exerciseId WHERE workoutId = ?""",
        [workoutId]);

    return List.generate(maps.length, (i) {
      return Exercise.fromMap(maps[i]);
    });
  }

  static Future<List<Exercise>> getExercise(String exerciseId) async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM Exercises WHERE id = ?", [exerciseId]);

    return List.generate(maps.length, (i) {
      return Exercise.fromMap(maps[i]);
    });
  }

  static Future<void> insertWorkout(Workout workout) async {
    final db = await database;
    await db.insert(
      'Workouts',
      workout.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Workout>> getWorkouts() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('Workouts');

    return List.generate(maps.length, (i) {
      return Workout.fromMap(maps[i]);
    });
  }

  static Future<void> deleteWorkouts(String workoutId) async {
    final db = await database;

    await db.delete(
      'Workouts',
      where: 'id = ?',
      whereArgs: [workoutId],
    );
    await db.delete(
      'WorkoutExerciseRelation',
      where: 'workoutId = ?',
      whereArgs: [workoutId],
    );
  }

  static Future<void> deleteSession(String sessionId) async {
    final db = await database;

    await db.delete(
      'Sessions',
      where: 'id = ?',
      whereArgs: [sessionId],
    );
    await db.delete(
      'ExerciseEntry',
      where: 'sessionId = ?',
      whereArgs: [sessionId],
    );
  }

  static Future<void> insertWorkoutExerciseRelation(
      WorkoutExerciseRelation workoutExerciseRelation) async {
    final db = await database;
    await db.insert(
      'WorkoutExerciseRelation',
      workoutExerciseRelation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<WorkoutExerciseRelation>>
      getWorkoutExerciseRelation() async {
    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query('WorkoutExerciseRelation');

    return List.generate(maps.length, (i) {
      return WorkoutExerciseRelation.fromMap(maps[i]);
    });
  }

  static Future<void> insertExerciseEntry(
      ExerciseEntry workoutExerciseRelation) async {
    final db = await database;
    await db.insert(
      'ExerciseEntry',
      workoutExerciseRelation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<ExerciseEntry>> getExerciseEntry() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('ExerciseEntry');

    return List.generate(maps.length, (i) {
      return ExerciseEntry.fromMap(maps[i]);
    });
  }

  static Future<List<ExerciseEntry>> getExerciseEntryRep(
      String workoutId, String exerciseId, String sessionId) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM ExerciseEntry WHERE workoutId = ? AND exerciseId = ? AND sessionId = ?",
        [workoutId, exerciseId, sessionId]);

    return List.generate(maps.length, (i) {
      return ExerciseEntry.fromMap(maps[i]);
    });
  }

  static Future<List<ExerciseEntry>> getPrevWorkouts(
      String workoutId, String exerciseId, String sessionId) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM Workouts WHERE id = (SELECT workoutId from ExerciseEntry GROUP)");

    return List.generate(maps.length, (i) {
      return ExerciseEntry.fromMap(maps[i]);
    });
  }

  static Future<void> insertSession(Session session) async {
    final db = await database;
    await db.insert(
      'Sessions',
      session.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Session>> getSessions() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('Sessions');

    return List.generate(maps.length, (i) {
      return Session.fromMap(maps[i]);
    });
  }

  static Future<List<Exercise>> getSessionExercises(String sessionId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT Exercises.* FROM Exercises INNER JOIN ExerciseEntry ON Exercises.id = ExerciseEntry.exerciseId WHERE ExerciseEntry.sessionId = ? GROUP BY ExerciseEntry.exerciseId",
        [sessionId]);
    return List.generate(maps.length, (i) {
      return Exercise.fromMap(maps[i]);
    });
  }
}
