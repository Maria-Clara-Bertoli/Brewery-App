import 'dart:convert';
import 'package:brasil/cerveja.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';
import 'cerveja.dart';
import 'cadastro.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  await Hive.initFlutter();
  runApp(applicationBrasil());
}

class applicationBrasil extends StatelessWidget {
  const applicationBrasil({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: implementation()
      );
  }
}

class implementation extends StatefulWidget {
  implementation({Key? key}) : super(key: key);

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

  int countimagem = 0;
  int countdescricao = 0;

  void putDataImagem(){
    boximagem!.put(cadastro.getidImagem(), cadastro.getImagem());
  }

   void putDataDescricao(){
    boxdescricao!.put(cadastro.getidDescicao(), cadastro.getDescricao());
  }

  getDataImagem(int valor){
    return boximagem!.get(valor);
  }

  getDataDescricao(int valor){
    return boxdescricao!.get(valor);
  }

  void updateDataImagem(int valor, String descricao){
    boximagem!.put(valor, descricao);
  }

   void updateDataDescricao(int valor, String descricao){
   boxdescricao!.put(valor, descricao);
  }

  void deleteDataImagem(int valor){
    boximagem!.delete(valor);
  }

  void deleteDataDescricao(int valor){
    boxdescricao!.delete(valor);
  }

  getAllImagem(){
    return (boximagem!.toMap());
  }

  getAllDescricao(){
    return (boxdescricao!.toMap());
  }

  Cadastro cadastro = new Cadastro();

  final TextEditingController _controllerimagem = TextEditingController();
  final TextEditingController _controllerlike = TextEditingController();
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(""),
          bottom: TabBar(tabs: [
            Tab(icon: Text("LOCALIZAÇÃO", style: TextStyle(fontSize: 16, color: Colors.white))),
            Tab(icon: Text("PUBLICAÇÃO", style: TextStyle(fontSize: 16, color: Colors.white))),
            ]
          )
        ),
        body: TabBarView(children: [
          ListView.builder(
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
      },
    ),

          Column(children: [
           Image.asset("assets/images/cerveja.png", width: 400, height: 300), 
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  controller: _controllerimagem,
                  decoration: InputDecoration(hintText: "Informe a url de uma imagem", 
                  border: OutlineInputBorder(
                  ),
                  ),
                ),
              ),
              Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextField(
                  controller: _controllerdescricao,
                  decoration: InputDecoration(hintText: "Informe uma descrição", 
                  border: OutlineInputBorder(
                  ),
                  ),
                ),
              ),
              ElevatedButton(
                child: Text('PUBLICAR',
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 17),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(350, 40),
                  primary: Colors.amber,
                  onPrimary: Colors.white,
                ),  
                onPressed: (){
                  setState(() {
                    final String? imagem = _controllerimagem.text;
                    final String? descricao = _controllerdescricao.text;

                    _controllerimagem.clear();
                    _controllerdescricao.clear();

                    cadastro.setImagem(imagem!);
                    cadastro.setDescricao(descricao!);
                    cadastro.setidImagem(cadastro.getidImagem() + 1);
                    cadastro.setidDescricao(cadastro.getidDescicao() + 1);
                    putDataDescricao();
                    }
                  );
                },
              ),
            ],
          )
        ],
          )
        )
      )
    );
  }
}