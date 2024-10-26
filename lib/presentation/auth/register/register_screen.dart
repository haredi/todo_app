import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/assets_manager.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/reusable_components/custom_text_form_field.dart';
import 'package:todo_app/core/routes_manager.dart';
import 'package:todo_app/core/strings_manager.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
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
                  buildTitleItem('Full Name'),
                  buildFullNameField(),
                  buildTitleItem('User Name'),
                  buildUserNameField(),
                  buildTitleItem('E-mail'),

                  buildEmailField(),

        buildTitleItem('Password'),
                  buildPasswordField(),

                  buildTitleItem('Re-Password'),
                  buildRePasswordField(),
                  const SliverToBoxAdapter(
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
                        child: Text(StringsManager.signUp,
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
                        Text('Already have Account ? ',style: GoogleFonts.poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.normal)),
                        TextButton(onPressed: () {
                          Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
                        }, child: Text(StringsManager.signIn,style: GoogleFonts.poppins( decoration: TextDecoration.underline,color: Colors.white,fontSize: 16,fontWeight: FontWeight.normal)))
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

  Widget buildFullNameField() => SliverToBoxAdapter(
        child: CustomTextFormField(
          hinText: 'Enter your full name',
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return 'please, Enter Full Name';
            }
          },
          controller: fullNameController,
        ),
      );
  Widget buildUserNameField() => SliverToBoxAdapter(
        child: CustomTextFormField(
          hinText: 'Enter your user name',
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return 'please, Enter User Name';
            }
          },
          controller: userNameController,
        ),
      );
  Widget buildEmailField() => SliverToBoxAdapter(
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
  Widget buildPasswordField() => SliverToBoxAdapter(
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
  Widget buildRePasswordField() => SliverToBoxAdapter(
        child: CustomTextFormField(
          hinText: 'Confirm password',
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return 'please, Enter same password';
            }
          },
          controller: rePasswordController,
        ),
      );

  Widget buildTitleItem(String title)=>SliverToBoxAdapter(
    child: Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}
