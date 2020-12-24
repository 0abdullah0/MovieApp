class TrailerModel{
  List<TResult> results=[];

  TrailerModel.fromJson(Map<String,dynamic> parse){
    List<TResult> temp= [];
    for(var i=0;i<parse['results'].length;++i){
      TResult result=TResult(parse['results'][i]);
      temp.add(result);
    }
    results=temp;
  }
}

class TResult{

  String key;
  String name;
  TResult(result){
    key=result['key'].toString();
    name=result['name'].toString();
  }

  String get get_key=> key;
  String get get_name=> name;

}