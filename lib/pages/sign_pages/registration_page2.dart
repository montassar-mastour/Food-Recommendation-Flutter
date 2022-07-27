import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_app/Data_Base_Api/d_b_configuration.dart';
import 'package:smooth_app/Data_Base_Api/user_management.dart';
import 'package:smooth_app/generic_lib/buttons/smooth_action_button.dart';
import 'package:smooth_app/generic_lib/dialogs/smooth_alert_dialog.dart';
import 'package:smooth_app/helpers/user_management_helper.dart';
import 'package:smooth_app/language/language.dart';
import 'package:smooth_app/pages/page_manager.dart';
import 'package:smooth_app/pages/user_preferences_page.dart';
import 'header_widget.dart';
import 'theme_helper.dart';

class RegistrationPage2 extends StatefulWidget {
  const RegistrationPage2(
    this._list,
 );

  final List<String> _list;

  @override
  State<RegistrationPage2> createState() => _RegistrationPage2State();
}

class _RegistrationPage2State extends State<RegistrationPage2> {
    late GoogleSignIn _googleSignIn;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Language.build(context);
        final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title:  Text('${Language.registration_page} 2/2',
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                ),
               
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                                             const SizedBox(height: 15.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(Language.email!, Language.Enter_your_email!),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: (String? val) {
                               if(val!.isEmpty){
                                return Language.Please_enter_your_Email;
                              }else if(!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return Language.Enter_a_valid_email_address;
                              
                              }else {
                                return null;
                              }
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: true,
                            controller: _password1Controller,
                            decoration: ThemeHelper().textInputDecoration(
                                Language.Password!, Language.Enter_your_password!),
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return Language.Please_enter_your_password;
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 15.0),
                        Container(
                          child: TextFormField(
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                Language.ConfirmPassword!, Language.Confirm_your_password!),
                                controller: _password2Controller,
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return Language.Please_enter_your_password;
                              }else if (val != _password1Controller.text) {
                  return Language.Passwords_dont_match;
                }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                    
                         Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                Language.Register!.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                 _signUp(_emailController.text,_password1Controller.text);
                              }
                            },
                          ),
                        ),
                         
                        const SizedBox(height: 30.0),
                         Text(Language.Or_sign_up_using_social_media!,  style: TextStyle(color: Colors.grey),),
                        const SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.googlePlus, size: 40,
                                color: HexColor('#EC2D2F'),),
                              onTap: ()async {
                                
                                _googleSignIn = GoogleSignIn(scopes: <String>['email']);
                                final GoogleSignInAccount? _user =await _googleSignIn.signIn() ;
                                  
                           if (_user != null) {
                            setState(() {
                              // print(_user.id);
                                        _signUp(_user.email,_user.id);
                                      });
                      }
                     _googleSignIn.signInSilently();
                        },
                            ),
                   const SizedBox(width: 30.0,),
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.facebook, size: 40,
                                color: HexColor('#3E529C'),),
                              onTap: () {
                                   final Future<LoginResult> result= FacebookAuth.instance.login( 
                                    permissions: ['public_profile','email']
                                  );
                                    
                                    final Future<void> request= result.then((LoginResult value){
                                    FacebookAuth.instance.getUserData().then((Map<String, dynamic> userdata) {
                                      setState(() {
                                        _signUp(userdata['email'].toString(),userdata['id'].toString());
                                      });
                                    });
                                  });
                               
                                  
                              },
                            ),
                             
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _signUp(String mail, String pass) async {
    setState(() {});
 
  final  String hashedPassword = Crypt.sha256(pass).toString();
    // final UserManagement user = UserManagement(
    //   email: mail,
    //   password: hashedPassword,
    // );
   final List<String> list=widget._list;
     bool test = await DataBaseConfiguration.email_test(mail);
     if(test){
      showDialog<void>(
        context: context,
       builder: (BuildContext context) {
      return  SmoothAlertDialog(
        body: const Text('Error, this email already used'),
        actions: <SmoothActionButton>[
          SmoothActionButton(
              text: AppLocalizations.of(context)!.okay,
              onPressed: () =>  Navigator.pushReplacement(context, MaterialPageRoute<Widget>(builder: (BuildContext context) => PageManager()))),
        ],
      );}
      );
     }
     else{
   DataBaseConfiguration.addData([list[0],list[1],list[2],list[3],list[4],mail,hashedPassword,list[5]]);
final UserManagement user = UserManagement(
        email: mail,
        password: hashedPassword,
      );
showDialog<void>(
      context: context,
      builder: (BuildContext context) => FutureBuilder<bool>(
            future:UserManagementHelper.login( UserManagement(
        email: mail,
        password: pass,
      ),) ,
              builder:(BuildContext context,AsyncSnapshot<bool> snapshot){
                        if(!snapshot.hasData) 
                        {
                        return SizedBox(
       height: MediaQuery.of(context).size.height / 1.3,
       child: const Center(
           child: CircularProgressIndicator(),
            ),
        );
                        }
                        else{
                          if(snapshot.data==true){
                          loginn(snapshot.hasData,user);
                          allergyData();
                          return SmoothAlertDialog(
        body: Text(AppLocalizations.of(context)!.sign_up_page_action_ok),
        actions: <SmoothActionButton>[
          SmoothActionButton(
              text: AppLocalizations.of(context)!.okay,
              onPressed: () =>  Navigator.pushReplacement(context, MaterialPageRoute<Widget>(builder: (BuildContext context) => PageManager()))),
        ],
      );}
      else{
        return SmoothAlertDialog(
        body:  Text(Language.Error_please_repeat_your_process!),
        actions: <SmoothActionButton>[
          SmoothActionButton(
              text: AppLocalizations.of(context)!.okay,
              onPressed: () =>  Navigator.pushReplacement(context, MaterialPageRoute<Widget>(builder: (BuildContext context) => PageManager()))),
        ],
      );

      }
                        }
               }
           )
);
  }
  }
void loginn (bool log,UserManagement user) {
if(log){
 UserManagementHelper.put(user);
    // Navigator.of(context).pop<bool>(true);
}
}

  Future<void> allergyData() async {
       final Map<String, dynamic> data = await DataBaseConfiguration.getData();
   DataBaseConfiguration.addDataAllergy(data['id'].toString());
  }

}