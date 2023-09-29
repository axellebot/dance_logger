import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class ArtistDetailWidgetParams implements ArtistDetailParams {
  final ArtistDetailBloc? artistDetailBloc;
  final ArtistViewModel? ofArtist;

  ArtistDetailWidgetParams(this.artistDetailBloc, this.ofArtist);
}

class ArtistDetailBlocProvider extends StatelessWidget implements ArtistDetailWidgetParams {
  /// ArtistDetailWidgetParams
  @override
  final ArtistDetailBloc? artistDetailBloc;
  @override
  final ArtistViewModel? ofArtist;
  @override
  final String? ofArtistId;

  /// Widget params
  final Widget child;

  const ArtistDetailBlocProvider({
    super.key,

    /// ArtistDetailWidgetParams
    this.artistDetailBloc,
    this.ofArtist,
    this.ofArtistId,

    /// Widget params
    required this.child,
  }) : assert(artistDetailBloc == null || ofArtist == null || ofArtistId == null);

  @override
  Widget build(BuildContext context) {
    if (artistDetailBloc != null) {
      return BlocProvider<ArtistDetailBloc>.value(
        value: artistDetailBloc!,
        child: child,
      );
    } else {
      return BlocProvider<ArtistDetailBloc>(
        create: (context) {
          final artistDetailBloc = ArtistDetailBloc(
            artistRepository: Provider.of<ArtistRepository>(context, listen: false),
            mapper: ModelMapper(),
          );

          if (ofArtist != null) {
            artistDetailBloc.add((ArtistDetailLazyLoad(artist: ofArtist!)));
          } else if (ofArtistId != null) {
            artistDetailBloc.add((ArtistDetailLoad(artistId: ofArtistId!)));
          }

          return artistDetailBloc;
        },
        child: child,
      );
    }
  }
}

class ArtistListTile extends StatelessWidget implements ArtistDetailWidgetParams {
  /// ArtistDetailWidgetParams
  @override
  final ArtistDetailBloc? artistDetailBloc;
  @override
  final ArtistViewModel? ofArtist;
  @override
  final String? ofArtistId;

  /// ListTile parameters
  final ItemCallback<ArtistViewModel>? onTap;
  final ItemCallback<ArtistViewModel>? onLongPress;
  final bool selected;

  const ArtistListTile({
    super.key,

    /// ArtistDetailWidgetParams
    this.artistDetailBloc,
    this.ofArtist,
    this.ofArtistId,

    /// ListTile parameters
    this.onTap,
    this.onLongPress,
    this.selected = false,
  }) : assert(artistDetailBloc == null || ofArtist == null || ofArtistId == null);

  @override
  Widget build(BuildContext context) {
    return ArtistDetailBlocProvider(
      artistDetailBloc: artistDetailBloc,
      ofArtist: ofArtist,
      ofArtistId: ofArtistId,
      child: BlocBuilder<ArtistDetailBloc, ArtistDetailState>(
        builder: (BuildContext context, ArtistDetailState state) {
          return ListTile(
            title: (state.artist != null)
                ? Text(
                    '${state.artist?.name}',
                    overflow: TextOverflow.ellipsis,
                  )
                : const Text('Loading...'),
            // TODO : Add shimmer text
            leading: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Hero(
                tag: 'img-artist-${state.artist?.id ?? state.ofArtistId}',
                transitionOnUserGestures: false,
                child: (state.artist != null)
                    ? InitialCircleAvatar(
                        text: '${state.artist?.name}',
                        image: (state.artist?.imageUrl != null)
                            ? NetworkImage(
                                state.artist!.imageUrl!,
                              )
                            : null,
                        radius: AppStyles.artistThumbnailRadius,
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
            onTap: (onTap != null)
                ? () {
                    onTap!(state.artist!);
                  }
                : () {
                    AutoRouter.of(context).push(
                      ArtistDetailsRoute(artistDetailBloc: BlocProvider.of<ArtistDetailBloc>(context)),
                    );
                  },
            onLongPress: (onLongPress != null)
                ? () {
                    onLongPress!(state.artist!);
                  }
                : null,
            selected: selected,
          );
        },
      ),
    );
  }
}

class CheckboxArtistListTile extends StatelessWidget implements ArtistDetailWidgetParams {
  /// ArtistDetailWidgetParams
  @override
  final ArtistDetailBloc? artistDetailBloc;
  @override
  final ArtistViewModel? ofArtist;
  @override
  final String? ofArtistId;

  /// CheckboxLitTile parameters
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxArtistListTile({
    super.key,

    /// ArtistDetailWidgetParams
    this.artistDetailBloc,
    this.ofArtist,
    this.ofArtistId,

    /// CheckboxLitTile parameters
    required this.value,
    required this.onChanged,
  }) : assert(artistDetailBloc == null || ofArtist == null || ofArtistId == null);

  @override
  Widget build(BuildContext context) {
    return ArtistDetailBlocProvider(
      artistDetailBloc: artistDetailBloc,
      ofArtist: ofArtist,
      ofArtistId: ofArtistId,
      child: BlocBuilder<ArtistDetailBloc, ArtistDetailState>(
        builder: (BuildContext context, ArtistDetailState state) {
          return CheckboxListTile(
            title: (state.artist != null)
                ? Text(
                    '${state.artist?.name}',
                    overflow: TextOverflow.ellipsis,
                  )
                : const Text('Loading...'),
            // TODO : Add shimmer text
            value: value,
            onChanged: onChanged,
          );
        },
      ),
    );
  }
}

class ArtistCard extends StatelessWidget implements ArtistDetailWidgetParams {
  /// ArtistDetailWidgetParams
  @override
  final ArtistDetailBloc? artistDetailBloc;
  @override
  final ArtistViewModel? ofArtist;
  @override
  final String? ofArtistId;

  const ArtistCard({
    super.key,

    /// ArtistDetailWidgetParams
    this.artistDetailBloc,
    this.ofArtist,
    this.ofArtistId,
  }) : assert(artistDetailBloc == null || ofArtist == null || ofArtistId == null);

  @override
  Widget build(BuildContext context) {
    return ArtistDetailBlocProvider(
      artistDetailBloc: artistDetailBloc,
      ofArtist: ofArtist,
      ofArtistId: ofArtistId,
      child: BlocBuilder<ArtistDetailBloc, ArtistDetailState>(
        builder: (BuildContext context, ArtistDetailState state) {
          onTap() => AutoRouter.of(context).push(
                ArtistDetailsRoute(
                  artistDetailBloc: BlocProvider.of<ArtistDetailBloc>(context),
                ),
              );
          return Padding(
            padding: const EdgeInsets.all(AppStyles.itemPadding),
            child: AspectRatio(
              aspectRatio: AppStyles.artistCardRatio,
              child: Column(
                children: [
                  Expanded(
                    child: Material(
                      clipBehavior: Clip.antiAlias,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: onTap,
                        child: (state.artist != null)
                            ? Hero(
                                tag: 'img-artist-${state.artist?.id ?? state.ofArtistId}',
                                transitionOnUserGestures: false,
                                child: InitialCircleAvatar(
                                  text: '${state.artist?.name}',
                                  image: (state.artist?.imageUrl) != null
                                      ? NetworkImage(
                                          state.artist!.imageUrl!,
                                        )
                                      : null,
                                ),
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        (state.artist != null)
                            ? Text(
                                '${state.artist?.name}',
                                overflow: TextOverflow.ellipsis,
                              )
                            : const Text('Loading...'),
                        // TODO : Add shimmer text
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ArtistForm extends StatelessWidget {
  const ArtistForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ArtistEditBloc artistEditBloc = BlocProvider.of<ArtistEditBloc>(context);
    return BlocBuilder<ArtistEditBloc, ArtistEditState>(
      builder: (BuildContext context, ArtistEditState state) {
        return Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'John Doe',
                ),
                initialValue: state.initialArtist?.name,
                onChanged: (value) {
                  artistEditBloc.add(ArtistEditChangeName(artistName: value));
                },
              ),
              const SizedBox(
                height: AppStyles.formInputVerticalSpacing,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Image url',
                  hintText: 'http://image.com/myimage',
                  suffixIcon: IconButton(
                    onPressed: () {
                      artistEditBloc.add(const ArtistEditChangeImageUrl(artistImageUrl: null));
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ),
                initialValue: state.initialArtist?.imageUrl,
                onChanged: (value) {
                  artistEditBloc.add(
                    ArtistEditChangeImageUrl(artistImageUrl: value),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
