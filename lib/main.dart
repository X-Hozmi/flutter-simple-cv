import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv_page/presentation/bloc/cv_bloc.dart';
import 'package:flutter_cv_page/presentation/pages/CV/cv_page.dart';
import 'package:flutter_cv_page/injection.dart' as di;
import 'package:flutter_cv_page/widgets/cubit/hover_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Blocs
        BlocProvider(create: (_) => di.locator<CVBloc>()),

        // Cubits
        BlocProvider(create: (_) => di.locator<HoverCubit>()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple CV Template',
        home: CVPage(),
      ),
    );
  }
}
