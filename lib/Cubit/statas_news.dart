
abstract class NewsStats {}

class InitialNewsState extends NewsStats{}

class ChangeButtonNavigationBar extends NewsStats{}

class LoadingToGetBusinessStats extends NewsStats{}

class GetBusinessDataStats extends NewsStats{}

class ErrorGetBusinessDataStats extends NewsStats{

 final String error ;

  ErrorGetBusinessDataStats(this.error);


}
class LoadingToGetSportsStats extends NewsStats{}

class GetSportsDataStats extends NewsStats{}

class ErrorGetSportsDataStats extends NewsStats{

 final String error ;

  ErrorGetSportsDataStats(this.error);


}
class LoadingToGetScienceStats extends NewsStats{}

class GetScienceDataStats extends NewsStats{}

class ErrorGetScienceDataStats extends NewsStats{

 final String error ;

  ErrorGetScienceDataStats(this.error);


}


class LoadingToGetSearchStats extends NewsStats{}

class GetSearchDataStats extends NewsStats{}

class ErrorGetSearchDataStats extends NewsStats{

 final String error ;

  ErrorGetSearchDataStats(this.error);


}

class AppChangeMode extends NewsStats{}




