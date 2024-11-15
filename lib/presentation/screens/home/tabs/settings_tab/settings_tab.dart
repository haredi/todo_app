import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/my_text_styles.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/provider/lang_provider.dart';
import 'package:todo_app/provider/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                border: Border.all(
                    color: Theme.of(context).dividerColor, width: 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.read<ThemeProvider>().isLight() ? AppLocalizations.of(context)!.light
                      : AppLocalizations.of(context)!.dark,
                  style: AppStyles.settingsItemLabelTextStyle,
                ),
                DropdownButton<String>(
                  isDense: false,
                  autofocus: false,
                  enableFeedback: false,
                  underline: SizedBox.shrink(),
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  elevation: 0,
                  isExpanded: false,
                  //value: selectedTheme,
                  items: <String>['Light', 'Dark'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newTheme) {
                    context.read<ThemeProvider>().updateTheme(
                        newTheme == 'Light' ? ThemeMode.light : ThemeMode.dark);
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 15),
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                border: Border.all(
                    color: Theme.of(context).dividerColor, width: 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.read<LangProvider>().isEnglish()?AppLocalizations.of(context)!.english
                    :AppLocalizations.of(context)!.arabic,
                    style: AppStyles.settingsItemLabelTextStyle),
                DropdownButton<String>(
                  isDense: false,
                  autofocus: false,
                  enableFeedback: false,
                  underline: SizedBox.shrink(),
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  elevation: 0,
                  isExpanded: false,
                  // value: selectedLang,
                  items: <String>['Arabic', 'English'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newLang) {
                    context.read<LangProvider>().updateLang(newLang=='English'?'en':'ar');
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
