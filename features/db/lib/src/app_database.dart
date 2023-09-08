import 'dart:ffi';

import 'package:drift/drift.dart';
import 'package:feature_a/feature_a.dart';
import 'package:injectable/injectable.dart';
import 'package:sqlite3/open.dart';

part 'app_database.g.dart';

@singleton
@DriftDatabase(
  tables: [
    ...FeatureADatabase.tables,
  ],
  daos: [
    ...FeatureADatabase.daos,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(
    super.nativeDatabase,
  );

  @override
  int get schemaVersion => 1;

  static void setupSqlCipher() {
    open.overrideFor(OperatingSystem.android, () => DynamicLibrary.open('libsqlcipher.so'));
  }

  Future<void> dropDatabase({required bool favorite}) {
    return transaction(() async {
      await customStatement('PRAGMA foreign_keys = OFF');
      for (final table in allTables) {
        await delete(table).go();
      }
      await customStatement('PRAGMA foreign_keys = ON');
    });
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        await transaction(
          () async {},
        );
      },
    );
  }
}
