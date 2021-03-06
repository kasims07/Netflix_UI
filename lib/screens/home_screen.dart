import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/data/data.dart';
import 'package:flutter_netflix_responsive_ui/widgets/content_header.dart';
import 'package:flutter_netflix_responsive_ui/widgets/custom_app_bar.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scrollOffset = .0;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[850],
          child: const Icon(Icons.cast),
          onPressed: () => print('Cast'),
        ),
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 50.0),
          child: CustomAppBar(
            scrollOffset: _scrollOffset,
          ),
        ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: ContentHeader(featuredContent: sintelContent),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                child: Previews(
                  title: 'Previews',
                  contentList: previews,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ContentList(
                title: 'My List',
                contentList: myList,
              ),
            ),
            SliverToBoxAdapter(
              child: ContentList(
                title: 'Netflix Orignals',
                contentList: originals,
                isOrignals: true,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 20.0),
              sliver: SliverToBoxAdapter(
                child: ContentList(
                  title: 'Trending',
                  contentList: trending,
                ),
              ),
            )
          ],
        ));
  }
}
