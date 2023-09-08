import 'package:drift/drift.dart';
import 'package:feature_a/src/data_source/feature_a_data_source.dart';

part 'tables/feature_a_table.dart';

class FeatureADatabase {
  static const tables = [
    FeatureA,
  ];
  static const daos = [
    FeatureADataSourceImpl,
  ];
}
