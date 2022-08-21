import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class DanceListWidgetParams implements DanceListParams {
  /// ListBloc params
  final DanceListBloc? danceListBloc;

  DanceListWidgetParams(this.danceListBloc);
}

class DanceListBlocProvider extends StatelessWidget
    implements DanceListWidgetParams {
  /// DanceListWidgetParams
  @override
  final DanceListBloc? danceListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofArtist;
  @override
  final String? ofVideo;

  /// Widget params
  final Widget child;

  const DanceListBlocProvider({
    super.key,

    /// DanceListWidgetParams
    this.ofSearch,
    this.danceListBloc,
    this.ofArtist,
    this.ofVideo,

    /// Widget params
    required this.child,
  }) : assert(danceListBloc == null ||
            ofSearch == null ||
            (ofArtist == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return (danceListBloc != null)
        ? BlocProvider<DanceListBloc>.value(
            value: danceListBloc!,
            child: child,
          )
        : BlocProvider(
            create: (context) => DanceListBloc(
              danceRepository:
                  Provider.of<DanceRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(DanceListLoad(
                ofSearch: ofSearch,
                ofArtist: ofArtist,
                ofVideo: ofVideo,
              )),
            child: child,
          );
  }
}

class DanceListView extends StatefulWidget implements DanceListWidgetParams {
  /// DanceListWidgetParams
  @override
  final DanceListBloc? danceListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofArtist;
  @override
  final String? ofVideo;

  /// ListView params
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const DanceListView({
    super.key,

    /// DanceListWidgetParams
    this.danceListBloc,
    this.ofSearch,
    this.ofArtist,
    this.ofVideo,

    /// ListView params
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : assert(danceListBloc == null ||
            ofSearch == null ||
            (ofArtist == null && ofVideo == null));

  @override
  State<StatefulWidget> createState() => _DanceListViewState();
}

class _DanceListViewState extends State<DanceListView> {
  final _scrollController = ScrollController();

  _DanceListViewState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return DanceListBlocProvider(
      danceListBloc: widget.danceListBloc,
      ofSearch: widget.ofSearch,
      ofArtist: widget.ofArtist,
      ofVideo: widget.ofVideo,
      child: BlocBuilder<DanceListBloc, DanceListState>(
        builder: (context, state) {
          switch (state.status) {
            case DanceListStatus.initial:
            case DanceListStatus.loading:
              return LoadingListView(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
              );
            case DanceListStatus.failure:
            case DanceListStatus.success:
            case DanceListStatus.refreshing:
              if (state.dances.isEmpty) {
                return EmptyListView(
                  scrollDirection: widget.scrollDirection,
                  physics: widget.physics,
                  padding: widget.padding,
                  label: 'No Dances',
                );
              } else {
                return ListView.builder(
                  scrollDirection: widget.scrollDirection,
                  controller: _scrollController,
                  physics: widget.physics,
                  padding: widget.padding,
                  itemCount: state.hasReachedMax
                      ? state.dances.length
                      : state.dances.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.dances.length) {
                      final DanceViewModel dance = state.dances[index];
                      final DanceListBloc danceListBloc =
                          BlocProvider.of<DanceListBloc>(context);
                      switch (widget.scrollDirection) {
                        case Axis.vertical:
                          if (state.selectedDances.isEmpty) {
                            return DanceListTile(
                              dance: dance,
                              onLongPress: () {
                                danceListBloc.add(
                                  DanceListSelect(danceId: dance.id),
                                );
                              },
                            );
                          } else {
                            return CheckboxDanceListTile(
                              dance: dance,
                              value: state.selectedDances.contains(dance.id),
                              onChanged: (bool? value) {
                                danceListBloc.add(
                                  (value == true)
                                      ? DanceListSelect(danceId: dance.id)
                                      : DanceListUnselect(danceId: dance.id),
                                );
                              },
                            );
                          }
                        case Axis.horizontal:
                          return DanceCard(dance: dance);
                      }
                    } else {
                      switch (widget.scrollDirection) {
                        case Axis.vertical:
                          return const BottomListLoadingIndicator();
                        case Axis.horizontal:
                          return const RightListLoadingIndicator();
                      }
                    }
                  },
                );
              }
            default:
              return ErrorListView(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                error: NotSupportedError(message: '${state.status}'),
              );
          }
        },
      ),
    );
  }

  void _onScroll() {
    if (_shouldLoadMore) {
      context.read<DanceListBloc>().add(const DanceListLoadMore());
    }
  }

  bool get _shouldLoadMore {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final scrollThreshold = (maxScroll * 0.9);
    final currentScroll = _scrollController.offset;
    return currentScroll >= scrollThreshold;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}

class DancesSection extends StatelessWidget
    implements EntitiesSectionWidgetParams, DanceListWidgetParams {
  /// EntitiesSectionWidgetParams
  @override
  final String? label;
  @override
  final VoidCallback? onTap;

  /// DanceListWidgetParams
  @override
  final DanceListBloc? danceListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofArtist;
  @override
  final String? ofVideo;

  const DancesSection({
    super.key,

    /// EntitiesSectionWidgetParams
    this.label,
    this.onTap,

    /// DanceListWidgetParams
    this.danceListBloc,
    this.ofSearch,
    this.ofArtist,
    this.ofVideo,
  }) : assert(danceListBloc == null ||
            ofSearch == null ||
            (ofArtist == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return DanceListBlocProvider(
      danceListBloc: danceListBloc,
      ofSearch: ofSearch,
      ofArtist: ofArtist,
      ofVideo: ofVideo,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              SectionTile(
                title: Text(label ?? 'Dances'),
                onTap: onTap ??
                    () {
                      AutoRouter.of(context).push(
                        DanceListRoute(
                          danceListBloc:
                              BlocProvider.of<DanceListBloc>(context),
                        ),
                      );
                    },
              ),
              SizedBox(
                height: AppStyles.cardHeight,
                child: DanceListView(
                  danceListBloc: BlocProvider.of<DanceListBloc>(context),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
