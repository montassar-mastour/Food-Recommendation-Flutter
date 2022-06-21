// ignore_for_file: prefer_final_locals, file_names, always_specify_types, unrelated_type_equality_checks, noop_primitive_operations, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:convert';

import 'package:crypt/crypt.dart';
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
  static Future <Map<String, dynamic>>sec_login(UserManagement user) async{
   const String key='subdomain';
    const String filename='sec_login.php';
    const String url='http://'+key+'.sc3qtsk5128.universe.wf/'+ filename;
    http.Response response = await http.post(Uri.parse(url),body: {
       'email': user.email,
    });
  return json.decode(response.body) as Map<String, dynamic>;

  
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
    'email':  attribute[5],
    'password' : attribute[6],
    'location' : attribute[7]
    
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
    'email':  attribute[6],
    'password' : attribute[7]
    
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
    const String filename='edit_allergy.php';
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
    'who_allergens_no_sulphur_dioxide_and_sulphites' : attribute['who_allergens_no_sulphur_dioxide_and_sulphites'],
    'who_allergens_no_Kiwi' : attribute['who_allergens_no_Kiwi'],
    'who_allergens_no_Pêche' : attribute['who_allergens_no_Pêche'],
    'who_allergens_no_Pomme' : attribute['who_allergens_no_Pomme'],
    'who_allergens_no_Fraise' : attribute['who_allergens_no_Fraise'],
    'who_allergens_no_Amande' : attribute['who_allergens_no_Amande'],
    'who_allergens_no_Noix' : attribute['who_allergens_no_Noix'],
    'who_allergens_no_Noisettes' : attribute['who_allergens_no_Noisettes'],
    'who_allergens_no_Fruits_de_mer' : attribute['who_allergens_no_Fruits_de_mer'],
    'allergens_no_Kiwi' : attribute['allergens_no_Kiwi'],
    'allergens_no_Pêche' : attribute['allergens_no_Pêche'],
    'allergens_no_Pomme' : attribute['allergens_no_Pomme'],
    'allergens_no_Fraise' : attribute['allergens_no_Fraise'],
    'allergens_no_Amande' : attribute['allergens_no_Amande'],
    'allergens_no_Noix' : attribute['allergens_no_Noix'],
    'allergens_no_Noisettes' : attribute['allergens_no_Noisettes'],
    'allergens_no_Fruits_de_mer' : attribute['allergens_no_Fruits_de_mer']
    });
    }
  static UserManagement? user  ; 
  
}