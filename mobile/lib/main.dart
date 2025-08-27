import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/core/storage/local_storage_service.dart';
import 'package:mobile/views/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();
  await dotenv.load(fileName: ".env");

  runApp(LibraBookApp());
}