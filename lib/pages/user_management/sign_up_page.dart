// ignore_for_file: always_specify_types, prefer_final_locals, unnecessary_new, noop_primitive_operations, prefer_interpolation_to_compose_strings, avoid_void_async, prefer_const_constructors, await_only_futures
                                                              
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart' as pre ;
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:smooth_app/Data_Base_Api/d_b_configuration.dart';
import 'package:smooth_app/Data_Base_Api/user_management.dart';
import 'package:smooth_app/data_models/product_preferences.dart';
import 'package:smooth_app/data_models/user_preferences.dart';
import 'package:smooth_app/generic_lib/buttons/smooth_action_button.dart';
import 'package:smooth_app/generic_lib/dialogs/smooth_alert_dialog.dart';
import 'package:smooth_app/generic_lib/widgets/smooth_text_form_field.dart';
import 'package:smooth_app/helpers/user_management_helper.dart';
import 'package:smooth_app/language/language.dart';
import 'package:smooth_app/pages/abstract_user_preferences.dart';
import 'package:smooth_app/pages/user_preferences_food.dart';

/// Sign Up Page. Pop's true if the sign up was successful.
class SignUpPage extends StatefulWidget {
  const SignUpPage();

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  static const double space = 10;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _displayLastNameController = TextEditingController();
  final TextEditingController _displayAgeController = TextEditingController();
  final TextEditingController _displayLengthController = TextEditingController();
  final TextEditingController _displayWeightController = TextEditingController();
//   final TextEditingController _displayFRController = TextEditingController();
//  final TextEditingController _displayAllergyController = TextEditingController();
//  final TextEditingController _displayAnotherAllergyController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final Size size = MediaQuery.of(context).size;
        Language.build(context);
            final ThemeData themeData = Theme.of(context);
            final UserPreferences userPreferences = context.watch<UserPreferences>();
               final ProductPreferences productPreferences =
        context.watch<ProductPreferences>();
final AbstractUserPreferences items =   
  UserPreferencesFood(
        productPreferences: productPreferences,
        setState: setState,
        context: context,
        userPreferences: userPreferences,
        appLocalizations: appLocalizations,
        themeData: themeData,
      );
       final List<Widget> allchildren = <Widget>[];
                    allchildren.addAll(items.getContent());
       allchildren.add( SmoothTextFormField(
              textInputType: TextInputType.name,
              type: TextFieldTypes.PLAIN_TEXT,
              controller: _displayNameController,
              textInputAction: TextInputAction.next,
              hintText: Language.first_name!,
              prefixIcon: const Icon(Icons.person),
              autofillHints: const <String>[AutofillHints.name],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return appLocalizations.sign_up_page_display_name_error_empty;
                }
                return null;
                },
             ));
             allchildren.add(const SizedBox(height: space));
             allchildren.add(SmoothTextFormField(
              textInputType: TextInputType.name,
              type: TextFieldTypes.PLAIN_TEXT,
              controller: _displayLastNameController,
              textInputAction: TextInputAction.next,
              hintText: Language.last_name!,
              prefixIcon: const Icon(Icons.person),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the display Last name you want to use';
                }
                return null;
              },
            ));
            allchildren.add(const SizedBox(height: space));
            allchildren.add(SmoothTextFormField(
              type: TextFieldTypes.PLAIN_TEXT,
              controller: _displayAgeController,
              textInputAction: TextInputAction.next,
              hintText: Language.age!,
              textInputType :TextInputType.number,
              prefixIcon: const Icon(Icons.person),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the display Age you want to use';
                }
                return null;
              },
            ));
            allchildren.add(const SizedBox(height: space));
            allchildren.add(SmoothTextFormField(
              type: TextFieldTypes.PLAIN_TEXT,
              controller: _displayLengthController,
              textInputAction: TextInputAction.next,
              hintText: Language.length!,
              textInputType :TextInputType.number,
              prefixIcon: const Icon(Icons.person),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the display Length you want to use';
                }
                return null;
              },
            ));
            allchildren.add(const SizedBox(height: space));
            allchildren.add(SmoothTextFormField(
              type: TextFieldTypes.PLAIN_TEXT,
              controller: _displayWeightController,
              textInputAction: TextInputAction.next,
              hintText: Language.weight!,
              textInputType :TextInputType.number,
              prefixIcon: const Icon(Icons.person),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the display Weight you want to use';
                }
                return null;
              },
             ));

            // allchildren.add( SmoothTextFormField(
            //   type: TextFieldTypes.PLAIN_TEXT,
            //   controller: _displayFRController,
            //   textInputAction: TextInputAction.next,
            //   hintText: Language.food_restriction!,
            //   prefixIcon: const Icon(Icons.food_bank),
            //   validator: (String? value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter the display food restraction you want to use';
            //     }
            //     return null;
            //   },
            // ));
            //   allchildren.add( const SizedBox(height: space));
            // allchildren.add( SmoothTextFormField(
            //   type: TextFieldTypes.PLAIN_TEXT,
            //   controller: _displayAllergyController,
            //   textInputAction: TextInputAction.next,
            //   hintText: Language.allergy!,
            //   prefixIcon: const Icon(Icons.person),
            //   validator: (String? value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter the display Allergy you want to use';
            //     }
            //     return null;
            //   },

            // ));
            // allchildren.add(const SizedBox(height: space));
            //  SmoothTextFormField(
            //   type: TextFieldTypes.PLAIN_TEXT,
            //   controller: _displayAnotherAllergyController,
            //   textInputAction: TextInputAction.next,
            //   hintText: Language.another_allergy!,
            //   prefixIcon: const Icon(Icons.person),
            //   validator: (String? value) {
            //     return null;
            //   },
            // );
           allchildren.add( const SizedBox(height: space));
            allchildren.add(SmoothTextFormField(
              textInputType: TextInputType.emailAddress,
              type: TextFieldTypes.PLAIN_TEXT,
              controller: _emailController,
              textInputAction: TextInputAction.next,
              hintText: appLocalizations.sign_up_page_email_hint,
              prefixIcon: const Icon(Icons.email),
              autofillHints: const <String>[AutofillHints.email],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return appLocalizations.sign_up_page_email_error_empty;
                }
                if (!UserManagementHelper.isEmailValid(value)) {
                  return appLocalizations.sign_up_page_email_error_invalid;
                }
                return null;
              },
            ));
           
           allchildren.add( const SizedBox(height: space));
           allchildren.add( SmoothTextFormField(
              type: TextFieldTypes.PASSWORD,
              controller: _password1Controller,
              textInputAction: TextInputAction.next,
              hintText: appLocalizations.sign_up_page_password_hint,
              prefixIcon: const Icon(Icons.vpn_key),
              autofillHints: const <String>[AutofillHints.password],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return appLocalizations.sign_up_page_password_error_empty;
                }
                if (!UserManagementHelper.isPasswordValid(value)) {
                  return appLocalizations.sign_up_page_password_error_invalid;
                }
                return null;
              },
            ));
            allchildren.add(const SizedBox(height: space));
            allchildren.add(SmoothTextFormField(
              type: TextFieldTypes.PASSWORD,
              controller: _password2Controller,
              textInputAction: TextInputAction.next,
              hintText: appLocalizations.sign_up_page_confirm_password_hint,
              prefixIcon: const Icon(Icons.vpn_key),
              autofillHints: const <String>[
                AutofillHints.password,
              ],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return appLocalizations
                      .sign_up_page_confirm_password_error_empty;
                }
                if (value != _password1Controller.text) {
                  return appLocalizations
                      .sign_up_page_confirm_password_error_invalid;
                }
                return null;
              },
            ));
            allchildren.add(const SizedBox(height: space));

            allchildren.add(const SizedBox(height: space));
            allchildren.add(ElevatedButton(
              onPressed: () async => _signUp(),
              child: Text(
                appLocalizations.sign_up_page_action_button,
                style: theme.textTheme.bodyText2?.copyWith(
                  fontSize: 18.0,
                  color: theme.colorScheme.surface,
                ),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                  Size(size.width * 0.5, theme.buttonTheme.height + 10),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(300.0),
                  ),
                ),
              ),
            ));


      
    // TODO(monsieurtanuki): translations
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.sign_up_page_title,
          style: TextStyle(color: theme.colorScheme.onBackground),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.colorScheme.primary),
      ),
      body: Form(
        onChanged: () => setState(() {}),
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          children: allchildren,
          
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    setState(() {});
    if (!_formKey.currentState!.validate() ) {
      return;
    }
    Location location = new Location();

bool _serviceEnabled;
PermissionStatus _permissionGranted;
    LocationData _locationData;

        _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
    return;
   }
   }

   _permissionGranted = await location.hasPermission();
   if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
    return;
  }
  }

   _locationData = await location.getLocation();
  
   List<pre.Placemark> placemarks = await pre.placemarkFromCoordinates(_locationData.latitude!.toDouble(),_locationData.longitude!.toDouble());
  final String local = placemarks.toList().first.country.toString()+',' + placemarks.toList().first.administrativeArea.toString() ;
        String hashedPassword = Crypt.sha256(_password1Controller.text).toString();
    final UserManagement user = UserManagement(
      email: _emailController.text,
      password: hashedPassword,
    );
   DataBaseConfiguration.addData([_displayNameController.text,_displayLastNameController.text,_displayAgeController.text,_displayLengthController.text,_displayWeightController.text,_emailController.text,hashedPassword,local]);
  


await showDialog<void>(
      context: context,
      builder: (BuildContext context) => FutureBuilder<bool>(
            future:UserManagementHelper.login( UserManagement(
        email: _emailController.text,
        password:  hashedPassword,
      ),) ,
              builder:(context,snapshot){
                        if(!snapshot.hasData) 
                        {
                        return SizedBox(
       height: MediaQuery.of(context).size.height / 1.3,
       child: Center(
           child: CircularProgressIndicator(),
            ),
        );
                        }
                        else{
                          
                          loginn(snapshot.hasData,user);
                          allergyData();
                          return SmoothAlertDialog(
        body: Text(AppLocalizations.of(context)!.sign_up_page_action_ok),
        actions: <SmoothActionButton>[
          SmoothActionButton(
              text: AppLocalizations.of(context)!.okay,
              onPressed: () => Navigator.of(context).pop()),
        ],
      );
                        }
               }
           )
);

  }
void loginn (bool log,UserManagement user) async {
if(log){
await UserManagementHelper.put(user);
    Navigator.of(context).pop<bool>(true);
}
}

  void allergyData() async {
       final Map<String, dynamic> data = await DataBaseConfiguration.getData();
   DataBaseConfiguration.addDataAllergy(data['id'].toString());
  }
}
