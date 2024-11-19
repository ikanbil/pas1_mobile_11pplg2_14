import 'dart:async';
import 'package:pas1_mobile_10pplg2_14/model/PostModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  // Singleton pattern: private constructor
  DatabaseHelper._init();

  // Database getter
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('favorites.db'); // Name of the DB file
    return _database!;
  }

  // Open or create the database
  Future<Database> _initDB(String filePath) async {
    // Get the default database path
    final dbPath = await getDatabasesPath();
    // Join path with the database file name
    final path = join(dbPath, filePath);

    // Open or create the database
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB, // Call _createDB when the DB is created
    );
  }

  // Create the table in the database
  Future _createDB(Database db, int version) async {
    const tableName = 'favorites';
    // Create a SQL statement to create the table
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        strTeam TEXT NOT NULL,
        strBadge TEXT NOT NULL,
        strDescriptionEN TEXT,
        intFormedYear TEXT,
        strLeague TEXT,
        strStadium TEXT,
        strLocation TEXT
      )
    ''');
  }

  // Add a favorite item to the database
  Future<void> addFavorite(PostModel post) async {
    final db = await instance.database;
    // Insert the data into the favorites table
    await db.insert('favorites', {
      'strTeam': post.strTeam,
      'strBadge': post.strBadge,
      'strDescriptionEN': post.strDescriptionEN,
      'intFormedYear': post.intFormedYear,
      'strLeague': post.strLeague,
      'strStadium': post.strStadium,
      'strLocation': post.strLocation,
    });
  }

  // Retrieve all favorite items from the database
  Future<List<PostModel>> getFavorites() async {
    final db = await instance.database;
    final result = await db.query('favorites');
    // Convert the result into a list of PostModel objects
    return result.map((json) => PostModel.fromJson(json)).toList();
  }

  // Remove a favorite item from the database by team name
  Future<void> removeFavorite(String teamName) async {
    final db = await instance.database;
    // Delete the favorite with the specified team name
    await db.delete('favorites', where: 'strTeam = ?', whereArgs: [teamName]);
  }
}
