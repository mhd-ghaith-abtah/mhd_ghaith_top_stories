import 'package:flutter/material.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/color_manager.dart';
import 'package:mhd_ghaith_top_stories/app/app_management/font_manager.dart';
import 'package:mhd_ghaith_top_stories/features/top_stories/data/remote/models/response/top_stories_api_response.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StoryDetailsWebViewScreen extends StatefulWidget {
  final TopStoryModel story;

  const StoryDetailsWebViewScreen({super.key, required this.story});

  @override
  State<StoryDetailsWebViewScreen> createState() =>
      _StoryDetailsWebViewScreenState();
}

class _StoryDetailsWebViewScreenState extends State<StoryDetailsWebViewScreen> {
  late final WebViewController _webViewController;

  _bind() => _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(ColorManager.white)
    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) =>
            NavigationDecision.navigate,
      ),
    )
    ..loadRequest(Uri.parse(widget.story.url!));

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar(),
        body: WebViewWidget(controller: _webViewController),
      );

  AppBar _appBar() => AppBar(
        title: Text(
          widget.story.title!,
          style: getBoldTextStyle(
            color: ColorManager.black,
            fontSize: FontSize.s16,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
}
