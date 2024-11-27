import 'package:ai_project_lab_pannon/features/common/core/view/screens/splash_screen.dart';
import 'package:ai_project_lab_pannon/shared/services/local/cache_helper.dart';
import 'package:ai_project_lab_pannon/shared/style/themes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/common/auth/view_model/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await CacheHelper.init();
  await Supabase.initialize(
    url: dotenv.env['PROJECTURL']!,
    anonKey: dotenv.env['APIKEY']!,
  );
  runApp(const PlantDiseaseDetectApp());
}

class PlantDiseaseDetectApp extends StatelessWidget {
  const PlantDiseaseDetectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        theme: ThemeManagerHelper.lightTheme(),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
