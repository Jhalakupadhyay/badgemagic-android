import 'package:badgemagic/bademagic_module/utils/byte_array_utils.dart';
import 'package:badgemagic/bademagic_module/utils/file_helper.dart';
import 'package:badgemagic/constants.dart';
import 'package:badgemagic/providers/badgeview_provider.dart';
import 'package:badgemagic/view/widgets/common_scaffold_widget.dart';
import 'package:badgemagic/view/widgets/saved_badge_listview.dart';
import 'package:badgemagic/virtualbadge/view/saved_badge_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SaveBadgeScreen extends StatefulWidget {
  const SaveBadgeScreen({super.key});

  @override
  State<SaveBadgeScreen> createState() => _SaveBadgeScreenState();
}

class _SaveBadgeScreenState extends State<SaveBadgeScreen> {
  List<MapEntry<String, Map<String, dynamic>>> badgeData = [];
  DrawBadgeProvider drawBadgeProvider = GetIt.instance<DrawBadgeProvider>();

  @override
  void initState() {
    super.initState();
    loadSavedBadges();
  }

  @override
  void dispose() {
    logger.i('SaveBadgeScreen Disposed');
    drawBadgeProvider.stopAllAnimations();
    super.dispose();
  }

  void loadSavedBadges() async {
    var data = await fileHelper.getBadgeDataFiles();
    setState(() {
      badgeData = data;
    });
  }

  FileHelper fileHelper = FileHelper();
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      actions: [
        TextButton(
            onPressed: () {},
            child: const Text(
              'Import',
              style: TextStyle(color: Colors.white),
            ))
      ],
      body: badgeData.isEmpty
          ? const Text("No data Available")
          : Column(
              children: [
                SavedBadgeView(),
                BadgeListView(
                  futureBadges: fileHelper.getBadgeDataFiles(), // Fetch badges
                ),
              ],
            ),
      title: 'Bade Magic',
      key: const Key(drawBadgeScreen),
    );
  }
}
