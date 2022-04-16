// ignore_for_file: prefer_final_locals, file_names, always_specify_types, unrelated_type_equality_checks, noop_primitive_operations, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smooth_app/Data_Base_Api/user_management.dart';
import 'package:smooth_app/database/dao_secured_string.dart';
// ignore: avoid_classes_with_only_static_members
class DataBaseConfiguration 
{

  static Future <Map<String, dynamic>> getData() async{
     final String? email = await DaoSecuredString.get('user_id');
    final String? password = await DaoSecuredString.get('pasword');
   const String key='subdomain';
    const String filename='get.php';
    const String url='http://'+key+'.sc3qtsk5128.universe.wf/'+ filename;
      http.Response response = await http.post(Uri.parse(url),body: {
       'email': email,
       'password': password
    }); 
    return json.decode(response.body) as Map<String, dynamic>;
   
  }
static Future <bool>login(UserManagement user) async{
   const String key='subdomain';
    const String filename='login.php';
    const String url='http://'+key+'.sc3qtsk5128.universe.wf/'+ filename;
    http.Response response = await http.post(Uri.parse(url),body: {
       'email': user.email,
       'password': user.password
    });
 return response.body.toString()!='false';
  
  }


  static void addData(List<String> attribute) {
      const String key='subdomain';
    const String filename='add.php';
    const String url='http://'+key+'.sc3qtsk5128.universe.wf/'+ filename;
    http.post(Uri.parse(url),body: {
     'name':  attribute[0],
      'last_name': attribute[1],
      'age': attribute[2],
      'length': attribute[3],
     'weight': attribute[4],
    'food_restriction':  attribute[5],
    'allergy':  attribute[6],
    'another_allergy':  attribute[7],
    'email':  attribute[8],
    'password' : attribute[9],
    'location' : attribute[10]
    
    });
    
    }
  
   static void updateData(List<String> attribute) {
      const String key='subdomain';
    const String filename='edit.php';
    const String url='http://'+key+'.sc3qtsk5128.universe.wf/'+ filename;
    http.post(Uri.parse(url),body: {
      'id' : attribute[0],
     'name':  attribute[1],
      'last_name': attribute[2],
      'age': attribute[3],
      'length': attribute[4],
     'weight': attribute[5],
    'food_restriction':  attribute[6],
    'allergy':  attribute[7],
    'another_allergy':  attribute[8],
    'email':  attribute[9],
    'password' : attribute[10]
    
    });
    }
    static void addDataAllergy(String user_id) {
    const String key='subdomain';
    const String filename='add_allergens.php';
    const String url='http://'+key+'.sc3qtsk5128.universe.wf/'+ filename;
    http.post(Uri.parse(url),body: {
    'user_id': user_id  
    });
    
    }
    static Future <Map<String,dynamic>> getDataAllergy(String user_id) async {
   const String key='subdomain';
    const String filename='get_allergens.php';
    const String url='http://'+key+'.sc3qtsk5128.universe.wf/'+ filename;
       http.Response response = await http.post(Uri.parse(url),body: {
       'user_id': user_id
    }); 
    return json.decode(response.body) as Map<String, dynamic>;
    
  }
    static void updateDataAllergy(Map<String,String> attribute) {
      const String key='subdomain';
    const String filename='edit_allergens.php';
    const String url='http://'+key+'.sc3qtsk5128.universe.wf/'+ filename;
    http.post(Uri.parse(url),body: {
    'user_id' : attribute['user_id'],
    'allergens_no_gluten':  attribute['allergens_no_gluten'],
    'allergens_no_milk': attribute['allergens_no_milk'],
    'allergens_no_eggs': attribute['allergens_no_eggs'],
    'allergens_no_nuts': attribute['allergens_no_nuts'],
    'allergens_no_peanuts': attribute['allergens_no_peanuts'],
    'allergens_no_sesame_seeds':  attribute['allergens_no_sesame_seeds'],
    'allergens_no_soybeans':  attribute['allergens_no_soybeans'],
    'allergens_no_celery':  attribute['allergens_no_celery'],
    'allergens_no_mustard' : attribute['allergens_no_mustard'],
    'allergens_no_lupin' : attribute['allergens_no_lupin'],
    'allergens_no_fish' : attribute['allergens_no_fish'],
    'allergens_no_crustaceans' : attribute['allergens_no_crustaceans'],
    'allergens_no_molluscs' : attribute['allergens_no_molluscs'],
    'allergens_no_sulphur_dioxide_and_sulphites' : attribute['allergens_no_sulphur_dioxide_and_sulphites'],
    'who_allergens_no_gluten' : attribute['who_allergens_no_gluten'],
    'who_allergens_no_milk' : attribute['who_allergens_no_milk'],
    'who_allergens_no_eggs' : attribute['who_allergens_no_eggs'],
    'who_allergens_no_nuts' : attribute['who_allergens_no_nuts'],
    'who_allergens_no_peanuts' : attribute['who_allergens_no_peanuts'],
    'who_allergens_no_sesame_seeds' : attribute['who_allergens_no_sesame_seeds'],
    'who_allergens_no_soybeans' : attribute['who_allergens_no_soybeans'],
    'who_allergens_no_celery' : attribute['who_allergens_no_celery'],
    'who_allergens_no_mustard' : attribute['who_allergens_no_mustard'],
    'who_allergens_no_lupin' : attribute['who_allergens_no_lupin'],
    'who_allergens_no_fish' : attribute['who_allergens_no_fish'],
    'who_allergens_no_crustaceans' : attribute['who_allergens_no_crustaceans'],
    'who_allergens_no_molluscs' : attribute['who_allergens_no_molluscs'],
    'who_allergens_no_sulphur_dioxide_and_sulphites' : attribute['who_allergens_no_sulphur_dioxide_and_sulphites']
    
    });
    }
  static UserManagement? user  ; 
  
}