import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/config/theme/my_theme.dart';
import 'package:todo_app/core/routes_manager.dart';
import 'package:todo_app/provider/lang_provider.dart';
import 'package:todo_app/provider/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales:const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      locale: Locale(context.watch<LangProvider>().currentLang),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesManager.route,
      initialRoute: RoutesManager.loginRoute ,
      theme: MyTheme.light,
      darkTheme: MyTheme.dark,
      themeMode: context.watch<ThemeProvider>().currentTheme,
    );
  }
}
