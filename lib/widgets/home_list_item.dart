import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/entry.dart';
import '../utils/get_first_letter.dart';

class HomeListItem extends StatelessWidget {
  final Entry entry;

  HomeListItem({@required this.entry}) : assert(entry != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Container(
        width: double.infinity,
        height: 48,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: entry.favicon.isNotEmpty
                  ? Container(
                      color: Colors.white,
                      child: CachedNetworkImage(
                        imageUrl: entry.favicon,
                        width: 52,
                        height: 52,
                        placeholder: (context, url) =>
                            getContainer(entry, context),
                        errorWidget: (context, url, error) =>
                            getContainer(entry, context),
                      ),
                    )
                  : getContainer(entry, context),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.name.isEmpty ? entry.username : entry.name,
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  entry.name.isNotEmpty
                      ? Text(
                          entry.username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getContainer(Entry entry, BuildContext context) {
    return Container(
      width: 48,
      color: iconColors[entry.colorId],
      child: Center(
        child: Text(
          getFirstLetter(entry),
          style: Theme.of(context).textTheme.headline4.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
        ),
      ),
    );
  }
}
