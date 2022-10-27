import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final String _label;

  const SearchBarWidget(this._label, {super.key});
  
  @override
  State<StatefulWidget> createState() => SearchBarWidgetState();
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: const EdgeInsets.only(top: 2,bottom: 2,left: 16),
      child: Container(
        height: 35,
        width:  MediaQuery.of(context).size.width-64,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(230,230,230,1.0),
            borderRadius: BorderRadius.circular(20)
        ),
        child: InkWell(
          child: Row(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: Icon(Icons.search,color: Colors.teal)),
              Text("搜索",style: TextStyle(color: Colors.grey,fontSize: 15),)
            ],
          ),
          onTap: (){
            showSearch(context: context,delegate: SearchBarDelegate());
          },
        ),
      ),
    );
  }
}


const searchList = [
  "wangcai",
  "xiaoxianrou",
  "dachangtui",
  "nvfengsi"
];

const recentSuggest = [
  "wangcai推荐-1",
  "nvfengsi推荐-2"
];

class SearchBarDelegate extends SearchDelegate<String>{
//重写右侧的图标
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed:()=>query = "",
      )
    ];
  }
//重写返回图标
  @override
  Widget buildLeading(BuildContext context){
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation
        ),
        //关闭上下文，当前页面
        onPressed: ()=>close(context, '')
    );
  }

  //重写搜索结果
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

@override
  Widget buildSuggestions(BuildContext context){
    final suggestionList = query.isEmpty
        ? recentSuggest
        : searchList.where((input)=> input.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length ,
      itemBuilder: (context,index)=>ListTile(
      title: RichText(
        text: TextSpan(
          text: suggestionList[index].substring(0,query.length),
          style:const TextStyle(
          color: Colors.black,fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: suggestionList[index].substring(query.length),
              style: const TextStyle(color: Colors.grey)
            )
          ]
        ),
      ),)
    );
  }

}
