import 'package:auto_route/auto_route.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _railExtended = false;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setExtend(bool value) {
    setState(() {
      _railExtended = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(AppLocalizations.of(context)?.homeTitle ?? 'Dance'),
      //   actions: [
      //     MediaQuery.of(context).orientation == Orientation.portrait
      //         ? const QuickSettingsActionButton()
      //         : const SizedBox(),
      //   ],
      // ),
      body: MediaQuery.of(context).orientation == Orientation.landscape
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _MainNavigationRail(
                  railExtended: _railExtended,
                  onEnter: (event) {
                    _setExtend(true);
                  },
                  onExit: (event) {
                    _setExtend(false);
                  },
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onItemTapped,
                ),
                const VerticalDivider(
                  thickness: 1,
                  width: 1,
                ),
                Expanded(
                  child: _MainContent(selectedIndex: _selectedIndex),
                )
              ],
            )
          : Center(
              child: _MainContent(selectedIndex: _selectedIndex),
            ),
      bottomNavigationBar:
          MediaQuery.of(context).orientation == Orientation.portrait
              ? _MainNavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onItemTapped,
                )
              : null,
    );
  }
}

class _MainNavigationRail extends StatelessWidget {
  final int selectedIndex;
  final bool railExtended;
  final PointerEnterEventListener? onEnter;
  final PointerExitEventListener? onExit;
  final ValueChanged<int>? onDestinationSelected;

  const _MainNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.railExtended,
    required this.onEnter,
    required this.onExit,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: onEnter,
      onExit: onExit,
      child: NavigationRail(
        labelType: NavigationRailLabelType.none,
        extended: railExtended,
        trailing: const QuickSettingsActionButton(),
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: const <NavigationRailDestination>[
          NavigationRailDestination(
            icon: Icon(Icons.movie_outlined),
            label: Text('Videos'),
            selectedIcon: Icon(Icons.movie),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.people_outlined),
            label: Text('Artists'),
            selectedIcon: Icon(Icons.people),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.view_list_outlined),
            label: Text('Dances'),
            selectedIcon: Icon(Icons.view_list),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.history_outlined),
            label: Text('Practices'),
            selectedIcon: Icon(Icons.history),
          ),
        ],
      ),
    );
  }
}

class _MainNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  const _MainNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      animationDuration: const Duration(milliseconds: 500),
      onDestinationSelected: onDestinationSelected,
      destinations: const <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.movie_outlined),
          label: 'Videos',
          selectedIcon: Icon(Icons.movie),
        ),
        NavigationDestination(
          icon: Icon(Icons.people_outlined),
          label: 'Artists',
          selectedIcon: Icon(Icons.people),
        ),
        NavigationDestination(
          icon: Icon(Icons.view_list_outlined),
          label: 'Dances',
          selectedIcon: Icon(Icons.view_list),
        ),
        NavigationDestination(
          icon: Icon(Icons.history_outlined),
          label: 'Practices',
          selectedIcon: Icon(Icons.history),
        ),
      ],
    );
  }
}

class _MainContent extends StatelessWidget {
  final int selectedIndex;

  const _MainContent({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return const VideoListPage(
          showAppBar: true,
        );
      case 1:
        return const ArtistListPage(
          showAppBar: true,
        );
      case 2:
        return const DanceListPage(
          showAppBar: true,
        );
      case 3:
        return const PracticeListPage(
          showAppBar: true,
        );
      default:
        return Container();
    }
  }
}
