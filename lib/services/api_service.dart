import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chat_gpt/constants/api_consts.dart';
import 'package:chat_gpt/models/chat_model.dart';
import 'package:chat_gpt/models/models_model.dart';
import 'package:chat_gpt/models/pixcl_model.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static Future<List<ModelsModel>> getModels()async{
     try{
    var responce = await http.get(
      Uri.parse('$BASE_URL/models'),
      headers: {'Authorization':'Bearer $API_KEY'}
    );

    Map jsonResponse  =jsonDecode(responce.body);


    if (jsonResponse['error'] != null) {
      // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
      throw HttpException(jsonResponse['error']["message"]);
    }

    List temp =[];
    for(var value in jsonResponse['data']){
      temp.add(value);

    }
    return ModelsModel.modelsFromSnapshot(temp);
     }catch (error){
       log("error $error");
       rethrow;

     }
  }


  static Future<List<ChatModel>> sendMessage({
  required String message ,required String modelId
})async{
    try {
      log("modelId $modelId");
      var response = await http.post(
        Uri.parse("$BASE_URL/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json"
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 300,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
          jsonResponse["choices"].length,
              (index) => ChatModel(
            msg: jsonResponse["choices"][index]["text"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }


  static Future<List<Photos>>  getPhotos()async{

     try{
       var response = await http.get(
         Uri.parse('$TEST_URL'),
       );
       Map jsonResponse = jsonDecode(response.body);

       if(jsonResponse['error'] != null){
         throw HttpException(jsonResponse['error']['message']);
       }
       List temp = [];
       for(var value  in jsonResponse['photos']){
         temp.add(value);
       }
       return Photos.modelsFromSnapshot(temp);
     }catch(error){
       log('error  $error');
       rethrow;
     }

  }

}