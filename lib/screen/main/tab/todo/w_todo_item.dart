import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_state_riverpod/common/common.dart';
import 'package:todo_state_riverpod/common/dart/extension/datetime_extension.dart';
import 'package:todo_state_riverpod/common/widget/w_rounded_container.dart';
import 'package:todo_state_riverpod/screen/main/tab/todo/w_todo_status.dart';
import 'package:flutter/material.dart';

import '../../../../data/memory/vo_todo.dart';

class TodoItem extends ConsumerWidget {
  final Todo todo;

  TodoItem(this.todo, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      onDismissed: (direction){
        ref.readTodoHolder.removeTodo(todo);
      },
      background: RoundedContainer(
        color: context.appColors.removeTodoBg,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Width(20),
            Icon(
              EvaIcons.trash2Outline,
              color: Colors.white,
            ),
          ],
        ),
      ),
      secondaryBackground: RoundedContainer(
        color: context.appColors.removeTodoBg,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              EvaIcons.trash2Outline,
              color: Colors.white,
            ),
            Width(20),
          ],
        ),
      ),
      key: ValueKey(todo.id),
      child: RoundedContainer(
          margin: const EdgeInsets.only(bottom: 6),
          color: context.appColors.itemBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              todo.dueDate.relativeDays.text.make(),
              Row(
                children: [
                  TodoStatusWidget(todo),
                  Expanded(child: todo.title.text.size(20).medium.make()),
                  IconButton(
                      onPressed: () async {
                        ref.readTodoHolder.editTodo(todo);
                      },
                      icon: const Icon(EvaIcons.editOutline))
                ],
              )
            ],
          ).pOnly(top: 15, right: 15, left: 5, bottom: 10)),
    );
  }
}
