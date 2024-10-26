import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsTab extends StatefulWidget {
   SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
   String? selectedTheme='Light';
   String? selectedLang='English';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Theme',style: Theme.of(context).textTheme.labelSmall,),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all( 12),
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(

                color: Theme.of(context).colorScheme.onPrimary,
                border: Border.all(color: Theme.of(context).dividerColor,width: 2)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedTheme??'',style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor,
                ),),
                DropdownButton<String>(
underline: SizedBox.shrink(),
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 14,fontWeight: FontWeight.w400),
                  elevation: 0,
                  isExpanded: false,
                  value: selectedTheme,
                  items: <String>['Light','Dark'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newTheme) {
                    selectedTheme=newTheme;
                    setState(() {

                    });
                  },
                )
              ],
            ),

          ),

          SizedBox(height: 15),

          Text('Language',style: Theme.of(context).textTheme.labelSmall,),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all( 12),
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(

                color: Theme.of(context).colorScheme.onPrimary,
                border: Border.all(color: Theme.of(context).dividerColor,width: 2)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedLang??'',style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor,
                ),),
                DropdownButton<String>(
                  underline: SizedBox.shrink() ,
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 14,fontWeight: FontWeight.w400),
                  elevation: 0,
                  isExpanded: false,
                  value: selectedLang,
                  items: <String>['Arabic','English'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newLang) {
                    selectedLang=newLang  ;
                    setState(() {

                    });
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
