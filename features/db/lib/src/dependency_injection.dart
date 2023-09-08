import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../db.dart';

@InjectableInit()
Future<void> initAppDatabaseModule(GetIt injector) async {
  AppDatabase.setupSqlCipher();
}

@module
abstract class ExternalPackages {
  QueryExecutor nativeDatabase(@Named('documentDirectory') Directory documentDirectory) => NativeDatabase(
        File('${documentDirectory.path}/db.sqlite'),
        setup: (database) {
          assert(database.select('PRAGMA cipher_version;').isNotEmpty, 'SqlCipher not loaded');
          const oldPassword = r'xxxxx';
          const newPassword = String.fromEnvironment('DB_PASSWORD');
          try {
            database
              ..execute("PRAGMA key = '$oldPassword';")
              ..execute('pragma user_version')
              ..execute("pragma rekey = '$newPassword'");
          } on SqliteException catch (_) {
            database.execute("PRAGMA key = '$newPassword';");
          }
        },
      );
}
