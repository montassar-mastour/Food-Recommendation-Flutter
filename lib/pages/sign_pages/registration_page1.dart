import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart' as pre ;
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:smooth_app/data_models/product_preferences.dart';
import 'package:smooth_app/data_models/user_preferences.dart';
import 'package:smooth_app/generic_lib/buttons/smooth_action_button.dart';
import 'package:smooth_app/generic_lib/dialogs/smooth_alert_dialog.dart';
import 'package:smooth_app/language/language.dart';
import 'package:smooth_app/pages/abstract_user_preferences.dart';
import 'package:smooth_app/pages/sign_pages/registration_page2.dart';
import 'package:smooth_app/pages/user_preferences_food.dart'; 
import 'header_widget.dart';
import 'theme_helper.dart';



class RegistrationPage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
    final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _displayLastNameController = TextEditingController();
  final TextEditingController _displayAgeController = TextEditingController();
  final TextEditingController _displayLengthController = TextEditingController();
  final TextEditingController _displayWeightController = TextEditingController();

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
      List <Widget> lis = items.getContent();
    Language.build(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text( '${Language.registration_page} 1/2',
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
              margin: const EdgeInsets.fromLTRB(5, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // GestureDetector(
                        //   child: Stack(
                        //     children: [
                        //      Container(
                        //         padding: const EdgeInsets.all(10),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(100),
                        //           border: Border.all(
                        //               width: 5, color: Colors.white),
                        //           color: Colors.white,
                        //           boxShadow: const [
                        //             BoxShadow(
                        //               color: Colors.black12,
                        //               blurRadius: 20,
                        //               offset: Offset(5, 5),
                        //             ),
                        //           ],
                        //         ),
                        //         child: Icon(
                        //           Icons.person,
                        //           color: Colors.grey.shade300,
                        //           size: 80.0,
                        //         ),
                        //       ),
                              
                        //     ],
                        //   ),
                        // // ),
                        const SizedBox(height: 100,),
                        for(Widget item in lis ) item,
                        const SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(Language.first_name!, Language.Enter_your_first_name!),
                            controller: _displayNameController,
                            validator: (String? val) {
                               if(val!.isEmpty){
                                return Language.Please_Enter_Your_First_Name;
                              }else{
                              return null;
                            }},
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(Language.last_name!, Language.Enter_your_last_name!),
                            controller: _displayLastNameController,
                         validator: (String? val) {
                               if(val!.isEmpty){
                                return Language.Please_Enter_Your_Last_Name;
                              }else{
                              return null;
                            }}, ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(Language.age!,Language.Enter_your_Age!),
                            controller: _displayAgeController,
                            keyboardType: TextInputType.phone,
                            validator: (String? val) {
                               if(val!.isEmpty){
                                return Language.Please_Enter_Age;
                              }else
                              if(!RegExp(r'^(\d+)*$').hasMatch(val)){
                                return Language.Enter_a_valid_Age;
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                                  Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(Language.weight!,Language.Enter_your_Weight!),
                            controller: _displayWeightController,
                            keyboardType: TextInputType.phone,
                            validator: (String? val) {
                               if(val!.isEmpty){
                                return Language.Please_Enter_Weight;
                              }else
                              if(!RegExp(r'^(\d+)*$').hasMatch(val)){
                                return Language.Enter_a_valid_Weight;
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                                  Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(Language.length!,Language.Enter_your_Length!),
                            controller: _displayLengthController,
                            keyboardType: TextInputType.phone,
                            validator: (String? val) {
                               if(val!.isEmpty){
                                return Language.Please_Enter_Length;
                              }else{
                              return null;
                              }
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                     
                        const SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (FormFieldState<bool> state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text(Language.I_accept_all_terms_and_conditions!, style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme.of(context).errorColor,fontSize: 12,),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (bool? value) {
                            if (!checkboxValue) {
                              return Language.You_need_to_accept_terms_and_conditions;
                            } else {
                              return null;
                            }
                          },
                        ),

                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                Language.Next!.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async{
                            if (_formKey.currentState!.validate()) {
                               await  sign1();
                                
                              }
                              
                            },
                          ),
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
 Future<void> sign1() async {
 
  final Location location = Location();

bool _serviceEnabled;
PermissionStatus _permissionGranted;
    LocationData _locationData;

        _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
   }

   _permissionGranted = await location.hasPermission();
   if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();

  }

     showDialog<void>(
              context: context,
              builder: (BuildContext context) => FutureBuilder<LocationData>(
            future: location.getLocation() ,
              builder:(BuildContext context,AsyncSnapshot<LocationData> snapshot){
                        if(!snapshot.hasData) 
                        {
                          return SizedBox(
       height: MediaQuery.of(context).size.height / 1.3,
       child: const Center(
           child: CircularProgressIndicator(),
            ),
        );
                        }else{
                          //  return  locationn(snapshot.data!);
                          _locationData=snapshot.data!;
                              return  FutureBuilder<List<pre.Placemark>>(
            future: pre.placemarkFromCoordinates(_locationData.latitude!.toDouble(),_locationData.longitude!.toDouble()) ,
              builder:(BuildContext context,AsyncSnapshot<List<pre.Placemark>> snapshot){
                        if(!snapshot.hasData) 
                        {
                          return SizedBox(
       height: MediaQuery.of(context).size.height / 1.3,
       child: const Center(
           child: CircularProgressIndicator(),
            ),
        );
                        }else{
                           final List<pre.Placemark> placemarks = snapshot.data!;
                           final String local = '${placemarks.toList().first.country},${placemarks.toList().first.administrativeArea}' ;
                           final List<String> list=[_displayNameController.text,_displayLastNameController.text,_displayAgeController.text,_displayWeightController.text,_displayLengthController.text,local];
                                                 
                                                 return SmoothAlertDialog(
        body: const Text('Are you sure about your informations ?'),
        actions: <SmoothActionButton>[
          SmoothActionButton(
              text: 'No',
              onPressed: () =>    Navigator.pop(context),
                ),        
                 SmoothActionButton(
              text: 'Yes',
              onPressed: () =>    Navigator.push(context, MaterialPageRoute<Widget>(builder: (BuildContext context) => RegistrationPage2(list)),),
                 )  ],
      );

                        }
                        }
   );
                        }
                        }
   )
   );
  


                                
 }

Widget locationn(LocationData _locationData) {
   return  FutureBuilder<List<pre.Placemark>>(
            future: pre.placemarkFromCoordinates(_locationData.latitude!.toDouble(),_locationData.longitude!.toDouble()) ,
              builder:(BuildContext context,AsyncSnapshot<List<pre.Placemark>> snapshot){
                        if(!snapshot.hasData) 
                        {
                          return SizedBox(
       height: MediaQuery.of(context).size.height / 1.3,
       child: const Center(
           child: CircularProgressIndicator(),
            ),
        );
                        }else{
                           final List<pre.Placemark> placemarks = snapshot.data!;
                           final String local = '${placemarks.toList().first.country},${placemarks.toList().first.administrativeArea}' ;
                           final List<String> list=[_displayNameController.text,_displayLastNameController.text,_displayAgeController.text,_displayWeightController.text,_displayLengthController.text,local];
                                                 setState(() {});
                                                 return SmoothAlertDialog(
        body: const Text('hoo'),
        actions: <SmoothActionButton>[
          SmoothActionButton(
              text: 'okay',
              onPressed: () =>    Navigator.push(context, MaterialPageRoute<Widget>(builder: (BuildContext context) => RegistrationPage2(list)),),
                                                  ) ],
      );

                        }
                        }
   );


 }
}


