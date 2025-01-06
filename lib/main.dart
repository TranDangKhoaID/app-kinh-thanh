import 'package:app_kinh_thanh/dependency_injection.dart';
import 'package:app_kinh_thanh/helpers/object_box.dart';
import 'package:app_kinh_thanh/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//late ObjectBox objectBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //objectBox = await ObjectBox.init();
  await dotenv.load(fileName: '.env');
  DependencyInjection.init();
  runApp(const MyApp());
}
