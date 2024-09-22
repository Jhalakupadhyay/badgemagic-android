import 'package:badgemagic/badge_animation/animation_abstract.dart';

class RightAnimation extends BadgeAnimation {
  @override
  List<List<bool>> processAnimation(
      int badgeHeight,
      int badgeWidth,
      int animationIndex,
      List<List<bool>> processGrid,
      List<List<bool>> canvas) {
    List<List<bool>> newGrid =
        List.generate(11, (i) => List.generate(44, (j) => false));
    int newWidth = processGrid[0].length;
    int newHeight = processGrid.length;
    for (int i = 0; i < badgeHeight; i++) {
      for (int j = 0; j < badgeWidth; j++) {
        int scrollOffset = animationIndex % (newWidth + badgeWidth);

        // Get the corresponding column in the new grid based on the reversed scroll position
        int sourceCol = newWidth - scrollOffset + j;

        // If sourceCol is within bounds of the new grid, display it, else blank space
        if (sourceCol >= 0 && sourceCol < newWidth) {
          canvas[i][j] = processGrid[i % newHeight][sourceCol];
        }
      }
    }
    return newGrid;
  }
}
