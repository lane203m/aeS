// ignore_for_file: unnecessary_brace_in_string_interps
import 'package:http/http.dart' as http;

class RequestResult
{
  bool ok;
  dynamic data;
  RequestResult(this.ok,this.data);
}

const protocol = "http";
const domain = "localhost:3000";

Future deleteWaste(int id) async{
  final response = http.delete(Uri.parse("${protocol}://${domain}/waste/${id}"));
  return response;
}
