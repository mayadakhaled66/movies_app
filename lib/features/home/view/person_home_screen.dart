import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies_app/components/app_page.dart';
import 'package:movies_app/features/home/model/home_response_model.dart';
import 'package:movies_app/features/home/model/person_details_model.dart';
import 'package:movies_app/features/home/view/person_card_view.dart';
import 'package:movies_app/features/home/view/person_detail_screen.dart';
import 'package:movies_app/features/home/view_model/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeResponseModel? _homeResponseModel;
  int _pageSize = 0;
  List<String> cachedList =[];
  final PagingController<int, Result> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      BlocProvider.of<HomeBloc>(context).add(LoadPopularPeopleEvent(pageKey));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AppMainPage(
      isPageWithAppbar: true,
      appBarTitle: "Most Popular Artists",
      pageBody: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomePageLoading) {
              } else if (state is HomePageFail) {
                _pagingController.error = state.error;
                showSnackBarError(state.error);
              } else if (state is HomePageSuccessState) {
                _homeResponseModel = null;
                _homeResponseModel = state.model;
                _pageSize = _homeResponseModel!.totalPages ?? 0;
                final next = (_homeResponseModel?.page ?? 1) + 1;
                if (next > _pageSize) {
                  _pagingController
                      .appendLastPage(_homeResponseModel?.results ?? []);
                } else {
                  _pagingController.appendPage(
                      _homeResponseModel?.results ?? [], next);
                }
              } else if (state is PersonDetailsSuccessState) {
                navigateToDetails(state.model);
              }
            },
            child: PagedListView<int, Result>(
              pagingController: _pagingController,
              shrinkWrap: true,
              builderDelegate: PagedChildBuilderDelegate<Result>(
                itemBuilder: (context, item, index) => GestureDetector(
                  child: PersonCardView(
                    currentPersonData: item,
                  ),
                  onTap: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(LoadPopularPeopleDetailsEvent(item.id ?? 0));
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToDetails(PersonDetailsResponseModel personData) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PersonDetailScreen(personData: personData)));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  showSnackBarError(String error) {
    final snackBar = SnackBar(
      content: Text(error),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
