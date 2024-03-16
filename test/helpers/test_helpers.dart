import "package:mhd_ghaith_top_stories/app/storage/app_storage.dart";
import "package:mhd_ghaith_top_stories/core/features/data/remote_data_source/http_client.dart";
import "package:mhd_ghaith_top_stories/core/network/network_info.dart";
import "package:mhd_ghaith_top_stories/features/top_stories/data/remote/data_sources/top_stories_remote_data_source.dart";
import "package:mhd_ghaith_top_stories/features/top_stories/domain/repositories/itop_stories_repository.dart";
import "package:mhd_ghaith_top_stories/features/top_stories/domain/use_cases/get_top_stories_use_case.dart";
import "package:mockito/annotations.dart";

@GenerateMocks(
  [
    ITopStoriesRepository,
    ITopStoriesRemoteDataSource,
    NetworkInfo,
    GetTopStoriesUseCase,
    AppStorage,
  ],
  customMocks: [MockSpec<TopStoriesHttpClient>(as: #MockHttpClient)],
)
void main() {}
