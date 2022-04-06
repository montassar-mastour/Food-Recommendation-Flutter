// ignore_for_file: prefer_final_locals, file_names, always_specify_types, unrelated_type_equality_checks, noop_primitive_operations, prefer_interpolation_to_compose_strings

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
    return jsonDecode(response.body) as Map<String, dynamic>;
   
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
    'food_restraction':  attribute[5],
    'allergy':  attribute[6],
    'another_allergy':  attribute[7],
    'email':  attribute[8],
    'password' : attribute[9],
    'location' : 'kairouan'
    
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
    'food_restraction':  attribute[6],
    'allergy':  attribute[7],
    'another_allergy':  attribute[8],
    'email':  attribute[9],
    'password' : attribute[10]
    
    });
    }
  static UserManagement? user  ; 
  
}