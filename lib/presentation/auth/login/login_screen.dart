import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/strings_manager.dart';

import '../../../core/assets_manager.dart';
import '../../../core/reusable_components/custom_text_form_field.dart';
import '../../../core/routes_manager.dart';

class LoginScreen extends StatelessWidget {

   LoginScreen({super.key});
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [

            Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: SvgPicture.asset(AssetsManager.routeImage)),
            Expanded(
              flex: 3,
              child: CustomScrollView(
                slivers: [






                  SliverToBoxAdapter(
                    child: Text(
                      'E-mail ',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),

                  buildEmailField(),

                  SliverToBoxAdapter(
                    child: Text(
                      'Password',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),

                  buildPasswordField(),


                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: MaterialButton(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {},
                        child: Text(StringsManager.signIn,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF004182),
                            ))),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" Don't have Account ? ",style: GoogleFonts.poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.normal)),
                        TextButton(onPressed: () {
                          Navigator.pushReplacementNamed(context, RoutesManager.registerRoute);
                        }, child: Text(StringsManager.signUp,style: GoogleFonts.poppins( decoration: TextDecoration.underline,color: Colors.white,fontSize: 16,fontWeight: FontWeight.normal)))
                      ],
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmailField()=>SliverToBoxAdapter(
    child: CustomTextFormField(
      hinText: 'Enter your email',
      validator: (input) {
        if (input == null || input.trim().isEmpty) {
          return 'please, Enter email address';
        }
        // check email format
      },
      controller: emailController,
    ),
  );
  Widget buildPasswordField()=>SliverToBoxAdapter(
    child: CustomTextFormField(
      hinText: 'Enter your password',
      validator: (input) {
        if (input == null || input.trim().isEmpty) {
          return 'please, Enter password';
        }
        if (input.length < 6) {
          return 'Sorry, password should be at least 6 chars';
        }
      },
      controller: passwordController,
      isSecure: true,
    ),
  );
}
