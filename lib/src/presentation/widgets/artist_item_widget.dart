import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistListTile extends StatelessWidget {
  final ArtistViewModel artist;

  /// ListTile options
  final ItemCallback<ArtistViewModel>? onTap;
  final ItemCallback<ArtistViewModel>? onLongPress;
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
      title: Text(
        artist.name,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Hero(
        tag: 'img-${artist.id}',
        child: InitialCircleAvatar(
          text: artist.name,
          backgroundImage: (artist.imageUrl != null)
              ? NetworkImage(
                  artist.imageUrl!,
                )
              : null,
          radius: AppStyles.artistThumbnailRadius,
        ),
      ),
      onTap: (onTap != null)
          ? () {
              onTap!(artist);
            }
          : () {
              AutoRouter.of(context).push(
                ArtistDetailsRoute(artistId: artist.id),
              );
            },
      onLongPress: (onLongPress != null)
          ? () {
              onLongPress!(artist);
            }
          : null,
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
      title: Text(
        artist.name,
        overflow: TextOverflow.ellipsis,
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}

class ArtistCard extends StatelessWidget {
  final ArtistViewModel artist;

  const ArtistCard({
    super.key,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    onTap() => AutoRouter.of(context).push(
          ArtistDetailsRoute(artistId: artist.id),
        );

    return Padding(
      padding: const EdgeInsets.all(AppStyles.itemPadding),
      child: Column(
        children: [
          Expanded(
            child: Hero(
              tag: 'img-${artist.id}',
              child: Material(
                clipBehavior: Clip.antiAlias,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: onTap,
                  child: InitialCircleAvatar(
                    text: artist.name,
                    backgroundImage: (artist.imageUrl) != null
                        ? NetworkImage(
                            artist.imageUrl!,
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Column(
              children: [
                const SizedBox(height: 5),
                Text(
                  artist.name,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ],
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
                      artistEditBloc.add(
                          const ArtistEditChangeImageUrl(artistImageUrl: null));
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
