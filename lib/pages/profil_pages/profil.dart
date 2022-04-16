// ignore_for_file: unused_local_variable, prefer_final_locals, non_constant_identifier_names, always_specify_types
import 'package:flutter/material.dart';
import 'package:smooth_app/Data_Base_Api/D_B_configuration.dart';
import 'package:smooth_app/data_models/user_preferences.dart';
import 'package:smooth_app/generic_lib/buttons/smooth_action_button.dart';
import 'package:smooth_app/generic_lib/dialogs/smooth_alert_dialog.dart';
import 'package:smooth_app/helpers/ui_helpers.dart';
import 'package:smooth_app/helpers/user_management_helper.dart';
import 'package:smooth_app/pages/onboarding/onboarding_flow_navigator.dart';
import 'package:smooth_app/pages/page_manager.dart';
import 'package:smooth_app/pages/user_preferences_page.dart';


/// Actual nutrition page, with data already loaded.
// ignore: must_be_immutable
class ProfilPage extends StatefulWidget {

  const ProfilPage();


  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

 

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController lastname_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();
  TextEditingController age_controller = TextEditingController();
  TextEditingController length_controller = TextEditingController();
  TextEditingController weight_controller = TextEditingController();
  TextEditingController f_r_controller = TextEditingController();
    TextEditingController allergy_controller = TextEditingController();
      TextEditingController another_alergy_controller = TextEditingController();
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();


 

  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    
       return Scaffold(
      // ignore: prefer_const_constructors
      appBar: AppBar(title: Text('Profil')),
      body: FutureBuilder<Map<String, dynamic>>(  
                 future:DataBaseConfiguration.getData(),
        builder:(context,snapshot){
       // ignore: always_put_control_body_on_new_line, avoid_print
       if(snapshot.hasError) print(snapshot.error);
        if( snapshot.hasData) 
        {
            Map<String,dynamic>? Data = snapshot.data ;
            final List<Widget> children = <Widget>[];
            // print(Data![0]);
   
      children.add(_getServingField_name(Data!['name'].toString(),name_controller));
      children.add(_getServingField_lastname(Data['last_name'].toString(),lastname_controller));
      children.add(_getServingField_age(Data['age'].toString(),age_controller));
      children.add(_getServingField_length(Data['length'].toString(),length_controller));
      children.add(_getServingField_weight(Data['weight'].toString(),weight_controller));
      children.add(_getServingField_f_r(Data['food_restriction'].toString(), f_r_controller));
      children.add(_getServingField_allergy(Data['allergy'].toString(),allergy_controller));
      children.add(_getServingField_another_allergy(Data['another_allergy'].toString(),another_alergy_controller));
      children.add(_getServingField_email(Data['email'].toString(),email_controller));
      children.add(_getServingField_password(Data['password'].toString(),password_controller));
      children.add(_addCancelSaveButtons (Data));

        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(children: children),
        ),
      );
        }else{
      return const CircularProgressIndicator();
        }
      })
      
    );
  }





  Widget _getServingField_name(String string,TextEditingController controller ) {
     controller.text = string ;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: VERY_LARGE_SPACE),
      child: TextFormField(

              controller: controller,
              textInputAction: TextInputAction.next,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: 'Name',
        ),
              autofillHints: const <String>[AutofillHints.name],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'sign_up_page_display_name_error_empty';
                }
                return null;
              },
            )
    );
  }






  Widget _getServingField_lastname(String string,TextEditingController controller ) {
    
 controller.text = string ;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: VERY_LARGE_SPACE),
      child: TextFormField(

              controller: controller,
              textInputAction: TextInputAction.next,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: 'Last Name',
        ),
              autofillHints: const <String>[AutofillHints.name],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'sign_up_page_display_name_error_empty';
                }
                return null;
              },
            )
    );
  }




  Widget _getServingField_age(String string,TextEditingController controller ) {
    
 controller.text = string ;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: VERY_LARGE_SPACE),
      child: TextFormField(

              controller: controller,
              textInputAction: TextInputAction.next,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: 'Age',
        ),
              autofillHints: const <String>[AutofillHints.name],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'sign_up_page_display_name_error_empty';
                }
                return null;
              },
            )
    );
  }

  Widget _getServingField_length(String string,TextEditingController controller ) {
    
 controller.text = string ;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: VERY_LARGE_SPACE),
      child: TextFormField(

              controller: controller,
              textInputAction: TextInputAction.next,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: 'Length',
        ),
              autofillHints: const <String>[AutofillHints.name],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'sign_up_page_display_name_error_empty';
                }
                return null;
              },
            )
    );
  }

    Widget _getServingField_weight(String string,TextEditingController controller ) {
    
 controller.text = string ;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: VERY_LARGE_SPACE),
      child: TextFormField(

              controller: controller,
              textInputAction: TextInputAction.next,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: 'weight',
        ),
              autofillHints: const <String>[AutofillHints.name],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'sign_up_page_display_name_error_empty';
                }
                return null;
              },
            )
    );
  }
    Widget _getServingField_f_r(String string,TextEditingController controller ) {
    
 controller.text = string ;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: VERY_LARGE_SPACE),
      child: TextFormField(

              controller: controller,
              textInputAction: TextInputAction.next,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: 'Food Restriction',
        ),
              autofillHints: const <String>[AutofillHints.name],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'sign_up_page_display_name_error_empty';
                }
                return null;
              },
            )
    );
  }
    Widget _getServingField_email(String string,TextEditingController controller ) {
    
 controller.text = string ;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: VERY_LARGE_SPACE),
      child: TextFormField(
              controller: controller,
              textInputAction: TextInputAction.next,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: 'Email',
        ),
              autofillHints: const <String>[AutofillHints.name],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'sign_up_page_display_name_error_empty';
                }
                return null;
              },
            )
    );
  }
  


    Widget _getServingField_another_allergy(String string,TextEditingController controller ) {
    
 controller.text = string ;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: VERY_LARGE_SPACE),
      child: TextFormField(
              controller: controller,
              textInputAction: TextInputAction.next,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: 'Another Allergy',
        ),
              autofillHints: const <String>[AutofillHints.name],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'sign_up_page_display_name_error_empty';
                }
                return null;
              },
            )
    );
  }
  Widget _getServingField_allergy(String string,TextEditingController controller ) {
    
 controller.text = string ;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: VERY_LARGE_SPACE),
      child: TextFormField(
              controller: controller,
              textInputAction: TextInputAction.next,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: 'Allergy',
        ),
              autofillHints: const <String>[AutofillHints.name],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'sign_up_page_display_name_error_empty';
                }
                return null;
              },
            )
    );
  }

    Widget _getServingField_password(String string,TextEditingController controller ) {
    
 controller.text = string ;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: VERY_LARGE_SPACE),
      child: TextFormField(
              controller: controller,
              textInputAction: TextInputAction.next,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: 'Password',
        ),
              autofillHints: const <String>[AutofillHints.name],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'sign_up_page_display_name_error_empty';
                }
                return null;
              },
            )
    );
  }

 Widget _addCancelSaveButtons(Map<String,dynamic>? Data) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () =>Navigator.pop(context)
            ,
            // ignore: prefer_const_constructors
            child: Text('cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              
               await _save(context,Data);
            },
            // ignore: prefer_const_constructors
            child: Text('save'),
          ),
        ],
      );
 
   Future<void> _save(BuildContext context, Map<String,dynamic>? Data) async {

if((name_controller.text !=Data!['name'].toString())||(lastname_controller.text !=Data['last_name'].toString())||(age_controller.text !=Data['age'].toString())||(length_controller.text !=Data['length'].toString())||(weight_controller.text !=Data['weight'].toString())||(f_r_controller.text !=Data['food_restriction'].toString())||(allergy_controller.text !=Data['allergy'].toString())||(another_alergy_controller.text !=Data['another_allergy'].toString())||(email_controller.text !=Data['email'].toString())||(password_controller.text !=Data['password'].toString())){
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
              text: 'Yes',
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                 List<String> attributes  =[Data['id'].toString(),name_controller.text,lastname_controller.text,age_controller.text,length_controller.text,
                  weight_controller.text,f_r_controller.text,allergy_controller.text,another_alergy_controller.text,email_controller.text,password_controller.text];
                  DataBaseConfiguration.updateData(attributes);
                });
                if((email_controller.text !=Data['email'].toString())||(password_controller.text !=Data['password'].toString())){
                UserManagementHelper.logout();
                }
                Navigator.push(
                        context,
                        MaterialPageRoute<Widget>(
                          builder: (BuildContext context) =>
                               PageManager(),
                        ),
                      );
            
              
              },
            ),
            SmoothActionButton(
              text: 'No',
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


}
