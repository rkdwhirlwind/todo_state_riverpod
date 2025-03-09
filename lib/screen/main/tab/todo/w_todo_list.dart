import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_state_riverpod/common/common.dart';
import 'package:todo_state_riverpod/screen/main/tab/todo/w_todo_item.dart';
import 'package:flutter/material.dart';

// GetView를 사용하게 되면 TodoDataHolder 외 다른 Controller가 필요할 때
// 새로 선언해서 불필요한 코드스멜이 발생될 수 있음
class TodoList extends ConsumerWidget {
  TodoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final todoList = ref.watch(todoDataProvider);

    return todoList.isEmpty
        ? '할일을 작성해보세요.'.text.size(30).makeCentered()
        : Column(
      children:
      //controller.todoList.map((e) => TodoItem(e)).toList(),
      todoList.map((e) => TodoItem(e)).toList(),
    );
  }
}