import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '/frame_work/cmp_header/cmp_header_widget.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

// Focus widget keys for this walkthrough
final containerMq6mg27p = GlobalKey();

/// ed5b7d9f1c815ea4e278132788a7d128
///
///
List<TargetFocus> createWalkthroughTargets(BuildContext context) => [
      /// Step 1
      TargetFocus(
        keyTarget: containerMq6mg27p,
        enableOverlayTab: true,
        alignSkip: Alignment.bottomRight,
        shape: ShapeLightFocus.Circle,
        color: Colors.black,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, __) => CmpHeaderWidget(),
          ),
        ],
      ),
    ];
