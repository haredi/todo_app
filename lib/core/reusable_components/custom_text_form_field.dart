import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/colors_manager.dart';
typedef Validator=String? Function(String?)?;
class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({super.key,required this.hinText,this.validator, this.controller,this.isSecure=false});
  String hinText;
   Validator? validator;
   TextEditingController? controller;
   bool isSecure;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
      obscureText: isSecure,
        validator: validator,
        controller: controller,

        decoration: InputDecoration(
          filled: true,
          fillColor: ColorsManager.whiteColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white)

          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white)

          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.white)

          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.red)
          ),
          hintText: hinText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight:FontWeight.w300 ,
            color: Color(0xFF000000),
          )
        ),
      ),
    );
  }
}
