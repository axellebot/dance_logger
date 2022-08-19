import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class PracticeListWidgetParams implements PracticeListParams {
  /// ListBloc params
  final PracticeListBloc? practiceListBloc;

  PracticeListWidgetParams(this.practiceListBloc);
}

class PracticeListBlocProvider extends StatelessWidget
    implements PracticeListWidgetParams {
  /// PracticeListWidgetParams
  @override
  final PracticeListBloc? practiceListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  /// Widget params
  final Widget child;

  const PracticeListBlocProvider({
    super.key,

    /// PracticeListWidgetParams
    this.practiceListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,

    /// Widget params
    required this.child,
  }) : assert(practiceListBloc == null ||
            (ofArtist == null &&
                ofDance == null &&
                ofFigure == null &&
                ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return (practiceListBloc != null)
        ? BlocProvider<PracticeListBloc>.value(
            value: practiceListBloc!,
            child: child,
          )
        : BlocProvider<PracticeListBloc>(
            create: (context) => PracticeListBloc(
              practiceRepository:
                  Provider.of<PracticeRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(PracticeListLoad(
                ofArtist: ofArtist,
                ofDance: ofDance,
                ofFigure: ofFigure,
                ofVideo: ofVideo,
              )),
            child: child,
          );
  }
}

class PracticeListView extends StatefulWidget
    implements PracticeListWidgetParams {
  /// PracticeListWidgetParams
  @override
  final PracticeListBloc? practiceListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  /// ListView params
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  const PracticeListView({
    super.key,

    /// PracticeListWidgetParams
    this.practiceListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,

    /// ListView params
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : assert(practiceListBloc == null ||
            (ofArtist == null &&
                ofDance == null &&
                ofFigure == null &&
                ofVideo == null));

  @override
  State<StatefulWidget> createState() => _PracticeListViewState();
}

class _PracticeListViewState extends State<PracticeListView> {
  final _scrollController = ScrollController();

  _PracticeListViewState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return PracticeListBlocProvider(
      practiceListBloc: widget.practiceListBloc,
      ofArtist: widget.ofArtist,
      ofDance: widget.ofDance,
      ofFigure: widget.ofFigure,
      ofVideo: widget.ofVideo,
      child: BlocBuilder<PracticeListBloc, PracticeListState>(
        builder: (BuildContext context, PracticeListState state) {
          switch (state.status) {
            case PracticeListStatus.loading:
              return LoadingListView(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
              );
            case PracticeListStatus.failure:
            case PracticeListStatus.success:
            case PracticeListStatus.refreshing:
              if (state.practices.isEmpty) {
                return EmptyListView(
                  scrollDirection: widget.scrollDirection,
                  physics: widget.physics,
                  padding: widget.padding,
                  label: 'No Practices',
                );
              } else {
                return ListView.builder(
                  scrollDirection: widget.scrollDirection,
                  physics: widget.physics,
                  padding: widget.padding,
                  controller: _scrollController,
                  itemCount: state.hasReachedMax
                      ? state.practices.length
                      : state.practices.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.practices.length) {
                      final PracticeViewModel practice = state.practices[index];
                      final PracticeListBloc practiceListBloc =
                      BlocProvider.of<PracticeListBloc>(context);
                      switch (widget.scrollDirection) {
                        case Axis.vertical:
                          if (state.selectedPractices.isEmpty) {
                            return PracticeListTile(
                              practice: practice,
                              onLongPress: () {
                                practiceListBloc.add(
                                  PracticeListSelect(practiceId: practice.id),
                                );
                              },
                            );
                          } else {
                            return CheckboxPracticeListTile(
                              practice: practice,
                              value:
                              state.selectedPractices.contains(practice.id),
                              onChanged: (bool? value) {
                                practiceListBloc.add(
                                  (value == true)
                                      ? PracticeListSelect(
                                      practiceId: practice.id)
                                      : PracticeListUnselect(
                                      practiceId: practice.id),
                                );
                              },
                            );
                          }
                        case Axis.horizontal:
                          return PracticeCard(practice: practice);
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
      context.read<PracticeListBloc>().add(const PracticeListLoadMore());
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

class PracticesSection extends StatelessWidget
    implements PracticeListWidgetParams {
  /// PracticeListWidgetParams
  @override
  final PracticeListBloc? practiceListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  const PracticesSection({
    super.key,

    /// PracticeListWidgetParams
    this.practiceListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  }) : assert(practiceListBloc == null ||
            (ofArtist == null &&
                ofDance == null &&
                ofFigure == null &&
                ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return PracticeListBlocProvider(
      practiceListBloc: practiceListBloc,
      ofArtist: ofArtist,
      ofDance: ofDance,
      ofFigure: ofFigure,
      ofVideo: ofVideo,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              SectionTile(
                title: const Text('Practices'),
                onTap: () {
                  AutoRouter.of(context).push(
                    PracticeListRoute(
                      practiceListBloc:
                      BlocProvider.of<PracticeListBloc>(context),
                    ),
                  );
                },
              ),
              SizedBox(
                height: AppStyles.cardHeight,
                child: PracticeListView(
                  practiceListBloc: BlocProvider.of<PracticeListBloc>(context),
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
