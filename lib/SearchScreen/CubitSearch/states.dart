
abstract class ShopSearchStates{}

class ShopSearchInitialState extends ShopSearchStates{}

class SearchLoadingState extends ShopSearchStates {}

class ShopSearchSuccessState extends ShopSearchStates {}

class ShopSearchErrorState extends ShopSearchStates
{
  final String error;

  ShopSearchErrorState(this.error);
}
