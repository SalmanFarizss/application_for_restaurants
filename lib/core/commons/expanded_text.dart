import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../globals.dart';

final readMoreProvider = StateProvider<bool>((ref) => false);

class ExpandedText extends ConsumerStatefulWidget {
  final String content;
  const ExpandedText({super.key, required this.content});

  @override
  ConsumerState<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends ConsumerState<ExpandedText> {
  final readMoreProvider = StateProvider<bool>((ref) => false);
  @override
  Widget build(BuildContext context,) {
    bool readMore = ref.watch(readMoreProvider);
    return Column(
      children: [
        Text(
          widget.content,
          style: TextStyle(fontSize: width * .035, color: Colors.black),
          maxLines: readMore ? 100 : 3,
        ),
        InkWell(
          onTap:() => ref.read(readMoreProvider.notifier).update((state) => !state),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(readMore?'Read less':'Read more',style:  TextStyle(
                decoration: TextDecoration.underline,
                  fontSize: width * .035,
                  color: Colors.grey,),),
            ],
          ),
        )
      ],
    );
  }
}
