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
  bool get autofillLaunch;
  bool get isLoggedIn;
  AppState copyWith(
          {Entries entries,
          bool isSyncing,
          bool autofillLaunch,
          bool isLoggedIn}) =>
      AppState(
          entries: entries ?? this.entries,
          isSyncing: isSyncing ?? this.isSyncing,
          autofillLaunch: autofillLaunch ?? this.autofillLaunch,
          isLoggedIn: isLoggedIn ?? this.isLoggedIn);
  @override
  String toString() =>
      "AppState(entries: $entries, isSyncing: $isSyncing, autofillLaunch: $autofillLaunch, isLoggedIn: $isLoggedIn)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      entries == other.entries &&
      isSyncing == other.isSyncing &&
      autofillLaunch == other.autofillLaunch &&
      isLoggedIn == other.isLoggedIn;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + entries.hashCode;
    result = 37 * result + isSyncing.hashCode;
    result = 37 * result + autofillLaunch.hashCode;
    result = 37 * result + isLoggedIn.hashCode;
    return result;
  }
}

class AppState$ {
  static final entries = Lens<AppState, Entries>(
      (s_) => s_.entries, (s_, entries) => s_.copyWith(entries: entries));
  static final isSyncing = Lens<AppState, bool>((s_) => s_.isSyncing,
      (s_, isSyncing) => s_.copyWith(isSyncing: isSyncing));
  static final autofillLaunch = Lens<AppState, bool>((s_) => s_.autofillLaunch,
      (s_, autofillLaunch) => s_.copyWith(autofillLaunch: autofillLaunch));
  static final isLoggedIn = Lens<AppState, bool>((s_) => s_.isLoggedIn,
      (s_, isLoggedIn) => s_.copyWith(isLoggedIn: isLoggedIn));
}
