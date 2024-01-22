import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/task.dart';
import 'models/user.dart';

class DatabaseHelper {
  static late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'task_manager.db');
    _database = await openDatabase(
      path,
      version: 3, // Incremented the version
      onCreate: _createTables,
      onUpgrade: _onUpgrade, // Added onUpgrade callback
    );
    return _database;
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT,
        phone_number TEXT
      )
    ''');

    await db.execute('''
    CREATE TABLE tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      due_date TEXT,
      start_time TIMESTAMP,   -- Added start_time column
      end_time TIMESTAMP,     -- Added end_time column
      is_completed INTEGER
    )
  ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("onUpgrade: oldVersion=$oldVersion, newVersion=$newVersion");

    if (oldVersion < 2) {
      // Perform database schema changes for version 2
      await db.execute('ALTER TABLE tasks ADD COLUMN start_time TEXT');
      await db.execute('ALTER TABLE tasks ADD COLUMN end_time TEXT');
    }

    // Add more upgrade logic as needed for each version increment
  }

  Future<int> insertUser(User user) async {
    final db = await database; // Ensure the database is initialized
    return await db.insert('users', user.toMap());
  }


  Future<User?> getUserByUsername(String username) async {
    try {
      final db = await database;
      List<Map<String, dynamic>> maps = await db.query(
        'users',
        where: 'username = ?',
        whereArgs: [username],
      );

      return maps.isNotEmpty ? User.fromMap(maps.first) : null;
    } catch (e) {
      print('Error getting user by username: $e');
      return null;
    }
  }

  // Task Operations
  Future<Task?> getTask(int taskId) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );

    if (maps.isNotEmpty) {
      return Task.fromMap(maps.first);
    } else {
      return null; // Return null if no task is found with the given ID
    }
  }
  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int taskId) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}
