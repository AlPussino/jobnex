import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/features/chat/presentation/widgets/images_grid_widget_in_chat_media_tab_bar.dart';
import 'package:JobNex/features/chat/presentation/widgets/videos_grid_widget_in_chat_media_tab_bar.dart';
import 'package:JobNex/features/chat/presentation/widgets/voices_list_widget_in_chat_media_tab_bar.dart';
import '../widgets/files_grid_widget_in_chat_media_tab_bar.dart';

class ViewMediaPage extends StatefulWidget {
  static const routeName = '/view-media-page';

  final String chatRoomId;
  final Map<String, dynamic> chatRoomData;

  const ViewMediaPage(
      {super.key, required this.chatRoomId, required this.chatRoomData});

  @override
  State<ViewMediaPage> createState() => _ViewMediaPageState();
}

class _ViewMediaPageState extends State<ViewMediaPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(
      () => setState(() {}),
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(title: const Text('View Media')),
        body: Column(
          children: [
            TabBar(
              controller: tabController,
              automaticIndicatorColorAdjustment: true,
              isScrollable: false,
              tabAlignment: TabAlignment.fill,
              tabs: const [
                Tab(text: "Images"),
                Tab(text: "Videos"),
                Tab(text: "Voices"),
                Tab(text: "Files"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                dragStartBehavior: DragStartBehavior.down,
                children: [
                  ImagesGridWidgetInChatMediaTabBar(
                    chatRoomId: widget.chatRoomId,
                  ),
                  VideosGridWidgetInChatMediaTabBar(
                    chatRoomId: widget.chatRoomId,
                  ),
                  VoicesListWidgetInChatMediaTabBar(
                    chatRoomData: widget.chatRoomData,
                    chatRoomId: widget.chatRoomId,
                  ),
                  FilesGridWidgetInChatMediaTabBar(
                    chatRoomId: widget.chatRoomId,
                    chatRoomData: widget.chatRoomData,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
