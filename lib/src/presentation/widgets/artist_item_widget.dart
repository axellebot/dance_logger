import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistListTile extends StatelessWidget {
  final ArtistViewModel artist;

  /// ListTile options
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final bool selected;

  const ArtistListTile({
    super.key,
    required this.artist,

    /// ListTile options
    this.onTap,
    this.onLongPress,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(artist.name),
      leading: (artist.imageUrl != null)
          ? Hero(
              tag: artist.id,
              child: InitialCircleAvatar(
                text: artist.name,
                backgroundImage: NetworkImage(
                  artist.imageUrl!,
                ),
                radius: AppStyles.artistThumbnailRadius,
              ),
            )
          : null,
      onTap: onTap ??
          () {
            AutoRouter.of(context).push(
              ArtistDetailsRoute(artistId: artist.id),
            );
          },
      onLongPress: onLongPress,
      selected: selected,
    );
  }
}

class CheckboxArtistListTile extends StatelessWidget {
  final ArtistViewModel artist;

  /// CheckboxLitTile options
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxArtistListTile({
    super.key,
    required this.artist,

    /// CheckboxLitTile options
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(artist.name),
      value: value,
      onChanged: onChanged,
    );
  }
}

class ArtistAvatar extends StatelessWidget {
  final ArtistViewModel artist;

  const ArtistAvatar({
    super.key,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppStyles.cardHeight,
      child: InkWell(
        onTap: () {
          AutoRouter.of(context).push(
            ArtistDetailsRoute(artistId: artist.id),
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: artist.id,
                child: InitialCircleAvatar(
                  backgroundImage: NetworkImage(
                    artist.imageUrl!,
                  ),
                ),
              ),
            ),
            Text(artist.name)
          ],
        ),
      ),
    );
  }
}

class ArtistForm extends StatelessWidget {
  const ArtistForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ArtistEditBloc artistEditBloc =
        BlocProvider.of<ArtistEditBloc>(context);
    return BlocBuilder<ArtistEditBloc, ArtistEditState>(
      builder: (BuildContext context, ArtistEditState state) {
        return Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Name',
                ),
                initialValue: state.initialArtist?.name,
                onChanged: (artistName) {
                  artistEditBloc
                      .add(ArtistEditChangeName(artistName: artistName));
                },
              ),
              const SizedBox(
                height: AppStyles.formInputVerticalSpacing,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Image url',
                  hintText: 'http://image.com/myimage',
                ),
                initialValue: state.initialArtist?.imageUrl,
                onChanged: (artistImageUrl) {
                  artistEditBloc.add(
                      ArtistEditChangeImageUrl(artistImageUrl: artistImageUrl));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
