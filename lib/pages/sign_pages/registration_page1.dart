import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as pre ;
import 'package:location/location.dart';
import 'package:smooth_app/generic_lib/buttons/smooth_action_button.dart';
import 'package:smooth_app/generic_lib/dialogs/smooth_alert_dialog.dart';
import 'package:smooth_app/pages/sign_pages/registration_page2.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page 1/2',
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
                        const SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('First Name', 'Enter your first name'),
                            controller: _displayNameController,
                            validator: (String? val) {
                               if(val!.isEmpty){
                                return 'Please Enter Your First Name';
                              }else{
                              return null;
                            }},
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('Last Name', 'Enter your last name'),
                            controller: _displayLastNameController,
                         validator: (String? val) {
                               if(val!.isEmpty){
                                return 'Please Enter Your Last Name';
                              }else{
                              return null;
                            }}, ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('Age','Enter your Age'),
                            controller: _displayAgeController,
                            keyboardType: TextInputType.phone,
                            validator: (String? val) {
                               if(val!.isEmpty){
                                return 'Please Enter Age';
                              }else
                              if(!RegExp(r'^(\d+)*$').hasMatch(val)){
                                return 'Enter a valid Age';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                                  Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration( 'Weight','Enter your Weight'),
                            controller: _displayWeightController,
                            keyboardType: TextInputType.phone,
                            validator: (String? val) {
                               if(val!.isEmpty){
                                return 'Please Enter Weight';
                              }else
                              if(!RegExp(r'^(\d+)*$').hasMatch(val)){
                                return 'Enter a valid Weight';
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                                  Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration( 'Length', 'Enter your Length'),
                            controller: _displayLengthController,
                            keyboardType: TextInputType.phone,
                            validator: (String? val) {
                               if(val!.isEmpty){
                                return 'Please Enter Length';
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
                                    const Text('I accept all terms and conditions.', style: TextStyle(color: Colors.grey),),
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
                              return 'You need to accept terms and conditions';
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
                                'Next'.toUpperCase(),
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


