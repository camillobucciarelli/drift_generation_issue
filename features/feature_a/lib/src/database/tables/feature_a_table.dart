part of '../feature_a_database.dart';

@DataClassName('FeatureARow')
class FeatureA extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get message => text()();

  DateTimeColumn get timestamp => dateTime().clientDefault(() => DateTime.now().toUtc())();
}
