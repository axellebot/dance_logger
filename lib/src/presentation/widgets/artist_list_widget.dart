import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class ArtistListWidgetParams implements ArtistListParams {
  /// ListBloc params
  final ArtistListBloc? artistListBloc;

  ArtistListWidgetParams(this.artistListBloc);
}

class ArtistListBlocProvider extends StatelessWidget
    implements ArtistListWidgetParams {
  /// ArtistListWidgetParams
  @override
  final ArtistListBloc? artistListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  /// Widget params
  final Widget child;

  const ArtistListBlocProvider({
    super.key,

    /// ArtistListWidgetParams
    this.artistListBloc,
    this.ofSearch,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,

    /// Widget params
    required this.child,
  }) : assert(artistListBloc == null ||
            ofSearch == null ||
            (ofDance == null && ofFigure == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return (artistListBloc != null)
        ? BlocProvider<ArtistListBloc>.value(
            value: artistListBloc!,
            child: child,
          )
        : BlocProvider(
            create: (context) => ArtistListBloc(
              artistRepository:
                  Provider.of<ArtistRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(ArtistListLoad(
                ofSearch: ofSearch,
                ofDance: ofDance,
                ofFigure: ofFigure,
                ofVideo: ofVideo,
              )),
            child: child,
          );
  }
}

class ArtistListView extends StatefulWidget
    implements ArtistListWidgetParams, EntityListViewParams {
  /// ArtistListWidgetParams
  @override
  final ArtistListBloc? artistListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  /// EntityListViewParams
  @override
  final Axis scrollDirection;
  @override
  final ScrollPhysics? physics;
  @override
  final EdgeInsets? padding;

  const ArtistListView({
    super.key,

    /// ArtistListWidgetParams
    this.artistListBloc,
    this.ofSearch,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,

    /// EntityListViewParams
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : assert(artistListBloc == null ||
            ofSearch == null ||
            (ofDance == null && ofFigure == null && ofVideo == null));

  @override
  State<StatefulWidget> createState() => _ArtistListViewState();
}

class _ArtistListViewState extends State<ArtistListView> {
  final _scrollController = ScrollController();

  _ArtistListViewState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return ArtistListBlocProvider(
      artistListBloc: widget.artistListBloc,
      ofSearch: widget.ofSearch,
      ofDance: widget.ofDance,
      ofFigure: widget.ofFigure,
      ofVideo: widget.ofVideo,
      child: BlocBuilder<ArtistListBloc, ArtistListState>(
        builder: (BuildContext context, ArtistListState state) {
          switch (state.status) {
            case ArtistListStatus.initial:
            case ArtistListStatus.loading:
              return LoadingListView(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
              );
            case ArtistListStatus.failure:
            case ArtistListStatus.success:
            case ArtistListStatus.refreshing:
              if (state.artists.isEmpty) {
                return EmptyListView(
                  scrollDirection: widget.scrollDirection,
                  physics: widget.physics,
                  padding: widget.padding,
                  label: 'No Artists',
                );
              } else {
                return ListView.builder(
                  scrollDirection: widget.scrollDirection,
                  physics: widget.physics,
                  padding: widget.padding,
                  controller: _scrollController,
                  itemCount: state.hasReachedMax
                      ? state.artists.length
                      : state.artists.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.artists.length) {
                      final ArtistViewModel artist = state.artists[index];
                      final ArtistListBloc artistListBloc =
                          BlocProvider.of<ArtistListBloc>(context);
                      switch (widget.scrollDirection) {
                        case Axis.vertical:
                          if (state.selectedArtists.isEmpty) {
                            return ArtistListTile(
                              artist: artist,
                              onLongPress: () {
                                artistListBloc.add(
                                  ArtistListSelect(artistId: artist.id),
                                );
                              },
                            );
                          } else {
                            return CheckboxArtistListTile(
                              artist: artist,
                              value: state.selectedArtists.contains(artist.id),
                              onChanged: (bool? value) {
                                artistListBloc.add(
                                  (value == true)
                                      ? ArtistListSelect(artistId: artist.id)
                                      : ArtistListUnselect(artistId: artist.id),
                                );
                              },
                            );
                          }
                        case Axis.horizontal:
                          return ArtistCard(artist: artist);
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
      context.read<ArtistListBloc>().add(const ArtistListLoadMore());
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

class ArtistsSection extends StatelessWidget
    implements ArtistListWidgetParams, EntitiesSectionWidgetParams {
  /// EntitiesSectionWidgetParams
  @override
  final String? label;
  @override
  final VoidCallback? onSectionTap;

  /// ArtistListWidgetParams
  @override
  final ArtistListBloc? artistListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  const ArtistsSection({
    super.key,

    /// EntitiesSectionWidgetParams
    this.label,
    this.onSectionTap,

    /// ArtistListWidgetParams
    this.artistListBloc,
    this.ofSearch,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  }) : assert(artistListBloc == null ||
            ofSearch == null ||
            (ofDance == null && ofFigure == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return ArtistListBlocProvider(
      artistListBloc: artistListBloc,
      ofSearch: ofSearch,
      ofDance: ofDance,
      ofFigure: ofFigure,
      ofVideo: ofVideo,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              SectionTile(
                title: Text(label ?? 'Artists'),
                onTap: onSectionTap ??
                    () {
                      AutoRouter.of(context).push(
                        ArtistListRoute(
                          artistListBloc:
                              BlocProvider.of<ArtistListBloc>(context),
                        ),
                      );
                    },
              ),
              SizedBox(
                height: AppStyles.cardHeight,
                child: ArtistListView(
                  artistListBloc: BlocProvider.of<ArtistListBloc>(context),
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
