import 'package:mhd_ghaith_top_stories/app/app_management/strings_manager.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/http_client.dart';
import 'package:mhd_ghaith_top_stories/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:mhd_ghaith_top_stories/core/utils/enums.dart';

extension HTTPRequestType on RequestType {
  Future<Map<String, dynamic>> getHTTPRequestType(
    TopStoriesHttpClient httpClient,
    ParamsModel model,
  ) async {
    switch (this) {
      case RequestType.POST:
        return await httpClient.post(model);
      case RequestType.GET:
        return await httpClient.get(model);
    }
  }
}

extension FormattedString on Section {
  String getSectionTitle() {
    switch (this) {
      case Section.arts:
        return AppStrings.artsTitle;
      case Section.automobiles:
        return AppStrings.automobilesTitle;
      case Section.books:
        return AppStrings.booksTitle;
      case Section.business:
        return AppStrings.businessTitle;
      case Section.fashion:
        return AppStrings.fashionTitle;
      case Section.food:
        return AppStrings.foodTitle;
      case Section.health:
        return AppStrings.healthTitle;
      case Section.home:
        return AppStrings.homeTitle;
      case Section.insider:
        return AppStrings.insiderTitle;
      case Section.magazine:
        return AppStrings.magazineTitle;
      case Section.movies:
        return AppStrings.moviesTitle;
      case Section.nyregion:
        return AppStrings.nyregionTitle;
      case Section.obituaries:
        return AppStrings.obituariesTitle;
      case Section.opinion:
        return AppStrings.opinionTitle;
      case Section.politics:
        return AppStrings.politicsTitle;
      case Section.realestate:
        return AppStrings.realestateTitle;
      case Section.science:
        return AppStrings.scienceTitle;
      case Section.sports:
        return AppStrings.sportsTitle;
      case Section.sundayreview:
        return AppStrings.sundayreviewTitle;
      case Section.technology:
        return AppStrings.technologyTitle;
      case Section.theater:
        return AppStrings.theaterTitle;
      case Section.t_magazine:
        return AppStrings.t_magazineTitle;
      case Section.travel:
        return AppStrings.travelTitle;
      case Section.upshot:
        return AppStrings.upshotTitle;
      case Section.us:
        return AppStrings.usTitle;
      case Section.world:
        return AppStrings.worldTitle;
    }
  }

  String getAPIFormattedString() {
    switch (this) {
      case Section.arts:
        return AppStrings.artsAPI;
      case Section.automobiles:
        return AppStrings.automobilesAPI;
      case Section.books:
        return AppStrings.booksAPI;
      case Section.business:
        return AppStrings.businessAPI;
      case Section.fashion:
        return AppStrings.fashionAPI;
      case Section.food:
        return AppStrings.foodAPI;
      case Section.health:
        return AppStrings.healthAPI;
      case Section.home:
        return AppStrings.homeAPI;
      case Section.insider:
        return AppStrings.insiderAPI;
      case Section.magazine:
        return AppStrings.magazineAPI;
      case Section.movies:
        return AppStrings.moviesAPI;
      case Section.nyregion:
        return AppStrings.nyregionAPI;
      case Section.obituaries:
        return AppStrings.obituariesAPI;
      case Section.opinion:
        return AppStrings.opinionAPI;
      case Section.politics:
        return AppStrings.politicsAPI;
      case Section.realestate:
        return AppStrings.realestateAPI;
      case Section.science:
        return AppStrings.scienceAPI;
      case Section.sports:
        return AppStrings.sportsAPI;
      case Section.sundayreview:
        return AppStrings.sundayreviewAPI;
      case Section.technology:
        return AppStrings.technologyAPI;
      case Section.theater:
        return AppStrings.theaterAPI;
      case Section.t_magazine:
        return AppStrings.t_magazineAPI;
      case Section.travel:
        return AppStrings.travelAPI;
      case Section.upshot:
        return AppStrings.upshotAPI;
      case Section.us:
        return AppStrings.usAPI;
      case Section.world:
        return AppStrings.worldAPI;
    }
  }
}
