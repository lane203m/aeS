// ignore_for_file: constant_identifier_names, unnecessary_brace_in_string_interps
import "dart:convert";
import 'package:aes_game/models/waste_response.dart';
import 'package:http/http.dart' as http;

class RequestResult
{
  bool ok;
  dynamic data;
  RequestResult(this.ok,this.data);
}

const PROTOCOL = "http";
const DOMAIN = "localhost:3000";

Future getAll() async{
    final response = await http.get(Uri.parse("${PROTOCOL}://${DOMAIN}/waste"));

    List<WasteResponse> wasteItemResults = [];
    List<dynamic> list = jsonDecode(response.body);

    for (var element in list) { 
      wasteItemResults.add(
        WasteResponse(
          wasteID: element['idwaste_items'],
          xPos: element['x_Pos'],
          yPos: element['y_Pos'],
          size: element['size'],
          wasteType: element['wasteType'],
          isDeleted: false,
          dateModified: DateTime.now()
        )
      );
    }

    return wasteItemResults;
}

Future getDeleted(DateTime dateTime) async{
    final response = await http.get(Uri.parse("${PROTOCOL}://${DOMAIN}/deletedWaste/${dateTime}"));

    List<WasteResponse> wasteItemResults = [];
    List<dynamic> list = jsonDecode(response.body);
    for (var element in list) { 
      wasteItemResults.add(
        WasteResponse(
          wasteID: element['idwaste_items'],
          xPos: element['x_Pos'],
          yPos: element['y_Pos'],
          size: element['size'],
          wasteType: element['wasteType'],
          isDeleted: false,
          dateModified: DateTime.parse(element['dateModified'])
        )
      );
    }

    return wasteItemResults;
}
