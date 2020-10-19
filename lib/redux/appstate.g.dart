// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appstate.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $AppState {
  const $AppState();
  Entries get entries;
  AppState copyWith({Entries entries}) =>
      AppState(entries: entries ?? this.entries);
  @override
  String toString() => "AppState(entries: $entries)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType && entries == other.entries;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + entries.hashCode;
    return result;
  }
}

class AppState$ {
  static final entries = Lens<AppState, Entries>(
      (s_) => s_.entries, (s_, entries) => s_.copyWith(entries: entries));
}
