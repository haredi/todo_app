import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/constant_manager.dart';
import 'package:todo_app/core/strings_manager.dart';
import 'package:todo_app/database_manager/model/user_dm.dart';

import '../../../core/assets_manager.dart';
import '../../../core/reusable_components/custom_text_form_field.dart';
import '../../../core/routes_manager.dart';
import '../../../core/utils/dialog_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      AppLocalizations.of(context)!.email,
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
                      AppLocalizations.of(context)!.password,
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
                        onPressed: () {
                          signIn(context);
                        },
                        child: Text(AppLocalizations.of(context)!.sign_in,
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
                        Text(AppLocalizations.of(context)!.dont_have_account,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, RoutesManager.registerRoute);
                            },
                            child: Text(AppLocalizations.of(context)!.sign_up,
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)))
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
          hinText: AppLocalizations.of(context)!.password,
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

  void signIn(context) async {
    try {
      DialogUtils.showLoadingDialog(context,message: 'wating...');

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      UserDM.user= await getUserFromFireStore(credential.user!.uid);

      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          title: 'Done',
          content: 'user Log in Successfully',
          posActionTitle: 'Ok', posAction: () {
        Navigator.pushReplacementNamed(context, RoutesManager.homeRoute);
      });
    } on FirebaseAuthException catch (authError) {
      DialogUtils.hideDialog(context);

      String message;
      if (authError.code == AppConstant.invalidCredential) {
        message = AppConstant.wrongEmailOrPassMessage;
      } else {
        print('Hello:${authError.code.toString()}');
        message = 'Try again';
      }
      DialogUtils.showMessageDialog(context,
          title: 'Error', content: message, posActionTitle: 'Ok');
    } catch (e) {
     // DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          title: 'Error', content: e.toString(), posActionTitle: 'Ok');
    }
  }

  Future<UserDM>getUserFromFireStore(String uid)async{
    CollectionReference collectionReference=FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDoc=collectionReference.doc(uid);
    DocumentSnapshot documentSnapshot=await userDoc.get();
    var json=documentSnapshot.data() as Map<String, dynamic>;
    return UserDM.fromFireStore(json);
  }
}
