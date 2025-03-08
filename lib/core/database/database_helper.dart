import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'events360.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create speakers table
    await db.execute('''
      CREATE TABLE speakers(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        title TEXT,
        image TEXT,
        topic TEXT,
        time TEXT,
        stage TEXT,
        bio TEXT
      )
    ''');
    
    // Create attendees table
    await db.execute('''
      CREATE TABLE attendees(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        headline TEXT,
        image TEXT
      )
    ''');
    
    // Create sponsors table
    await db.execute('''
      CREATE TABLE sponsors(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        tier TEXT,
        logo TEXT,
        booth TEXT
      )
    ''');
    
    // Create agenda table
    await db.execute('''
      CREATE TABLE agenda(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        time TEXT,
        title TEXT,
        speaker TEXT,
        location TEXT,
        description TEXT
      )
    ''');
    
    // Create user profile table
    await db.execute('''
      CREATE TABLE profile(
        id INTEGER PRIMARY KEY,
        name TEXT,
        headline TEXT,
        image TEXT
      )
    ''');
    
    // Create tickets table
    await db.execute('''
      CREATE TABLE tickets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        eventName TEXT,
        date TEXT,
        ticketType TEXT,
        userId INTEGER,
        FOREIGN KEY (userId) REFERENCES profile (id)
      )
    ''');
    
    // Insert sample data
    await _insertSampleData(db);
  }
  
  Future<void> _insertSampleData(Database db) async {
    // Insert sample speakers
    await db.insert('speakers', {
      'name': 'John Smith',
      'title': 'CEO, TechCorp',
      'image': 'https://randomuser.me/api/portraits/men/41.jpg',
      'topic': 'Opening Keynote',
      'time': '09:00 AM - 10:00 AM',
      'stage': 'Main Stage',
      'bio': 'John Smith is the CEO of TechCorp with over 20 years of experience in the technology industry.',
    });
    
    await db.insert('speakers', {
      'name': 'Sarah Johnson',
      'title': 'AI Research Lead, InnovateSoft',
      'image': 'https://randomuser.me/api/portraits/women/33.jpg',
      'topic': 'Future of AI in Business',
      'time': '10:30 AM - 11:30 AM',
      'stage': 'Hall A',
      'bio': 'Sarah Johnson leads AI research at InnovateSoft, focusing on practical applications of machine learning in business contexts.',
    });
    
    // Insert sample attendees
    await db.insert('attendees', {
      'name': 'Emma Watson',
      'headline': 'Tech Enthusiast',
      'image': 'https://randomuser.me/api/portraits/women/44.jpg',
    });
    
    await db.insert('attendees', {
      'name': 'James Wilson',
      'headline': 'Software Dev',
      'image': 'https://randomuser.me/api/portraits/men/32.jpg',
    });
    
    // Insert sample agenda items
    await db.insert('agenda', {
      'time': '09:00 AM - 10:00 AM',
      'title': 'Opening Keynote',
      'speaker': 'John Smith',
      'location': 'Main Stage',
      'description': 'Welcome address and introduction to the event themes',
    });
    
    await db.insert('agenda', {
      'time': '10:30 AM - 11:30 AM',
      'title': 'Future of AI in Business',
      'speaker': 'Sarah Johnson',
      'location': 'Hall A',
      'description': 'Exploring how AI is transforming business operations',
    });
    
    // Insert sample user profile
    await db.insert('profile', {
      'id': 1,
      'name': 'Alex Johnson',
      'headline': 'Tech Enthusiast',
      'image': 'https://randomuser.me/api/portraits/men/32.jpg',
    });
    
    // Insert sample tickets
    await db.insert('tickets', {
      'eventName': 'Tech Summit 2024',
      'date': 'June 15-16, 2024',
      'ticketType': 'VIP Pass',
      'userId': 1,
    });
  }
  
  // CRUD operations for speakers
  Future<List<Map<String, dynamic>>> getSpeakers() async {
    final db = await database;
    return await db.query('speakers');
  }
  
  Future<Map<String, dynamic>?> getSpeaker(int id) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'speakers',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }
  
  // CRUD operations for attendees
  Future<List<Map<String, dynamic>>> getAttendees() async {
    final db = await database;
    return await db.query('attendees');
  }
  
  // CRUD operations for agenda
  Future<List<Map<String, dynamic>>> getAgendaItems() async {
    final db = await database;
    return await db.query('agenda');
  }
  
  // CRUD operations for profile
  Future<Map<String, dynamic>?> getUserProfile() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query('profile');
    
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }
  
  Future<int> updateUserProfile(Map<String, dynamic> profile) async {
    final db = await database;
    return await db.update(
      'profile',
      profile,
      where: 'id = ?',
      whereArgs: [profile['id']],
    );
  }
  
  // CRUD operations for tickets
  Future<List<Map<String, dynamic>>> getUserTickets(int userId) async {
    final db = await database;
    return await db.query(
      'tickets',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }
  
  Future<int> addTicket(Map<String, dynamic> ticket) async {
    final db = await database;
    return await db.insert('tickets', ticket);
  }
}