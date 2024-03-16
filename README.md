# Top Stories

#### This project is the assessment of the Flutter Developer position at BAB ALOMDA.

* Author: Mhd Ghaith Al Abtah
* Last update: 16/03/2024

______________________________________

### General Notes:

#### 1- The code architecture used in this project is `Clean Architecture`.

#### 2- `json_serializable` package is used to generate `fromJSON` constructors and `toJSON` methods.

#### 3- `flutter_screenutil` package is used to maintain an adaptive design various different screen sizes and orientations.

- [TopStoriesMaterial](lib/app/top_stories_material.dart)

#### 4- `go_router` package is used for navigation and every needed dependency in the route we are navigating into is injected before, except `initAppModule` which is injected when the app runs.

- [DependencyInjection](lib/app/dependency_injection/dependency_injection.dart)
- [RouteGenerator](lib/app/app_management/route_manager.dart)

#### 5- There is a `workflow` file to build a release whenever a PR is merged into the main branch.

- [Workflow](.github/workflows/main.yaml)

#### 6- There is a `caching` mechanism that will help to reduce the API requests by caching the top stories by section after adding a timestamp for five minutes. It works by serializing [CacheTopStoriesModel](lib/features/top_stories/data/local/models/cache_top_stories_model.dart) into JSON encoded String and store it in the [AppStorage](lib/app/storage/app_storage.dart) (`SharedPreferences`) as String.

- [TopStoriesBloc](lib/features/top_stories/presentation/bloc/top_stories_bloc/top_stories_bloc.dart)

#### 7- There is unit tests for the most important classes in the project: [TopStoriesBloc](lib/features/top_stories/presentation/bloc/top_stories_bloc/top_stories_bloc.dart), [TopStoriesRemoteDataSource](lib/features/top_stories/data/remote/data_sources/top_stories_remote_data_source.dart), [TopStoriesResponse](lib/features/top_stories/data/remote/models/response/top_stories_api_response.dart), [TopStoriesRepository](lib/features/top_stories/data/remote/repositories/top_stories_repository.dart), [GetTopStoriesUseCase](lib/features/top_stories/domain/use_cases/get_top_stories_use_case.dart).

______________________________________

#### 1- [SplashCubit](lib/features/splash/presentation/bloc/splash_cubit/splash_cubit.dart)

* This cubit is injected as `Factory` when we navigate
  into [SplashScreen](lib/features/splash/presentation/screens/splash_screen.dart) and the created instance will be
  closed when the [SplashScreen](lib/features/splash/presentation/screens/splash_screen.dart) is disposed.
* It's only responsibility is to store the APIKey in
  the [AppStorage](lib/app/storage/app_storage.dart) (`SharedPreferences`) when the app is opened for the first time to
  be used later on.

#### 2- [TopStoriesBloc](lib/features/top_stories/presentation/bloc/top_stories_bloc/top_stories_bloc.dart)

* This Bloc is injected as `Factory` when we navigate
  into [TopStoriesScreen](lib/features/top_stories/presentation/screens/top_stories_screen.dart).
* It's responsible to manage the state
  of [TopStoriesScreen](lib/features/top_stories/presentation/screens/top_stories_screen.dart).
* It has four events:
    * `GetTopStories`:
        * This event will get the top stories either from the **remote data source** or from **cache**.
        * It gets called
          from [TopStoriesScreen](lib/features/top_stories/presentation/screens/top_stories_screen.dart) when
          it first opens or when the user changes the section filter or the user use the `pullToRefresh`.
        * It handles every error state including the **No internet connection**.
        * If the section that the user requested is found into cache, and it's valid, it will be returned to the screen.
          Else it will be requested from the remote data source and cached for five minutes.
    * `ChangeViewType`:
        * This event will change between `listView` and `gridView`.
    * `ShowHideFilter`:
        * This event will show or hide filters.
    * `SearchInStories`:
        * This event will search into the current viewed top stories.
        * If no result is found, it will emit a state to indicate that.

