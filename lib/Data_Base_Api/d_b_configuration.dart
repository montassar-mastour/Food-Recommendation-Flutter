// ignore_for_file: prefer_final_locals, file_names, always_specify_types, unrelated_type_equality_checks, noop_primitive_operations, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smooth_app/Data_Base_Api/user_management.dart';
// ignore: avoid_classes_with_only_static_members
class DataBaseConfiguration 
{
  static Future <List<dynamic>>getData() async{
   const String key='subdomain';
    const String filename='get.php';
    const String url='http://'+key+'.sc3qtsk5128.universe.wf/'+ filename;
    http.Response response = await http.get(Uri.parse(url));
    return jsonDecode(response.body) as List<dynamic>;
   
  }
static Future <bool>login(UserManagement user) async{
   const String key='subdomain';
    const String filename='login.php';
    const String url='http://'+key+'.sc3qtsk5128.universe.wf/'+ filename;
    
    http.Response response = await http.post(Uri.parse(url),body: {
       'email': user.email,
       'password': user.password
    });
    print(response.body.toString());
 return response.body.toString()!='false';
  
  }


  static void addData(List<String> attribute) {
      const String key='subdomain';
    const String filename='add.php';
    const String url='http://'+key+'.sc3qtsk5128.universe.wf/'+ filename;
    http.post(Uri.parse(url),body: {
     'name':  attribute[1],
      'last_name': attribute[2],
      'age': attribute[3],
      'length': attribute[4],
     'weight': attribute[5],
    'food_restraction':  attribute[6],
    'allergy':  attribute[7],
    'another_allergy':  attribute[8],
    'email':  attribute[9],
    'password' : attribute[10],
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
  static late UserManagement user ; 
   
}