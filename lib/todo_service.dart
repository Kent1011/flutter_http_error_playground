import 'dart:convert';
import 'dart:io';

import 'package:flutter_http_error_playground/todo.dart';
import 'package:http/http.dart';

class TodoService {
  Future<Todo> fetchTask(int id) async {
    final url = 'https://jsonplaceholder.typicode.com/todos/$id';
    var client = Client();

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var result = Todo.fromMap(json.decode(response.body));
        return Future.value(result);
      } else {
        return Future.error('Fetching todo task id: $id error.');
      }
    } on SocketException {
      return Future.error('No Internet connection.');
    } on FormatException {
      return Future.error('Response format error.');
    } on Exception {
      return Future.error('Unexpected error.');
    } catch (error) {
      return Future.error('Unexpected error. \n($error)');
    } finally {
      client.close();
    }
  }
}
