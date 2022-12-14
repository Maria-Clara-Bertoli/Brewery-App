import 'dart:convert';
import 'package:brasil/cerveja.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'api.dart';
import 'cadastro.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
//import 'package:snapshot/snapshot.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding : widgetsBinding);
  runApp(applicationBrasil());
}

class applicationBrasil extends StatelessWidget {
  const applicationBrasil({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      home: implementation()
      );
  }
}

class implementation extends StatefulWidget {
  implementation({Key? key}) : super(key: key);

  initState() async{
    await Hive.initFlutter();
  }

  @override 
  _implementationState createState() => _implementationState();
}

class _implementationState extends State<implementation>{

  Box? boximagem;
  Box? boxdescricao;

  @override 
  void initState(){
    super.initState();
    openBox();
  }

  Future openBox() async{
    var diretorio = await getApplicationDocumentsDirectory();
    Hive.init(diretorio.path);
    boximagem = await Hive.openBox('BancoImagem');
    boxdescricao = await Hive.openBox('BancoDescricao');
    return;
  }

  Cadastro cadastro = new Cadastro();

  final TextEditingController _controllerimagem = TextEditingController();
  final TextEditingController _controllerdescricao = TextEditingController();

  List <Cerveja> cerveja = [];

  _getCerveja(){
    Api.getCerveja().then((response){
      setState((){
        Iterable lista = json.decode(response.body);
      cerveja = lista.map((model) => Cerveja.fromJson(model)).toList();
      });
    });
  }

  _implementationState(){
    _getCerveja();
  }

  @override 
  Widget build(BuildContext context){
    return MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
    home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(""),
          bottom: TabBar(tabs: [
            Tab(icon: Text("LOCALIZAÇÃO", 
            textDirection: TextDirection.ltr,
            style: TextStyle (fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black))),
            Tab(icon: Text("PUBLICAÇÃO", 
            textDirection: TextDirection.ltr,
            style: TextStyle (fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black))),
            Tab(icon: Text("VISUALIZAÇÃO", 
            textDirection: TextDirection.ltr,
            style: TextStyle (fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black))),
            ]
          )
        ),
        body: TabBarView(children: [
            Scaffold(
              body: FutureBuilder(
                future: Api.getCerveja(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: 16,
                        itemBuilder: (context, index){
                          return ListTile(
                          title: Text(
                          cerveja[index].name!,
                          textDirection: TextDirection.ltr,
                          style: TextStyle (fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black)
                          ),
                          subtitle: Text(
                          cerveja[index].state!  + " - " + cerveja[index].city! + " - " + cerveja[index].street!,   
                          textDirection: TextDirection.ltr,
                          style: TextStyle (fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black)
                          )
                        );
                      }
                    );
                  }
                  else {
                    return Center(
                      child: const Text("Desculpe! Houve um erro de conexão.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.red)),
                    );
                  }
                }
                else if(snapshot.connectionState == ConnectionState.waiting){
                  return Row(
                   mainAxisSize: MainAxisSize.max,
                   mainAxisAlignment: MainAxisAlignment.center, 
                   children:[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [const CircularProgressIndicator()]
                    )
                   ]
                  );
                }
                else {
                  return Center(
                    child: const Text("Desculpe! Houve um erro de conexão.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.red)),
                  );
                }
              }
            )
          ),

        Container(decoration: new BoxDecoration(image: new DecorationImage(image: new AssetImage("assets/images/fundo.jpg"),
        fit: BoxFit.cover)),
          child: Column(children: [ 
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  controller: _controllerimagem,
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                  decoration: InputDecoration(hintText: "Informe a 'URL' de uma imagem",
                  hintStyle: TextStyle(
                    color: Colors.amber
                  ), 
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.amber
                      )
                    ),
                  ),
                ),
              ),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  controller: _controllerdescricao,
                  style: TextStyle(
                    color: Colors.amber,
                  ),
                  decoration: InputDecoration(hintText: "Informe a descrição",
                  hintStyle: TextStyle(
                    color: Colors.amber
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Colors.amber
                      )
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                child: Text('PUBLICAR',
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(350, 40),
                  primary: Colors.amber,
                  onPrimary: Colors.black,
                ),  
                onPressed: (){
                  setState(() {
                    final String? imagem = _controllerimagem.text;
                    final String? descricao = _controllerdescricao.text;

                    _controllerimagem.clear();
                    _controllerdescricao.clear();

                    cadastro.setImagem(imagem!);
                    cadastro.setDescricao(descricao!);
                    boximagem!.add(cadastro.getImagem());
                    boxdescricao!.add(cadastro.getDescricao());
                    }
                  );
                },
              ),
            ],
          )
         ),        
                      ListView.builder(
                      itemCount: boxdescricao!.length,
                      itemBuilder: (context, index){
                      return ListTile(
                        title: Card(
                          color: Colors.grey[198],
                          child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(children: [
                              Image.network(boximagem!.getAt(index), fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter, width: double.infinity, height: 240,),
                              Divider(),
                              Text (boxdescricao!.getAt(index), 
                              textDirection: TextDirection.ltr,
                              style: TextStyle (fontSize: 19, fontWeight: FontWeight.w400, color: Colors.black),
                              ),
                            Row(children: [
                              Text("                                                                                    "),
                              IconButton(onPressed:(){
                                boximagem!.deleteAt(index);
                                boxdescricao!.deleteAt(index);
                                setState(() {
                                  boxdescricao!.length;
                                });
                              },
                              icon: Icon(Icons.close_sharp, color: Colors.amber),
                              color: Colors.red,
                            )
                          ],
                        )
                              
                          ],
                        )
                      ) 
                    ), 
                  );
                }
              )
            ],
          )
        )
      )
    );
  }
}