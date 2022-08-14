import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistListView extends StatefulWidget {
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  const ArtistListView({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  });

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
    return BlocBuilder<ArtistListBloc, ArtistListState>(
      builder: (BuildContext context, ArtistListState state) {
        switch (state.status) {
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
