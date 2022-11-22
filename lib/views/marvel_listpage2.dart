import 'package:flutter/material.dart';
import 'package:marvel/components/drawer_widget.dart';
import 'package:provider/provider.dart';
import '../components/carrousel_list.dart';
import '../components/recomended_list.dart';
import '../components/text_style_widget.dart';
import '../components/top_10_list.dart';
import '../constants/string_constants.dart';
import '../controller/marvel_controller.dart';
import '../components/search_movie.dart';
import '../data/models/marvel_models.dart';

class MarvelListPage2 extends StatefulWidget {
  const MarvelListPage2({Key? key}) : super(key: key);

  @override
  State<MarvelListPage2> createState() => _MarvelListPage2State();
}

class _MarvelListPage2State extends State<MarvelListPage2> {
  List<Data> lista = [];

  late final MarvelController controller;

  @override
  void initState() {
    controller = context.read<MarvelController>();
    controller.getData(query: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MarvelController provider = Provider.of<MarvelController>(context);
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
        backgroundColor: Colors.black12,
        appBar: _buildAppBar(context),
        drawer: const DrawerWidget(),
        body: provider.lista.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              _watchNowText(),
              const CarrouselList(),
              _recomendedText(),
              const RecomendedList(),
              _top10Text(),
              const Top10List(),
            ],
          ),
        ),
      );
    });
  }

  _top10Text() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(StringConstants.top10, style: AppTextStyle.font22),
    );
  }

  _recomendedText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(StringConstants.recomendados, style: AppTextStyle.font22),
    );
  }

  _watchNowText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(StringConstants.assistaAgora, style: AppTextStyle.font22),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 5,
      title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black12,
        ),
        child:  TextField(
          decoration:  InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            suffixIcon: IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchMovie(),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black12,
      centerTitle: true,

    );
  }
}
