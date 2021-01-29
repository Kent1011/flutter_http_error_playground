part of 'todo_cubit.dart';

@immutable
abstract class TodoState {
  const TodoState();
}

@immutable
class TodoInitial extends TodoState {
  const TodoInitial();
}

@immutable
class TodoFetching extends TodoState {
  const TodoFetching();
}

@immutable
class TodoFetched extends TodoState {
  final Todo task;

  const TodoFetched(this.task);
}

@immutable
class TodoFetchError extends TodoState {
  final String message;

  const TodoFetchError(this.message);
}
