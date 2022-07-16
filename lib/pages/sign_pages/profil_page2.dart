import 'package:flutter/material.dart';
import 'package:smooth_app/Data_Base_Api/D_B_configuration.dart';
import 'package:smooth_app/generic_lib/buttons/smooth_action_button.dart';
import 'package:smooth_app/generic_lib/dialogs/smooth_alert_dialog.dart';
import 'package:smooth_app/helpers/user_management_helper.dart';
import 'package:smooth_app/pages/page_manager.dart';
import 'package:smooth_app/pages/sign_pages/profile_page.dart';
import 'package:smooth_app/pages/user_preferences_page.dart';

import 'header_widget.dart';
import 'theme_helper.dart';



class ProfilPage2 extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _ProfilPage2State();
  }
}

class _ProfilPage2State extends State<ProfilPage2>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _displayNameController ;
  late TextEditingController _displayLastNameController ;
  late TextEditingController _displayAgeController ;
  late TextEditingController _displayLengthController ;
  late TextEditingController _displayWeightController ;
  late TextEditingController _displaymailController ;
@override
  void initState() {
    super.initState();
    _displaymailController = TextEditingController();
    _displayWeightController =TextEditingController();
    _displayLengthController =TextEditingController();
    _displayAgeController =TextEditingController();
    _displayLastNameController =TextEditingController();
    _displayNameController =TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    
    _displayNameController.addListener(() { });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Page',
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
      body:FutureBuilder<Map<String, dynamic>>(  
                 future:DataBaseConfiguration.getData(),
        builder:(context,snapshot){
       // ignore: always_put_control_body_on_new_line, avoid_print
        if( snapshot.hasData) 
        {
         final  Map<String, dynamic>? Data = snapshot.data ;
         
          if( _displayNameController.text==''){
         _displayNameController.text =  Data!['name'].toString().toString();
         _displayNameController.text =  Data['name'].toString();
         _displayLastNameController.text= Data['last_name'].toString();
         _displayAgeController.text =Data['age'].toString();
         _displayLengthController.text =Data['length'].toString();
         _displayWeightController.text =Data['weight'].toString();
         _displaymailController.text =Data['email'].toString();
          }
          return 
       SingleChildScrollView(
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
                        const SizedBox(height: 130,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration('First Name', 'Enter your first name'),
                            controller: _displayNameController,
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
                            decoration: ThemeHelper().textInputDecoration( 'Length', 'Enter your Length'),
                            controller: _displayLengthController,
                            keyboardType: TextInputType.phone,
                            validator: (String? val) {
                               if(val!.isEmpty){
                                return 'Please Enter Length';
                              }else{
                              return null;}
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
                              }else{
                              return null;}
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        
                        const SizedBox(height: 20.0),
                                  Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration( 'Mail', 'Enter your mail'),
                            controller: _displaymailController,
                            validator: (String? val) {
                               if(val!.isEmpty){
                                return 'Please Enter Mail';
                              }else{
                              return null;
                              }
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                     Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:<Widget>[
                            Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
                              child: Text(
                                'Cancel'.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: (){
                               Navigator.pop(context);
                            
                              
                            },
                          ),
                        ),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: Text(
                                ' Save '.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: (){
                            if (_formKey.currentState!.validate()) {
                              _save(context,Data);
                              }
                              
                            },
                          ),
                        ),

                          ]
                     ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
         }else{
      return SizedBox(
       height: MediaQuery.of(context).size.height / 1.3,
       child: const Center(
           child: CircularProgressIndicator(),
            ),
        );
        }
        }
      )
    );
  }
 Future<void> _save(BuildContext context, Map<String, dynamic>? Data) async {

if((_displayNameController.text !=Data!['name'].toString())||(_displayLastNameController.text !=Data['last_name'].toString())||(_displayAgeController.text !=Data['age'].toString())||(_displayLengthController.text !=Data['length'].toString())||(_displayWeightController.text !=Data['weight'].toString())||(_displaymailController.text !=Data['email'].toString())){
     showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SmoothAlertDialog(
          close: false,
          title: 'Modify',
          // ignore: prefer_const_constructors
          body: Text(
            'Are you sure ?',
          ),
          actions: <SmoothActionButton>[
            SmoothActionButton(
              text: 'No',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SmoothActionButton(
              text: 'Yes',
              onPressed: () {
                final List<String> attributes  = [Data['id'].toString(),_displayNameController.text,_displayLastNameController.text,_displayAgeController.text,_displayLengthController.text,
                  _displayWeightController.text,_displaymailController.text,Data['password'].toString()];
                  DataBaseConfiguration.updateData(attributes);
                if(_displaymailController.text != Data['email'].toString()){
                UserManagementHelper.logout();
         _displayNameController.text =  '';
         _displayLastNameController.text= '';
         _displayAgeController.text = '';
         _displayLengthController.text = '';
         _displayWeightController.text = '';
         _displaymailController.text = '';
                Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) =>
                               PageManager(),
                        ),
                      );
                }else
                {
                  
                Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) =>
                               PageManager(),
                        ),
                      );
                }
              
              },
            ),
          ],
        );
      },
    );

 
 
  }

  }

}


