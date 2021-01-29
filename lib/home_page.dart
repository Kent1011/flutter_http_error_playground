import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_http_error_playground/cubit/todo_cubit.dart';
import 'package:flutter_http_error_playground/todo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(title: Text('Http Error')),
      body: _buildBody(),
    );
  }

  void _showMessage(String message) {
    _scaffold.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildBody() {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {
        if (state is TodoFetchError) {
          _showMessage(state.message);
        }
      },
      builder: (context, state) {
        if (state is TodoFetching) {
          return _loadingBody();
        } else if (state is TodoFetched) {
          return _taskBody(state.task);
        } else {
          return _defaultBody();
        }
      },
    );
  }

  Widget _actionButton(int id) {
    return MaterialButton(
      onPressed: () => context.read<TodoCubit>().fetch(id),
      child: Text(
        'Fetch Task $id',
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      color: Colors.lightBlue,
    );
  }

  Widget _loadingBody() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _taskBody(Todo todo) {
    return Column(
      children: [
        Text('id: ${todo.id}'),
        Text('user: ${todo.userId}'),
        Text('title: ${todo.title}'),
        Text('done: ${todo.completed}'),
        _actionButton(todo.id > 1 ? 1 : 2),
      ],
    );
  }

  Widget _defaultBody() {
    return _actionButton(1);
  }
}
