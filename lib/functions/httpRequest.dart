import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'functions.dart';
import 'package:logger/logger.dart';

class httprequestService {
  pageFunctions myFunc = pageFunctions();
  // final _myBox = Hive.box('myBox');

  Future<Map<String, dynamic>> getToken() async {
    // print('username: ${dotenv.env['myUsername']}');
    final String basicAuth = 'Basic ' + base64Encode(utf8.encode('${dotenv.env['username'].toString()}:${dotenv.env['password'].toString()}'));
    Map<String, dynamic> responseRequest = {
      "messages": {
        "code": 500,
        "message": "SOMETHING WENT WRONG",
      },
      "response": {}
    };
    try {
      final response = await http.get(
        Uri.parse(dotenv.env['GET_TOKEN'].toString()),
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/json',
          // Add other headers if needed`
        },
      );

      if (response.statusCode == 200) {
        // Successful response
        responseRequest = json.decode(response.body);
        print('getToken: $responseRequest');
        if (responseRequest['messages'][0]['code'].toString() == "0") {
          return responseRequest;
        } else {
          return responseRequest;
        }
      } else {
        // Handle error responses
        print('getToken response Error: ${response.statusCode}');
        print('getToken Response body: ${response.body}');
        return responseRequest;
      }
    } catch (e) {
      print("getToken error: $e");
      return responseRequest;
    }
  }

  //get request

  // Future<bool> getCoopData(String coopId) async {
  //   try {
  //     final token = await getToken();
  //     if (token['messages'][0]['code'].toString() != "0") {
  //       return false;
  //     }
  //     String apiUrl = "${dotenv.env['getCoopDataUrl'].toString()}/$coopId";
  //     Map<String, dynamic> coopData = {};
  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer ${token['response']['token']}',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       // Successful response
  //       Map<String, dynamic> data = json.decode(response.body);
  //       coopData = data['response'];

  //       print('coopData: $coopData');
  //       _myBox.put('coopData', coopData);
  //       return true;
  //     } else {
  //       // Handle error responses
  //       print('Error: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //       return false;
  //     }
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  //post request
  Future<Map<String, dynamic>> Login(Map<String, dynamic> item) async {
    Map<String, dynamic> masterCarddata = {
      "messages": {
        "code": 500,
        "message": "SOMETHING WENT WRONG",
      },
      "response": {}
    };
    Logger().i(item);
    try {
      final token = await getToken();
      if (token['messages']['code'].toString() != "0") {
        return masterCarddata;
      }

      final responseMastercard = await http.post(
        Uri.parse(dotenv.env['LOGIN_REQUEST'].toString()),
        headers: {'Authorization': 'Bearer ${token['response']['token']}', 'Content-Type': 'application/json'},
        body: jsonEncode(item),
      );

      print('sendtocketTicket Raw Response: ${responseMastercard.body}');
      masterCarddata = json.decode(responseMastercard.body);
      if (responseMastercard.statusCode == 200) {
        // Successful response
        // if(masterCarddata.containsKey('pin')){

        // }
        print('sendtocketTicket: $masterCarddata');
        if (masterCarddata['messages']['code'].toString() == "0") {
          myFunc.current_user_id = masterCarddata['response']['id'].toString();
          return masterCarddata;
        } else {
          return masterCarddata;
        }
      } else {
        // Handle error responses
        // print('sendtocketTicket Error: ${responseMastercard.statusCode}');
        // print('sendtocketTicket Response body: ${responseMastercard.body}');
        return masterCarddata;
      }
    } catch (e) {
      print("sendtocketTicket error: $e");
      print('sendtocketTicket masterCarddata: $masterCarddata');

      if (e is ClientException) {
        return {
          "messages": {"code": "500", "message": "NO INTERNET"}
        };
      } else {
        return masterCarddata;
      }
    }
  }

  Future<Map<String, dynamic>> Register(Map<String, dynamic> item) async {
    Map<String, dynamic> masterCarddata = {
      "messages": {
        "code": 500,
        "message": "SOMETHING WENT WRONG",
      },
      "response": {}
    };
    try {
      final token = await getToken();
      if (token['messages']['code'].toString() != "0") {
        return masterCarddata;
      } else {}

      final responseMastercard = await http.post(
        Uri.parse(dotenv.env['REGISTER'].toString()),
        headers: {'Authorization': 'Bearer ${token['response']['token']}', 'Content-Type': 'application/json'},
        body: jsonEncode(item),
      );

      print('sendtocketTicket Raw Response: ${responseMastercard.body}');
      masterCarddata = json.decode(responseMastercard.body);
      if (responseMastercard.statusCode == 200) {
        // Successful response
        print('sendtocketTicket: $masterCarddata');
        if (masterCarddata['messages']['code'].toString() == "0") {
          myFunc.current_user_id = masterCarddata['response']['user']['_id'].toString();
          return masterCarddata;
        } else {
          return masterCarddata;
        }
      } else {
        // Handle error responses
        // print('sendtocketTicket Error: ${responseMastercard.statusCode}');
        // print('sendtocketTicket Response body: ${responseMastercard.body}');
        return masterCarddata;
      }
    } catch (e) {
      print("sendtocketTicket error: $e");
      print('sendtocketTicket masterCarddata: $masterCarddata');

      if (e is ClientException) {
        return {
          "messages": {"code": "500", "message": "NO INTERNET"}
        };
      } else {
        return masterCarddata;
      }
    }
  }

  Future<Map<String, dynamic>> UpdateUser(Map<String, dynamic> item) async {
    Map<String, dynamic> masterCarddata = {
      "messages": {
        "code": 500,
        "message": "SOMETHING WENT WRONG",
      },
      "response": {}
    };
    try {
      final token = await getToken();
      if (token['messages']['code'].toString() != "0") {
        return masterCarddata;
      }

      final responseMastercard = await http.patch(
        Uri.parse('${dotenv.env['UPDATE'].toString()}${myFunc.current_user_id.toString()}'),
        headers: {'Authorization': 'Bearer ${token['response']['token']}', 'Content-Type': 'application/json'},
        body: jsonEncode(item),
      );

      print('sendtocketTicket Raw Response: ${responseMastercard.body}');
      masterCarddata = json.decode(responseMastercard.body);
      if (responseMastercard.statusCode == 200) {
        // Successful response
        print('sendtocketTicket: $masterCarddata');
        if (masterCarddata['messages']['code'].toString() == "0") {
          myFunc.current_user_id = masterCarddata['response']['user']['_id'].toString();
          return masterCarddata;
        } else {
          return masterCarddata;
        }
      } else {
        // Handle error responses
        // print('sendtocketTicket Error: ${responseMastercard.statusCode}');
        // print('sendtocketTicket Response body: ${responseMastercard.body}');
        return masterCarddata;
      }
    } catch (e) {
      print("sendtocketTicket error: $e");
      print('sendtocketTicket masterCarddata: $masterCarddata');

      if (e is ClientException) {
        return {
          "messages": {"code": "500", "message": "NO INTERNET"}
        };
      } else {
        return masterCarddata;
      }
    }
  }

  Future<Map<String, dynamic>> Wallet(Map<String, dynamic> item) async {
    Map<String, dynamic> masterCarddata = {
      "messages": {
        "code": 500,
        "message": "SOMETHING WENT WRONG",
      },
      "response": {}
    };
    try {
      final token = await getToken();
      if (token['messages']['code'].toString() != "0") {
        return masterCarddata;
      }

      final responseMastercard = await http.patch(
        Uri.parse('${dotenv.env['UPDATE_WALLET'].toString()}${myFunc.current_user_id.toString()}'),
        headers: {'Authorization': 'Bearer ${token['response']['token']}', 'Content-Type': 'application/json'},
        body: jsonEncode(item),
      );

      print('sendtocketTicket Raw Response: ${responseMastercard.body}');
      masterCarddata = json.decode(responseMastercard.body);
      if (responseMastercard.statusCode == 200) {
        // Successful response
        print('sendtocketTicket: $masterCarddata');
        if (masterCarddata['messages']['code'].toString() == "0") {
          // myFunc.current_user_id = masterCarddata['response']['user']['_id'].toString();
          return masterCarddata;
        } else {
          return masterCarddata;
        }
      } else {
        return masterCarddata;
      }
    } catch (e) {
      print("sendtocketTicket error: $e");
      print('sendtocketTicket masterCarddata: $masterCarddata');

      if (e is ClientException) {
        return {
          "messages": {"code": "500", "message": "NO INTERNET"}
        };
      } else {
        return masterCarddata;
      }
    }
  }

  Future<Map<String, dynamic>> getWallet() async {
    Map<String, dynamic> masterCarddata = {
      "messages": {
        "code": 500,
        "message": "SOMETHING WENT WRONG",
      },
      "response": {}
    };
    try {
      final token = await getToken();
      if (token['messages']['code'].toString() != "0") {
        return masterCarddata;
      }

      final responseMastercard = await http.get(
        Uri.parse('${dotenv.env['GET_WALLET'].toString()}${myFunc.current_user_id.toString()}'),
        headers: {'Authorization': 'Bearer ${token['response']['token']}', 'Content-Type': 'application/json'},
      );

      print('sendtocketTicket Raw Response: ${responseMastercard.body}');
      masterCarddata = json.decode(responseMastercard.body);
      if (responseMastercard.statusCode == 200) {
        // Successful response
        print('sendtocketTicket: $masterCarddata');
        if (masterCarddata['messages']['code'].toString() == "0") {
          // myFunc.current_user_id = masterCarddata['response']['balance'].toString();
          return masterCarddata;
        } else {
          return masterCarddata;
        }
      } else {
        return masterCarddata;
      }
    } catch (e) {
      print("sendtocketTicket error: $e");
      print('sendtocketTicket masterCarddata: $masterCarddata');

      if (e is ClientException) {
        return {
          "messages": {"code": "500", "message": "NO INTERNET"}
        };
      } else {
        return masterCarddata;
      }
    }
  }
}
