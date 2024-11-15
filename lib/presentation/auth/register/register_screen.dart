import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/assets_manager.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/constant_manager.dart';
import 'package:todo_app/core/reusable_components/custom_text_form_field.dart';
import 'package:todo_app/core/routes_manager.dart';
import 'package:todo_app/core/strings_manager.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                  buildTitleItem(AppLocalizations.of(context)!.full_name),
                  buildFullNameField(),
                  buildTitleItem(AppLocalizations.of(context)!.user_name),
                  buildUserNameField(),
                  buildTitleItem(AppLocalizations.of(context)!.email),

                  buildEmailField(),

        buildTitleItem(AppLocalizations.of(context)!.password),
                  buildPasswordField(),

                  buildTitleItem(AppLocalizations.of(context)!.re_password),
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
                        onPressed: () {
                          signUp(context);
                        },
                        child: Text(AppLocalizations.of(context)!.sign_up,
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
                        Text(AppLocalizations.of(context)!.already_have_account,style: GoogleFonts.poppins(color: Colors.white,fontSize: 14,fontWeight: FontWeight.normal)),
                        TextButton(onPressed: () {
                          Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
                        }, child: Text(AppLocalizations.of(context)!.sign_in,style: GoogleFonts.poppins( decoration: TextDecoration.underline,color: Colors.white,fontSize: 16,fontWeight: FontWeight.normal)))
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
          hinText: AppLocalizations.of(context)!.enter_your_full_name,
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
          hinText: AppLocalizations.of(context)!.enter_your_user_name,
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
          hinText: AppLocalizations.of(context)!.enter_your_email,
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
          hinText: AppLocalizations.of(context)!.enter_your_password,
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
          hinText: AppLocalizations.of(context)!.re_password,
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return 'please, Enter same password';
            }
          },
          controller: rePasswordController,
          isSecure: true,
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

  void signUp(context) async{
     try {
       DialogUtils.showLoadingDialog(context,message: 'wating...');

      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      UserDM user=UserDM(id: credential.user!.uid,
          fullName:  fullNameController.text,
          userName: userNameController.text,
          email: emailController.text);

      addUserToFireStore(user);
       DialogUtils.hideDialog(context);
       DialogUtils.showMessageDialog(context,title: 'Done',content: 'user register Successfully', posActionTitle: 'Ok', posAction: (){
         Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
       });

    } on FirebaseAuthException catch (authError) {
       DialogUtils.hideDialog(context);

       String message;
      if (authError.code == AppConstant.weakPassword ) {
        message= AppConstant.weakPassMessage;
      } else if (authError.code == AppConstant.emailAlreadyInUse) {
        message= AppConstant.emailAlreadyInUseMessage ;
      }else{
        message= AppConstant.somethingWentWrongMessage;
      }
      DialogUtils.showMessageDialog(context,title: 'Error', content: message,posActionTitle: 'Ok');
    } catch (e) {
       DialogUtils.hideDialog(context);
     DialogUtils.showMessageDialog(context,title: 'Error',content: e.toString(),posActionTitle: 'Ok');
    }
  }

  void addUserToFireStore(UserDM user)async{
    CollectionReference collectionReference=FirebaseFirestore.instance.collection('user');
    DocumentReference newUserDoc=collectionReference.doc(user.id);
   await newUserDoc.set(user.toFireStore() );
  }
}
