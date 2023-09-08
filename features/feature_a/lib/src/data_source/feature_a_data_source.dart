import 'package:db/db.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../feature_a.dart';

part 'feature_a_data_source.g.dart';

abstract class FeatureADataSource {
  Future<void> insert(String message);

  Future<void> delete();

  Future<List<FeatureARow>> get();
}

@LazySingleton(as: FeatureADataSource)
@DriftAccessor(tables: [FeatureA])
class FeatureADataSourceImpl extends DatabaseAccessor<AppDatabase>
    with _$LogsDataSourceImplMixin
    implements FeatureADataSource {
  FeatureADataSourceImpl(super.attachedDatabase);

  @override
  Future<void> delete() {
    return delete(featureA).go();
  }

  @override
  Future<List<FeatureARow>> get() {
    final query = select(featureA)..orderBy([(t) => OrderingTerm.desc(t.timestamp)]);
    return query.get();
  }

  @override
  Future<void> insert(String message) {
    return into(featureA).insert(FeatueACompanion.insert(message: message));
  }
}
