class ScreenArguments {
  final String title;
  final String description;
  final String thumbnail;
  final DateTime updated_at;
  var steps;


  ScreenArguments(
    this.title, 
    this.description, 
    this.thumbnail, 
    this.updated_at,
    this.steps
  );
}
