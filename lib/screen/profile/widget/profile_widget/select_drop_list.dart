import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:flutter/material.dart';
import 'package:reprohealth_app/theme/theme.dart';

class SelectDropList extends StatefulWidget {
  final OptionItem itemSelected;
  final DropListModel dropListModel;
  final Function(OptionItem optionItem) onOptionSelected;
  final double? space;
  final bool showIcon;
  final bool showArrowIcon;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final Widget? icon;
  final double arrowIconSize;
  final Color? arrowColor;
  final Color? textColorTitle;
  final Color? hintColorTitle;
  final double textSizeTitle;
  final Color? textColorItem;
  final double textSizeItem;
  final bool showBorder;
  final Color? borderColor;
  final Color? shadowColor;
  final double borderSize;
  final double? height, width;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? containerPadding;
  final EdgeInsetsGeometry? containerMargin;
  final Decoration? containerDecoration;
  final double? heightBottomContainer;
  final IconData? suffixIcon;
  final EdgeInsetsGeometry? paddingDropItem;
  final Color? dropboxborderColor;
  final BorderRadiusGeometry? dropbBoxborderRadius;

  const SelectDropList({
    super.key,
    required this.itemSelected,
    required this.dropListModel,
    required this.showIcon,
    required this.showArrowIcon,
    required this.onOptionSelected,
    this.paddingLeft = 20,
    this.paddingRight = 20,
    this.paddingTop = 20,
    this.paddingBottom = 20,
    this.icon,
    this.arrowIconSize = 20,
    this.textColorTitle,
    this.textSizeTitle = 16,
    this.paddingDropItem,
    this.arrowColor,
    this.textColorItem,
    this.textSizeItem = 14,
    this.showBorder = true,
    this.width,
    this.borderRadius,
    this.height,
    this.heightBottomContainer,
    this.boxShadow,
    this.borderColor,
    this.hintColorTitle,
    this.containerDecoration,
    this.containerPadding,
    this.shadowColor,
    this.suffixIcon,
    this.containerMargin,
    this.borderSize = 1,
    this.dropbBoxborderRadius,
    this.dropboxborderColor,
    this.space
  });

  @override
  SelectDropListState createState() => SelectDropListState();
}

class SelectDropListState extends State<SelectDropList>
    with SingleTickerProviderStateMixin {
  late OptionItem optionItemSelected;
  late AnimationController expandController;
  late Animation<double> animation;
  bool isShow = false;
  final scrollController = ScrollController(initialScrollOffset: 0);

  @override
  void initState() {
    super.initState();
    optionItemSelected = OptionItem(
        id: widget.itemSelected.id, title: widget.itemSelected.title);
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.linear,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: widget.paddingLeft,
          right: widget.paddingRight,
          top: widget.paddingTop,
          bottom: widget.paddingBottom),
      child: Column(
        children: <Widget>[
          Container(
            height: widget.height ?? 48,
            width: widget.width ?? MediaQuery.of(context).size.width,
            padding: widget.containerPadding ??
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            margin: widget.containerMargin ?? const EdgeInsets.only(top: 16),
            decoration: widget.showBorder
                ? widget.containerDecoration ??
                    BoxDecoration(
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(4),
                      border: Border.all(
                          color: widget.borderColor ?? Colors.black,
                          width: widget.borderSize),
                      color: Colors.white,
                    )
                : widget.containerDecoration ??
                    BoxDecoration(
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(4),
                      color: Colors.white,
                      boxShadow: widget.boxShadow ??
                          [
                            BoxShadow(
                                blurRadius: 2,
                                color: widget.shadowColor ?? Colors.black26,
                                offset: const Offset(0, 0))
                          ],
                    ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Visibility(
                    visible: widget.showIcon,
                    child: widget.icon != null
                        ? widget.icon!
                        : const Icon(
                            Icons.menu,
                            color: Colors.black,
                          )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    isShow = !isShow;
                    _runExpandCheck();
                    setState(() {});
                  },
                  child: Text(
                    optionItemSelected.title,
                    style: optionItemSelected.id == '0' ||
                          optionItemSelected.id == null
                          ? regular12Grey2004
                          : regular12Grey400,
                  ),
                )),
                Visibility(
                  visible: widget.showArrowIcon,
                  child: Align(
                    alignment: const Alignment(1, 0),
                    child: GestureDetector(
                      onTap: () {
                        isShow = !isShow;
                        _runExpandCheck();
                        setState(() {});
                      },
                      child: Icon(
                        isShow
                            ? Icons.keyboard_arrow_up
                            : widget.suffixIcon ?? Icons.arrow_right,
                        color: widget.arrowColor ?? Colors.black,
                        size: widget.arrowIconSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height : widget.space),
          SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: animation,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                    height: widget.heightBottomContainer ?? 10,
                    padding: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: widget.dropboxborderColor ?? Colors.grey),
                      borderRadius: widget.dropbBoxborderRadius ??
                          const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, top: 16,),
                      child: Scrollbar(
                        thickness: 8,
                        thumbVisibility: true,
                        interactive: true,
                        controller: scrollController,
                        radius: const Radius.circular(16),
                        scrollbarOrientation: ScrollbarOrientation.right,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: _buildDropListOptions(
                              widget.dropListModel.listOptionItems,
                              context,
                              widget.textColorItem,
                              widget.textSizeItem),
                        ),
                      ),
                    )),
              )),
        ],
      ),
    );
  }

  Column _buildDropListOptions(List<OptionItem> items, BuildContext context,
      Color? textColorItem, double textSizeItem) {
    return Column(
      children: items
          .map((item) =>
              _buildSubMenu(item, context, textColorItem, textSizeItem))
          .toList(),
    );
  }

  Widget _buildSubMenu(OptionItem item, BuildContext context,
      Color? textColorItem, double textSizeItem) {
    return Padding(
      padding: widget.paddingDropItem ??
          const EdgeInsets.only(left: 20, top: 15, bottom: 5),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(item.title,
                style: regular12Grey400,
                maxLines: 3,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        onTap: () {
          optionItemSelected = item;
          isShow = false;
          expandController.reverse();
          widget.onOptionSelected(item);
        },
      ),
    );
  }
}