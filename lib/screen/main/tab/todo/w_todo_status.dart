import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_state_riverpod/common/common.dart';
import 'package:todo_state_riverpod/data/memory/todo_status.dart';
import 'package:todo_state_riverpod/screen/main/tab/todo/w_fire.dart';
import 'package:flutter/material.dart';

import '../../../../data/memory/vo_todo.dart';

class TodoStatusWidget extends ConsumerWidget {
  final Todo todo;

  const TodoStatusWidget(this.todo, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tap(
      onTap: () {
        ref.readTodoHolder.changeTodoStatus(todo);
      },
      child: SizedBox(
          width: 50,
          height: 50,
          child: switch (todo.status) {
            TodoStatus.complete => Checkbox(
                value: true,
                onChanged: null,
                fillColor: MaterialStateProperty.all(
                  context.appColors.checkBoxColor,
                ),
              ),
            TodoStatus.incomplete => const Checkbox(
                value: false,
                onChanged: null,
              ),
            TodoStatus.ongoing => const Fire()
          }),
    );
  }
}
