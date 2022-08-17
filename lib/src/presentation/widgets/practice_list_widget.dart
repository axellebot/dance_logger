import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PracticeListView extends StatefulWidget implements PracticeListParams {
  /// ListBloc params
  final PracticeListBloc? practiceListBloc;

  /// PracticeListParams
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

    /// ListBloc params
    this.practiceListBloc,

    /// PracticeListParams
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,

    /// ListView params
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  });

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
    final Widget mainContent = BlocBuilder<PracticeListBloc, PracticeListState>(
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
    );
    return (widget.practiceListBloc != null)
        ? BlocProvider<PracticeListBloc>.value(
            value: widget.practiceListBloc!,
            child: mainContent,
          )
        : BlocProvider(
            create: (context) => PracticeListBloc(
              practiceRepository:
                  Provider.of<PracticeRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(PracticeListLoad(
                ofArtist: widget.ofArtist,
                ofDance: widget.ofDance,
                ofFigure: widget.ofFigure,
                ofVideo: widget.ofVideo,
              )),
            child: mainContent,
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

class PracticesSection extends StatelessWidget implements PracticeListParams {
  /// ListBloc params
  final PracticeListBloc? practiceListBloc;

  /// PracticeListParams
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

    /// ListBloc params
    this.practiceListBloc,

    /// PracticeListParams
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  });

  @override
  Widget build(BuildContext context) {
    final Widget mainContent = Builder(
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
                ofArtist: ofArtist,
                ofDance: ofDance,
                ofFigure: ofFigure,
                ofVideo: ofVideo,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        );
      },
    );

    return (practiceListBloc != null)
        ? BlocProvider<PracticeListBloc>.value(
            value: practiceListBloc!,
            child: mainContent,
          )
        : BlocProvider(
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
            child: mainContent,
          );
  }
}
