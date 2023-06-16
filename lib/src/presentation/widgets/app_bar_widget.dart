import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final String? hintText;
  final VoidCallback? onSearch;

  const SearchAppBar({
    super.key,
    this.title,
    this.hintText,
    this.onSearch,
  }) : assert(title == null || hintText == null);

  @override
  Widget build(BuildContext context) {
    if (hintText == null) {
      return AppBar(
        title: title,
        actions: [
          if (onSearch != null)
            IconButton(
              onPressed: onSearch,
              icon: const Icon(Icons.search),
            )
        ],
      );
    } else {
      return AppBar(
        title: GestureDetector(
          onTap: onSearch,
          child: ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppStyles.appBarIconHorizontalPadding,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      hintText!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  if (MediaQuery.of(context).orientation == Orientation.portrait) const QuickSettingsActionButton(),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int count;
  final VoidCallback? onCanceled;
  final VoidCallback? onDeleted;
  final VoidCallback? onConfirmed;

  const SelectionAppBar({
    super.key,
    required this.count,
    this.onCanceled,
    this.onDeleted,
    this.onConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: onCanceled,
      ),
      title: Text('$count selected'),
      actions: [
        if (onDeleted != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppStyles.appBarIconHorizontalPadding,
            ),
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteDialog(
                      onConfirmed: onDeleted,
                    );
                  },
                );
              },
            ),
          ),
        if (onConfirmed != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppStyles.appBarIconHorizontalPadding,
            ),
            child: IconButton(
              icon: const Icon(Icons.check),
              onPressed: onConfirmed,
            ),
          )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
