import 'package:http/http.dart' as http;

const url = 'https://api.openbrewerydb.org/breweries';

class Api{
  static Future getCerveja() async{
    dynamic urlestado = Uri.parse(url);
    return await http.get(urlestado);
  }
}