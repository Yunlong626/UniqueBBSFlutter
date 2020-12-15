import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/tool/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _mainHorizontalPadding = 20.0;
const _mainVerticalPadding = 10.0;

// 通知公告部分常量
const _broadcastHeight = 150.0;
const _innerHorizontalPadding = 15.0;
const _innerVerticalPadding = 10.0;
const _smallIconSize = 18.0;
const _broadcastRadius = 25.0;
const _titleStyle = TextStyle(fontSize: 18, color: ColorConstant.textBlack);
const _subtitleStyle = TextStyle(fontSize: 12, color: ColorConstant.textGray);

// 查看 report 部分的常量
const _showReportRadius = 28.0;
const _showReportTextStyle =
    TextStyle(fontSize: 16, color: ColorConstant.textWhite);
final gradients = transAngle2Alignments(28);

// 下方 gridView 部分常量
const _gridSpacing = 15.0;
const _gridBorderRadius = 26.0;
final _gridTextStyle = TextStyle(fontSize: 15, color: ColorConstant.textBlack);
final _gridBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(_gridBorderRadius)),
    color: ColorConstant.backgroundWhite,
    boxShadow: [
      BoxShadow(
        color: ColorConstant.lightBorderPink,
        spreadRadius: 10,
        blurRadius: 7,
        offset: Offset(0, 6), // changes position of shadow
      ),
    ]);

class HomeInfoWidget extends StatefulWidget {
  @override
  State createState() => _HomeInfoState();
}

Widget _buildBroadcastHead() {
  Widget head = Row(
    children: [
      SvgPicture.asset(SvgIcon.broadcast),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(StringConstant.broadcast),
        ),
        flex: 1,
      ),
      Icon(
        Icons.arrow_forward_ios,
        size: _smallIconSize,
        color: Colors.grey,
      ),
    ],
  );
  return wrapPadding(head, _innerVerticalPadding, _innerHorizontalPadding);
}

Widget _buildBroadcastBody() {
  Widget body = Row(
    children: [
      CircleAvatar(
        radius: _broadcastRadius,
        backgroundImage:
            NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/'
                'it/u=1336318030,2258820972&fm=26&gp=0.jpg'),
      ),
      Container(
        width: 10,
      ),
      Text.rich(
        TextSpan(text: '2020年春招相关事宜\n', style: _titleStyle, children: [
          TextSpan(text: '2020.01.09 肖宇轩 发布', style: _subtitleStyle),
        ]),
      ),
    ],
  );
  return wrapPadding(body, _innerVerticalPadding, _innerHorizontalPadding);
}

Widget _buildBroadcast() {
  return Container(
    padding: EdgeInsets.symmetric(
        vertical: _mainVerticalPadding, horizontal: _mainHorizontalPadding),
    height: _broadcastHeight,
    child: Card(
      color: ColorConstant.backgroundWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: <Widget>[
          _buildBroadcastHead(),
          Expanded(
            child: _buildBroadcastBody(),
            flex: 1,
          ),
        ],
      ),
    ),
  );
}

Widget _buildReport() {
  Widget button = FlatButton(
    minWidth: double.infinity,
    onPressed: () => print('report!'),
    child: Text(StringConstant.showReport, style: _showReportTextStyle),
  );
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(_showReportRadius)),
      gradient: LinearGradient(
        begin: gradients[0],
        end: gradients[1],
        colors: [ColorConstant.purpleColor, ColorConstant.primaryColorLight],
      ),
    ),
    margin: EdgeInsets.symmetric(
        horizontal: _mainHorizontalPadding, vertical: _mainVerticalPadding),
    child: button,
  );
}

Widget _buildGridBlock(List<String> contents) {
  return Container(
    decoration: _gridBoxDecoration,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(contents[0]),
        Container(height: 10), // use for spacing
        Text(
          contents[1],
          style: _gridTextStyle,
        ),
      ],
    ),
  );
}

Widget _buildGrid() {
  return Expanded(
    flex: 1,
    child: GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1,
      padding: EdgeInsets.symmetric(
          horizontal: _mainHorizontalPadding, vertical: _mainVerticalPadding),
      crossAxisSpacing: _gridSpacing,
      mainAxisSpacing: _gridSpacing,
      children: [
        [SvgIcon.projectTask, StringConstant.projectTask],
        [SvgIcon.freshmanTask, StringConstant.freshmanTask],
        [SvgIcon.file, StringConstant.fileData],
        [SvgIcon.share, StringConstant.share],
      ].map((e) {
        return GridTile(
          child: _buildGridBlock(e),
        );
      }).toList(),
    ),
  );
}

class _HomeInfoState extends State<HomeInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBroadcast(),
        _buildReport(),
        _buildGrid(),
      ],
    );
  }
}
