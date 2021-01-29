import 'package:bloc/bloc.dart';
import 'package:flutter_http_error_playground/todo.dart';
import 'package:meta/meta.dart';

import 'package:flutter_http_error_playground/todo_service.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoService _service;

  TodoCubit(this._service) : super(const TodoInitial());

  _fetch(int id) async {
    if (state is TodoFetching) return;
    emit(const TodoFetching());

    await Future.delayed(const Duration(seconds: 1));

    _service.fetchTask(id).then((todo) {
      emit(TodoFetched(todo));
    }).catchError((error) {
      emit(TodoFetchError(error.toString()));
    });
  }

  void fetch(int taskId) => _fetch(taskId);
}
