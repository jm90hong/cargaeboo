// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CarDao? _carDaoInstance;

  PartsDao? _partsDaoInstance;

  HistoryDao? _historyDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Car` (`idx` INTEGER PRIMARY KEY AUTOINCREMENT, `base64` TEXT NOT NULL, `name` TEXT NOT NULL, `buyYear` TEXT NOT NULL, `buyMonth` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Parts` (`idx` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `durationDistance` INTEGER NOT NULL, `durationPeriod` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `History` (`idx` INTEGER PRIMARY KEY AUTOINCREMENT, `carIdx` INTEGER NOT NULL, `partsIdx` INTEGER NOT NULL, `distance` INTEGER NOT NULL, `date` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CarDao get carDao {
    return _carDaoInstance ??= _$CarDao(database, changeListener);
  }

  @override
  PartsDao get partsDao {
    return _partsDaoInstance ??= _$PartsDao(database, changeListener);
  }

  @override
  HistoryDao get historyDao {
    return _historyDaoInstance ??= _$HistoryDao(database, changeListener);
  }
}

class _$CarDao extends CarDao {
  _$CarDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _carInsertionAdapter = InsertionAdapter(
            database,
            'Car',
            (Car item) => <String, Object?>{
                  'idx': item.idx,
                  'base64': item.base64,
                  'name': item.name,
                  'buyYear': item.buyYear,
                  'buyMonth': item.buyMonth
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Car> _carInsertionAdapter;

  @override
  Future<List<Car>> findAllCars() async {
    return _queryAdapter.queryList('SELECT * FROM Car ORDER BY idx DESC',
        mapper: (Map<String, Object?> row) => Car(
            idx: row['idx'] as int?,
            base64: row['base64'] as String,
            name: row['name'] as String,
            buyMonth: row['buyMonth'] as String,
            buyYear: row['buyYear'] as String));
  }

  @override
  Future<void> deleteCarByIdx(int idx) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Car WHERE idx = ?1', arguments: [idx]);
  }

  @override
  Future<Car?> findCarByIdx(int idx) async {
    return _queryAdapter.query('SELECT * FROM Car WHERE idx = ?1',
        mapper: (Map<String, Object?> row) => Car(
            idx: row['idx'] as int?,
            base64: row['base64'] as String,
            name: row['name'] as String,
            buyMonth: row['buyMonth'] as String,
            buyYear: row['buyYear'] as String),
        arguments: [idx]);
  }

  @override
  Future<void> insertCar(Car car) async {
    await _carInsertionAdapter.insert(car, OnConflictStrategy.abort);
  }
}

class _$PartsDao extends PartsDao {
  _$PartsDao(
    this.database,
    this.changeListener,
  );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;
}

class _$HistoryDao extends HistoryDao {
  _$HistoryDao(
    this.database,
    this.changeListener,
  );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;
}
