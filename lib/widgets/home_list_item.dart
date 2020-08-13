import 'package:flutter/material.dart';
import 'package:passwd/constants/colors.dart';
import 'package:passwd/models/entry.dart';
import 'package:passwd/utils/get_first_letter.dart';

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
        height: 52,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: 52,
                color: iconColors[entry.colorId],
                child: Center(
                  child: Text(
                    getFirstLetter(entry),
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
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
}
