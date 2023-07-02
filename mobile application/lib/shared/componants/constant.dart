//
//
// late Database database ;
// List<Map> userData =[];
//
// void createDataBase() async {
//   database = await openDatabase(
//     'graduationProject.db',
//     version: 1,
//     onCreate: (database , version)
//     {
//       print('database created');
//       database.execute('CREATE TABLE Regester (id INTEGER PRIMARY KEY, Fname TEXT , Lname TEXT , phone INTEGER ,Email TEXT ,password TEXT )').then((value) => print('table created')
//       ).catchError((error){
//         print('table not created ${error.toString()}');
//       });
//     },
//     onOpen: (database) {
//       getDataFromDataBase(database).then((value) {
//         userData = value;
//         print(userData);
//       });
//       print('database opened');
//     },
//   );
//
// }
//
// Future insertDataBase({
//   required String Fname,
//   required String Lname,
//   required String phone,
//   required String Email,
//   required String password,
// }) async {
//   return await database.transaction((txn) async
//   {
//     await txn
//         .rawInsert('INSERT INTO Regester (Fname , Lname , phone ,Email ,password) VALUES ("$Fname","$Lname","$phone","$Email","$password")').then((value) => print('${value}table inserted')
//     )
//         .catchError((error){
//       print('table not inserted ${error.toString()}');
//     });
//   }
//
//   );
// }
//
// Future<List<Map>> getDataFromDataBase(database) async
// {
//    return userData = await database.rawQuery('SELECT * FROM Regester');
// }
//
//
