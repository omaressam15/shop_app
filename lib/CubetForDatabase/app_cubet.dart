import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Dio/sherd_prefrens.dart';
import 'package:sqflite/sqflite.dart';
import 'app_state.dart';

class AppCubit extends Cubit <AppState>{

  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  bool checkBox = false ;

  int index = 0;

  Database database;

  bool isButtonSheet = false;

  bool select = false;

  IconData icons = Icons.edit;
  IconData icon = Icons.check_box_outline_blank;

  List <Map> newTasks = [];
  List <Map> doneTasks = [];
  List <Map> achievedTasks = [];

 /* List <Widget> widgetList = [

    TaskScreen(),

    DoneScreen(),

    AchievedScreen(),

  ];*/

  List <String> text = [

    'Task', 'Done', 'achieved',

  ];

 /* void changeButtonNavigationBar(int index) {

     selectedIndex = index;

     emit(ChangeButtonNavigationBarState());

  }

  updateDatabase({@required states,@required id}) {
    return database.rawUpdate(
        'UPDATE task SET status = ?  WHERE id = ?',

        ['$states', id]).then((value) {

          getFromDatabase(database);
          emit(UpdateDataBaseState());

    });

  }

  void createDatabase() {

     openDatabase('todo.db',version: 1,

        onCreate: (database, version) {
          print('database created');

          database.execute(
              'CREATE TABLE task (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT )')
              .then((value) {

            print('table created');
          }).catchError((onError) {
            print('Error when created table ${onError.toString()}');
          });
        },

        onOpen: (database) {
          getFromDatabase(database);
          print('database open');
        }
    ).then((value) {
      database = value;
      emit(CreateDataBaseState());
     });

  }

  void deleteDatabase ({@required int id})async{

    database.rawDelete('DELETE FROM task WHERE id = ?', [id]).then((value) {
      getFromDatabase(database);
      emit(DeleteDataBaseState());
    });

  }

  void getFromDatabase (database) {

    newTasks = [];
    doneTasks= [];
    achievedTasks = [];

    emit(LoadingScreenState());

     database.rawQuery('SELECT * FROM task').then((value) {


      value.forEach((element) {

        if(element['status'] =='new')
          newTasks.add(element);

          else if(element['status'] == 'done')
          doneTasks.add(element);

          else
            achievedTasks.add(element);

        print(element['status']);

        emit(GetDataBaseState());



      });



    });

  }

  void insertToDatabase({@required title, @required date, @required time}) {

     database.transaction((txn) {

      txn.rawInsert('INSERT INTO task (title, date, time, status) VALUES ("$title" , "$date" , "$time" , "new")')
          .then((value) {
            emit(InsertDataBaseState());
        print('$value inserted successfully');

            getFromDatabase(database);

      }).catchError((error){

        print('Error When Inserting New Record ${error.toString ()}');

      });

      return null;

    });

  }

  void changeButtonSheets ({@required  IconData iconData ,@required bool isShow}){
    
    isButtonSheet = isShow;
    
    icons = iconData;
    
    emit(ChangeSheetState());

  }

  void changeIcon({@required IconData iconData,@required bool selected}){

    icon = iconData;

    select = selected;

    emit(ChangIconState());

  }
*/

  bool isDark = false;

  void changThemeMode({bool fromShard}){

    if(fromShard !=null){
      isDark = fromShard;
      emit(AppChangeModeState());

    }else{

      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());

      });
    }
  }
}

