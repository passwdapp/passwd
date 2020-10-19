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
  bool get isSyncing;
  AppState copyWith({Entries entries, bool isSyncing}) => AppState(
      entries: entries ?? this.entries, isSyncing: isSyncing ?? this.isSyncing);
  @override
  String toString() => "AppState(entries: $entries, isSyncing: $isSyncing)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      entries == other.entries &&
      isSyncing == other.isSyncing;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + entries.hashCode;
    result = 37 * result + isSyncing.hashCode;
    return result;
  }
}

class AppState$ {
  static final entries = Lens<AppState, Entries>(
      (s_) => s_.entries, (s_, entries) => s_.copyWith(entries: entries));
  static final isSyncing = Lens<AppState, bool>((s_) => s_.isSyncing,
      (s_, isSyncing) => s_.copyWith(isSyncing: isSyncing));
}
