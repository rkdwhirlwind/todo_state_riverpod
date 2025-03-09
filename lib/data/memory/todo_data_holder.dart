import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_state_riverpod/data/memory/todo_status.dart';
import 'package:todo_state_riverpod/data/memory/vo_todo.dart';
import 'package:todo_state_riverpod/screen/dialog/d_confirm.dart';

import '../../screen/main/write/d_write_todo.dart';

// Riverpod은 상태관리 데이터 클래스를 만들때 전역변수로 선언하게 만든다.
final todoDataProvider = StateNotifierProvider<TodoDataHolder, List<Todo>>((ref) => TodoDataHolder());

class TodoDataHolder extends StateNotifier<List<Todo>> {

  TodoDataHolder():super([]);

  void changeTodoStatus(Todo todo) async {
    switch (todo.status) {
      case TodoStatus.incomplete:
        todo.status = TodoStatus.ongoing;
      case TodoStatus.ongoing:
        todo.status = TodoStatus.complete;
      case TodoStatus.complete:
        final result = await ConfirmDialog('정말로 처음 상태로 변경하시겠어요?').show();
        result?.runIfSuccess((data) {
          todo.status = TodoStatus.incomplete;
        });
    }
    // todoList.refresh();
    state = List.of(state);
  }

  void addTodo() async {
    final result = await WriteTodoDialog().show();
    if (result != null) {
      state.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: result.text,
        dueDate: result.dateTime,
      ));
    }
  }

  void editTodo(Todo todo) async {
    final result = await WriteTodoDialog(todoForEdit: todo).show();
    if (result != null) {
      todo.title = result.text;
      todo.dueDate = result.dateTime;
      // todoList.refresh();
      state = List.of(state);
    }
  }

  void removeTodo(Todo todo) {
    // todoList.remove(todo);
    // todoList.refresh();
    state.remove(todo);
    state = List.of(state);
  }
}

extension TodoListHolderProvider on WidgetRef{
  TodoDataHolder get readTodoHolder => read(todoDataProvider.notifier);
}