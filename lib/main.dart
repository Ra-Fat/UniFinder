import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import './ui/app.dart';
import './data/storage/file_storage.dart';
import './data/repository/data_repository.dart';

// Global repository instance
late DataRepository dataRepository;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize repository
  if (kIsWeb) {
    final storage = FileStorage('');
    dataRepository = DataRepository(storage);
  } else {
    final storage = FileStorage('data');
    dataRepository = DataRepository(storage);
  }

  runApp(const App());
}
