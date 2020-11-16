import 'package:flutter/material.dart';
import 'package:CrudFutebol/model/futebol.dart';
import 'package:CrudFutebol/db/database_helper.dart';
import 'package:CrudFutebol/ui/futebol_screen.dart';
class ListViewFutebol extends StatefulWidget {
  @override
  _ListViewFutebolState createState() => new _ListViewFutebolState();
}
class _ListViewFutebolState extends State<ListViewFutebol> {
  List<Futebol> items = new List();
  //conexão com banco de dados
  DatabaseHelper db = new DatabaseHelper();
  @override
  void initState() {
    super.initState();
    db.getFutebols().then((futebols) {
      setState(() {
        futebols.forEach((futebol) {
          items.add(Futebol.fromMap(futebol));
        });
      });
    });
  }
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo de Cadastro',
      home: Scaffold(
        appBar: AppBar(

          title: Row(mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/futebol.jpg',
              fit: BoxFit.cover,
              height: 40.0,
              ),
              Text(' Times de Futebol Brasileiro')
          ]
        ),
        backgroundColor: Colors.blue[200],
        ),
        body: Container(decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://t2.uc.ltmcdn.com/pt/images/0/2/0/quanto_mede_a_trave_de_futebol_24020_orig.jpg'),
                    fit: BoxFit.cover,
                    )),
          child: Center(
          child: ListView.builder(
              
              itemCount: items.length,
              padding: const EdgeInsets.all(8.0),
              
              itemBuilder: (context, position) {

return Column(
  
         children: [
           Divider(height: 5.0),
           
           ListTile(
            
           //isThreeLine: true,
            title: Text(
                  '${items[position].nome} - ${items[position].fundacao}',
                  style: TextStyle(
                  fontSize: 20.0,
                    
                  ),
                  
              ),
            
            subtitle: Row(children: [
          
              Text(' ${items[position].presidente} |',
                  style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  
              )),
              Text(' ${items[position].mascote}',
                  style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                 
              )),
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                onPressed: () => _deleteFutebol(
                      context, items[position], position)),
          ],),
          leading: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 15.0,
              child: Text(
                '${items[position].id}',
                style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
                ),
              ),
          ),
onTap: () => _navigateToFutebol(context, items[position]),
),
],
                );
              }),
        ),),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewFutebol(context),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
void _deleteFutebol(BuildContext context, Futebol futebol, int position) async {
    db.deleteFutebol(futebol.id).then((futebols) {
      setState(() {
        items.removeAt(position);
      });
    });
  }
void _navigateToFutebol(BuildContext context, Futebol futebol) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FutebolScreen(futebol)),
    );
    if (result == 'update') {
      db.getFutebols().then((futebols) {
        setState(() {
          items.clear();
          futebols.forEach((futebol) {
            items.add(Futebol.fromMap(futebol));
          });
        });
      });
    }
  }
void _createNewFutebol(BuildContext context) async {
    //aguarda o retorno da página de cadastro
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FutebolScreen(Futebol('', '', '', ''))),
    );
    //se o retorno for salvar, recarrega a lista
    if (result == 'save') {
      db.getFutebols().then((futebols) {
        setState(() {
          items.clear();
          futebols.forEach((futebol) {
            items.add(Futebol.fromMap(futebol));
          });
        });
      });
    }
  }
}