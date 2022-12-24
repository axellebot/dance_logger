abstract class EntityListPageParams<Item> {
  /// Page params
  final bool? showAppBar;
  final String? titleText;
  final bool shouldSelectOne;
  final bool shouldSelectMultiple;
  final List<Item>? preselectedItems;

  EntityListPageParams(
    this.showAppBar,
    this.titleText,
    this.shouldSelectOne,
    this.shouldSelectMultiple,
    this.preselectedItems,
  ) : assert(shouldSelectOne == false || shouldSelectMultiple == false);
}
