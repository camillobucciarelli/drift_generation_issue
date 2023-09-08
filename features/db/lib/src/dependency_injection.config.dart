// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i4;

import 'package:db/src/app_database.dart' as _i5;
import 'package:db/src/dependency_injection.dart' as _i6;
import 'package:drift/drift.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final externalPackages = _$ExternalPackages();
    gh.factory<_i3.QueryExecutor>(() => externalPackages
        .nativeDatabase(gh<_i4.Directory>(instanceName: 'documentDirectory')));
    gh.singleton<_i5.AppDatabase>(_i5.AppDatabase(gh<_i3.QueryExecutor>()));
    return this;
  }
}

class _$ExternalPackages extends _i6.ExternalPackages {}
