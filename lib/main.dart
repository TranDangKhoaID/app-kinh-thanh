import 'package:app_kinh_thanh/dependency_injection.dart';
import 'package:app_kinh_thanh/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  DependencyInjection.init();
  runApp(const MyApp());
}
