// import 'graphql/graphql_helpers/queries/profile/profilel_query.dart';
// import 'graphql/graphql_service.dart';

// class ApiSdk {
//   static loginWithEmailAndPassword(dynamic variables) async {
//     final response =
//         await GraphqlService.postMutation(ProfileQuery.login, variables);
//     return response.data['AuthCollection']['userLogin'];
//   }

//   static signUpWithEmailAndPassword(dynamic variables) async {
//     final response =
//         await GraphqlService.getQuery(ProfileQuery.register, variables);
//     return response.data['register'];
//   }

//   static getUserData(int id) async {
//     final response =
//         await GraphqlService.getQuery(ProfileQuery.users, {"id": id});
//     return response.data['user'];
//   }
// }
