import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/models/form_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'cervantes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> deleteDataBase() async {
    String path = join(await getDatabasesPath(), 'cervantes.db');
    await deleteDatabase(path);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cadastro (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        texto TEXT NOT NULL,
        numero INTEGER NOT NULL UNIQUE CHECK (numero > 0)
      )
    ''');

    await db.execute('''
      CREATE TABLE log (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        operation TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        cadastro_id INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertCadastro(String texto, int numero) async {
    if (texto.isEmpty) {
      throw 'O campo de texto não pode ser vazio.';
    }

    if (numero <= 0) {
      throw 'O campo de número deve ser maior que zero.';
    }

    final db = await database;

    try {
      int id = await db.insert('cadastro', {'texto': texto, 'numero': numero});
      await _logOperation('Insert', id);
      return id;
    } catch (e) {
      if (e.toString().contains('UNIQUE constraint failed')) {
        throw 'O número informado já existe na tabela.';
      } else {
        throw 'Erro ao inserir cadastro: ${e.toString()}';
      }
    }
  }

  Future<int> updateCadastro(int id, String texto, int numero) async {
    if (texto.isEmpty) {
      throw 'O campo de texto não pode ser vazio.';
    }

    if (numero <= 0) {
      throw 'O campo de número deve ser maior que zero.';
    }

    try {
      final db = await database;
      int count = await db.update(
        'cadastro',
        {'texto': texto, 'numero': numero},
        where: 'id = ?',
        whereArgs: [id],
      );
      await _logOperation('Update', id);
      return count;
    } catch (e) {
      if (e.toString().contains('UNIQUE constraint failed')) {
        throw 'O número informado já existe na tabela.';
      } else {
        throw 'Erro ao Atualizar cadastro: ${e.toString()}';
      }
    }
  }

  Future<int> deleteCadastro(int id) async {
    final db = await database;
    int count = await db.delete(
      'cadastro',
      where: 'id = ?',
      whereArgs: [id],
    );
    await _logOperation('Delete', id);
    return count;
  }

  Future<List<FormModel>> getCadastros() async {
    final db = await database;

    final List<Map<String, dynamic>> list = await db.query('cadastro');

    return List.generate(
      list.length,
      (index) => FormModel.fromMap(
        list[index],
      ),
    );
  }

  Future<void> _logOperation(String operation, int cadastroId) async {
    final db = await database;
    await db.insert('log', {
      'operation': operation,
      'timestamp': DateTime.now().toIso8601String(),
      'cadastro_id': cadastroId,
    });
  }

  Future<List<Map<String, dynamic>>> getLogs() async {
    final db = await database;
    return await db.query('log');
  }
}
