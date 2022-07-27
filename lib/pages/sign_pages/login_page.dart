// ignore_for_file: prefer_const_constructors, prefer_single_quotes, unused_local_variable, always_specify_types, prefer_final_locals

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:openfoodfacts/model/Attribute.dart';
import 'package:openfoodfacts/model/AttributeGroup.dart';
import 'package:provider/provider.dart';
import 'package:smooth_app/Data_Base_Api/d_b_configuration.dart';
import 'package:smooth_app/Data_Base_Api/user_management.dart';
import 'package:smooth_app/data_models/product_preferences.dart';
import 'package:smooth_app/data_models/user_preferences.dart';
import 'package:smooth_app/generic_lib/buttons/smooth_action_button.dart';
import 'package:smooth_app/generic_lib/dialogs/smooth_alert_dialog.dart';
import 'package:smooth_app/generic_lib/widgets/smooth_card.dart';
import 'package:smooth_app/helpers/user_management_helper.dart';
import 'package:smooth_app/language/language.dart';
import 'package:smooth_app/pages/page_manager.dart';
import 'package:smooth_app/pages/sign_pages/registration_page1.dart';
import 'package:smooth_app/pages/user_preferences_page.dart';

import 'forgot_password_page.dart';
import 'header_widget.dart';
import 'theme_helper.dart';

  class LoginPagee extends StatefulWidget{
     LoginPagee({Key? key, required this.userPreferences,required this.productPreferences}): super(key:key);
 final UserPreferences userPreferences;
 final ProductPreferences productPreferences;
    @override
    _LoginPageState createState() => _LoginPageState();
  }

class _LoginPageState extends State<LoginPagee>{

    bool _runningQuery = false;
  bool _wrongCredentials = false;
  final double _headerHeight = 250;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
   late GoogleSignIn _googleSignIn;
  Future<void> _login(BuildContext context,String mail, String pass) async {

    setState(() {
      _runningQuery = true;
      _wrongCredentials = false;
    });
    final bool login = await UserManagementHelper.login(
      UserManagement(
        email: mail,
        password: pass, 
      ),
    );
    if (login) {
     update_local(context);
      Navigator.push(context, MaterialPageRoute<Widget>(builder: (context) => PageManager()));  
    setState(() {});
                
    } else {
      setState(() {
        _runningQuery = false;
        _wrongCredentials = true;
      });
    }
  }
    @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
Language.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Language.sign_in_page!, 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container( 
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                child: Column(
                  children: [
                    Text(
                      'Hello',
                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      Language.signin_into_your_account!,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 5.0),
                    Form(
                      key: _formKey,
                        child: Column(
                          children: [
                        if (_wrongCredentials) ...<Widget>[
                   SmoothCard(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.red,
                      child: Text(Language.incorrect_username_or_password!),
                    ),
                    
                  ],
                  SizedBox(height: 30.0),
                             Container(
                          child: TextFormField(
                            obscureText: false,
                            decoration: ThemeHelper().textInputDecoration(Language.User_Name!, Language.Enter_your_user_name!
                                ),
                                controller: userIdController ,
                            validator: ( val) {
                              if (val!.isEmpty) {
                                return Language.Please_enter_your_username;
                              }else if(!UserManagementHelper.isEmailValid(val)) {
                                return Language.Invalid_Email;
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                            SizedBox(height: 30.0),
                            Container(
                          child: TextFormField(
                            obscureText: true,
                              decoration: ThemeHelper().textInputDecoration(Language.Password!, Language.Enter_your_password!),
                                controller:  passwordController,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return Language.Please_enter_your_password;
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                            SizedBox(height: 15.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,0,10,20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push( context, MaterialPageRoute<Widget>( builder: (context) => ForgotPasswordPage()), );
                                },
                                child: Text( Language.Forgot_your_password!, style: TextStyle( color: Colors.grey, ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('Sign In'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: (){
                                   if (_formKey.currentState!.validate()) {
                               _login(context,userIdController.text,passwordController.text);
                                     }
                              
                                  
                                },
                              ),
                            ),
                            
                                                    SizedBox(height: 30.0),
                        Text(Language.Or_sign_in_using_social_media!,  style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.googlePlus, size: 40,
                                color: HexColor("#EC2D2F"),),
                              onTap: () async {
                                
                                _googleSignIn = GoogleSignIn(scopes: <String>['email']);
                                GoogleSignInAccount? _user =await _googleSignIn.signIn() ;

                      setState(() {
                       });
                           if (_user != null) {
                            setState(() {
                                        _login(context,_user.email,_user.id);
                                      });
                      }
                     _googleSignIn.signInSilently();
                        
                                
                              
                              },
                            ),
                            SizedBox(width: 30.0,),
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.facebook, size: 40,
                                color: HexColor("#3E529C"),),
                              onTap: () {
                                   final result= FacebookAuth.instance.login( 
                                    permissions: ["public_profile","email"]
                                  );
                                    
                                    final request= result.then((value){
                                    FacebookAuth.instance.getUserData().then((userdata) {
                                      setState(() {
                                        _login(context,userdata["email"].toString(),userdata["id"].toString());
                                      });
                                    });
                                  });
                               
                                  
                              },
                            ),
                          ],
                        ),
                        Container(
                              margin: EdgeInsets.fromLTRB(10,20,10,20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: Language.Dont_have_an_account),
                                    TextSpan(
                                      text: Language.Create,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute<Widget>(builder: (context) => RegistrationPage()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                                    ),
                                  ]
                                )
                              ),
                            ),
                          ],
                        )
                        
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );

  }
  Future<void> update_local(BuildContext context)async {
         final AttributeGroup group= widget.productPreferences.getAttributeGroup('allergens_no_gluten');
     final Map<String, dynamic> getUser = await DataBaseConfiguration.getData();
    final Map<String,dynamic> get =  await DataBaseConfiguration.getDataAllergy(getUser['id'].toString());
     Attribute attributt;
     for(attributt in group.attributes!){
       if(attributt.id.toString()=='allergens_no_Pêche'){
           widget.userPreferences.setImportance(attributt.id.toString(), get['allergens_no_Peche'].toString()) ;
                 widget.userPreferences.setWHO(attributt.id.toString(), get['who_allergens_no_Peche'].toString() );
                 
       }else{
                 widget.userPreferences.setImportance(attributt.id.toString(), get[attributt.id].toString()) ;
                 widget.userPreferences.setWHO(attributt.id.toString(), get['who_${attributt.id}'].toString() );
       }}
                  widget.productPreferences.notify();
                  
 }
}
