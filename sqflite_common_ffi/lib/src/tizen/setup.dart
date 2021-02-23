import 'dart:ffi';
import 'dart:io';

import 'package:sqflite_common_ffi/src/import.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/src/windows/setup_impl.dart';
import 'package:path_provider_tizen/path_provider_tizen.dart';

// Tizen specific sqflite3 initialization. it is mimic an implementation for windows
void tizenInit() {
  // It must be unnecessary, but currently, it is not.
  PathProviderPlugin.register();

  open.overrideFor(OperatingSystem.linux, () {
    try {
      return DynamicLibrary.open('libsqlite3.so.0');
    } catch (e) {
      stderr.writeln('led to load libsqlite3');
      rethrow;
    }
  });
  // Force an open in the main isolate
  // Loading from an isolate seems to break on windows
  sqlite3.openInMemory().dispose();
}
