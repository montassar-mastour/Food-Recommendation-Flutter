
import 'package:flutter/material.dart';
import 'package:smooth_app/Data_Base_Api/D_B_configuration.dart';
import 'package:smooth_app/language/language.dart';
import 'package:smooth_app/pages/sign_pages/profil_page2.dart';

import 'header_widget.dart';

class ProfilePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
     return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>{
@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Language.build(context);
  setState(() {});
    return Scaffold(
      appBar: AppBar(
        title:  Text(Language.profil_page!,
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
      body:FutureBuilder<Map<String, dynamic>>(  
                 future:DataBaseConfiguration.getData(),
        builder:(context,snapshot){
       // ignore: always_put_control_body_on_new_line, avoid_print
        if( snapshot.hasData) 
        {
         final  Map<String, dynamic>? Data = snapshot.data ;
          return        SingleChildScrollView(
        child: Stack(
          children: [
            const SizedBox(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(5, 5),),
                      ],
                    ),
                    child: Icon(Icons.person, size: 80, color: Colors.grey.shade300,),
                  ),
                  const SizedBox(height: 20,),
                   Text(Data!['last_name'].toString()+' '+Data['name'].toString(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:<Widget>[
                          Container(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child:  Text(
                            Language.User_Information!,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topRight,
                          child:     ElevatedButton(
                         onPressed: () async {
                          Navigator.push(context, MaterialPageRoute<Widget>(builder: (BuildContext context) => ProfilPage2()));
                         },
                         // ignore: prefer_const_constructors
                         child: Text(Language.Modify!),
                         ),
                        ),]
                        )
                       ,
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                         ListTile(
                                          leading: Icon(Icons.calendar_month),
                                          title: Text(Language.age!),
                                          subtitle: Text(Data['age'].toString()),
                                        ),
                                         ListTile(  
                                          leading:  SizedBox(
                                          width: 20,
                                           height: 20,
                                            child:  Image.asset('assets/app/length_3926.ico')
                                        ),
                                           title: Text(Language.length!),
                                          subtitle: Text(Data['length'].toString()),
                                        ),
                                        ListTile(
                                          leading: SizedBox(
                                          width: 20,
                                           height: 20,
                                            child:  Image.asset('assets/app/scale_weight_3065.ico', color: Colors.grey,) ,
                                            
                                        ),
                                          title: Text(Language.weight!),
                                          subtitle: Text(Data['weight'].toString()),
                                        ),
                                         ListTile(
                                          leading: Icon(Icons.email),
                                          title: Text(Language.email!),
                                          subtitle: Text(Data['email'].toString()),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
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

}