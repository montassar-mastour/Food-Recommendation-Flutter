import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:openfoodfacts/model/Attribute.dart';
import 'package:openfoodfacts/model/AttributeGroup.dart';
import 'package:provider/provider.dart';
import 'package:smooth_app/Data_Base_Api/d_b_configuration.dart';
import 'package:smooth_app/data_models/product_preferences.dart';
import 'package:smooth_app/data_models/user_preferences.dart';
import 'package:smooth_app/generic_lib/buttons/smooth_action_button.dart';
import 'package:smooth_app/generic_lib/dialogs/smooth_alert_dialog.dart';
import 'package:smooth_app/helpers/user_management_helper.dart';
import 'package:smooth_app/pages/abstract_user_preferences.dart';
import 'package:smooth_app/pages/sign_pages/forgot_password_page.dart';
import 'package:smooth_app/pages/sign_pages/forgot_password_verification_page.dart';
import 'package:smooth_app/pages/sign_pages/login_page.dart';
import 'package:smooth_app/pages/sign_pages/profile_page.dart';
import 'package:smooth_app/pages/sign_pages/registration_page1.dart';
import 'package:smooth_app/pages/user_preferences_dev_mode.dart';
import 'package:smooth_app/pages/user_preferences_food.dart';
import 'package:smooth_app/pages/user_preferences_profile.dart';
import 'package:smooth_app/pages/user_preferences_settings.dart';
import 'package:smooth_app/themes/theme_provider.dart';

/// Preferences page for attribute importances
class UserPreferencesPage extends StatefulWidget {
  const UserPreferencesPage();

  @override
  State<UserPreferencesPage> createState() => _UserPreferencesPageState();
}

class _UserPreferencesPageState extends State<UserPreferencesPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final UserPreferences userPreferences = context.watch<UserPreferences>();
    final ThemeProvider themeProvider = context.watch<ThemeProvider>();
    final ThemeData themeData = Theme.of(context);
    final ProductPreferences productPreferences =
        context.watch<ProductPreferences>();
      
const double  _drawerIconSize = 24;
  const double _drawerFontSize = 17;
  final List<ListTile> myList =[    
     ListTile(
                leading: Icon(Icons.screen_lock_landscape_rounded, size: _drawerIconSize, color: Color.fromARGB(255, 77, 163, 233)),
                title: Text('Profil Page', style: TextStyle(fontSize: 17, color: Color.fromARGB(255, 77, 163, 233)),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute<Widget>(builder: (BuildContext context) => ProfilePage()));
                },
              ),
                    
              ListTile(
                leading: Icon(Icons.password_rounded, size: _drawerIconSize,color: Color.fromARGB(255, 77, 163, 233)),
                title: Text('Forgot Password Page',style: TextStyle(fontSize: _drawerFontSize,color: Color.fromARGB(255, 77, 163, 233)),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute<Widget>(builder: (BuildContext context) => const ForgotPasswordPage()),);
                },
              ),
              
              ListTile(
                leading: Icon(Icons.verified_user_sharp, size: _drawerIconSize,color: Color.fromARGB(255, 77, 163, 233)),
                title: Text('Verification Page',style: TextStyle(fontSize: _drawerFontSize,color: Color.fromARGB(255, 77, 163, 233)),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute<Widget>(builder: (BuildContext context) => const ForgotPasswordVerificationPage()), );
                },
              ),
              
              ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Color.fromARGB(255, 77, 163, 233)),
                title: Text('Logout',style: TextStyle(fontSize: _drawerFontSize,color: Color.fromARGB(255, 77, 163, 233)),),
                onTap: () => _confirmLogout(context,productPreferences,userPreferences),
              ),];
              final List<ListTile> myList0 =[    
              ListTile(
                leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Color.fromARGB(255, 77, 163, 233)),
                title: Text('Login Page', style: TextStyle(fontSize: _drawerFontSize, color: Color.fromARGB(255, 77, 163, 233)),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute<Widget>(builder: (BuildContext context) => LoginPagee(userPreferences:userPreferences,productPreferences:productPreferences)),);
                },
              ),
      
              ListTile(
                leading: Icon(Icons.person_add_alt_1, size: _drawerIconSize,color: Color.fromARGB(255, 77, 163, 233)),
                title: Text('Registration Page',style: TextStyle(fontSize: _drawerFontSize,color: Color.fromARGB(255, 77, 163, 233)),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute<Widget>(builder: (BuildContext context) => RegistrationPage()),);
                },
              ),
              
              ListTile(
                leading: Icon(Icons.password_rounded, size: _drawerIconSize,color: Color.fromARGB(255, 77, 163, 233),),
                title: Text('Forgot Password Page',style: TextStyle(fontSize: _drawerFontSize,color: Color.fromARGB(255, 77, 163, 233)),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute<Widget>(builder: (BuildContext context) => const ForgotPasswordPage()),);
                },
              ),
              
              ListTile(
                leading: Icon(Icons.verified_user_sharp, size: _drawerIconSize,color: Color.fromARGB(255, 77, 163, 233),),
                title: Text('Verification Page',style: TextStyle(fontSize: _drawerFontSize,color: Color.fromARGB(255, 77, 163, 233)),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute<Widget>(builder: (BuildContext context) => const ForgotPasswordVerificationPage()), );
                },
              ),];

    Widget  Drawer_name() {
     return DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 1.0],
                    colors: [ Theme.of(context).primaryColor,Theme.of(context).colorScheme.secondary,],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text('Your Profil',
                    style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              );
  }
  final List<Widget> childrenn = <Widget>[];
  childrenn.add(Drawer_name());
  setState(() {});
  if(DataBaseConfiguration.user != null){
  for (int i = 0; i < myList.length; i++) {
  childrenn.add(myList[i]);
  childrenn.add(Divider(color: Theme.of(context).primaryColor, height: 1,));
}}else{
    for (int i = 0; i < myList.length; i++) {
  childrenn.add(myList0[i]);
  childrenn.add(Divider(color: Theme.of(context).primaryColor, height: 1,));
}
}
  setState(() {});
    final List<AbstractUserPreferences> items = <AbstractUserPreferences>[
      // UserPreferencesProfile(
      //   setState: setState,
      //   context: context,
      //   userPreferences: userPreferences,
      //   productPreferences: productPreferences, 
      //   appLocalizations: appLocalizations,
      //   themeData: themeData,
      // ),
      UserPreferencesFood(
        productPreferences: productPreferences,
        setState: setState,
        context: context,
        userPreferences: userPreferences,
        appLocalizations: appLocalizations,
        themeData: themeData,
      ),
        UserPreferencesSettings(
        themeProvider: themeProvider,
        setState: setState,
        context: context,
        userPreferences: userPreferences,
        appLocalizations: appLocalizations,
        themeData: themeData,
      ),
   
    ];
    if (userPreferences.devMode > 0) {
      items.add(
        UserPreferencesDevMode(
          setState: setState,
          context: context,
          userPreferences: userPreferences,
          appLocalizations: appLocalizations,
          themeData: themeData,
        ),
      );
    }
    final List<Widget> children = <Widget>[];
    for (final AbstractUserPreferences abstractUserPreferences in items) {
      children.addAll(abstractUserPreferences.getContent());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).colorScheme.secondary,]
              )
          ),
        ),
       
      ),
      drawer: Drawer(
        child: Container(
          decoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 1.0],
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  ]
              )
          ) ,
          child: ListView(
            children: childrenn
          ),
        ),
      ),
      body: ListView(children: children),
    );
  }
  void _confirmLogout(BuildContext context, ProductPreferences productPreferences, UserPreferences userPreferences) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SmoothAlertDialog(
          close: false,
          title: localizations.sign_out,
          body: Text(
            localizations.sign_out_confirmation,
          ),
          actions: <SmoothActionButton>[
            SmoothActionButton(
              text: localizations.yes,
              onPressed: () async {
                UserManagementHelper.logout();
                FacebookAuth.instance.logOut();
                 final  GoogleSignIn _googleSign = GoogleSignIn(scopes: <String>['email']);
                 _googleSign.disconnect();
                await context.read<ProductPreferences>().resetImportances();
             final  List<AttributeGroup> lis=  productPreferences.attributeGroups!;
               for(final AttributeGroup attgrp in lis){
               final  List<Attribute> lis2 = attgrp.attributes!;
                 for(final Attribute att in lis2){
                 final  String ch='who_${att.id.toString()}';
                userPreferences.setWHO(ch,'');
                 }
               }
                   Navigator.push(context, MaterialPageRoute<Widget>(builder: (BuildContext context) =>const UserPreferencesPage()));
                   setState(() {});
              },
            ),
            SmoothActionButton(
              text: localizations.no,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
 