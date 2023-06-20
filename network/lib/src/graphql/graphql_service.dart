import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphql_helpers/graphql_config.dart';

class GraphqlApi {
  GraphqlApi._internal();

  static final _singleton = GraphqlApi._internal();

  factory GraphqlApi() => _singleton;

  static ValueNotifier<GraphQLClient> createClient() {
    final HttpLink httpLink = HttpLink(baseUrl);

    final TempStorage prefs = TempStorage.instance;

    final WebSocketLink websocketLink = WebSocketLink(socketUrl,
        config: SocketClientConfig(
            autoReconnect: true,
            inactivityTimeout: const Duration(minutes: 20),
            initialPayload: {
              "Authorization": "Bearer ${prefs.getAuthToken()}"
            }),
        subProtocol: GraphQLProtocol.graphqlTransportWs);

    final AuthLink authLink =
        AuthLink(getToken: () => 'Bearer ${prefs.getAuthToken()}');

    final Link link = authLink.concat(httpLink).concat(websocketLink);

    if (kDebugMode) {
      print("this is the link ${link.toString()}");
    }

    Link socketOrRestLink =
        Link.split((request) => request.isSubscription, websocketLink, link);
    ValueNotifier<GraphQLClient> graphQLClient = ValueNotifier(GraphQLClient(
      link: socketOrRestLink,
      cache: GraphQLCache(),
    ));

    return graphQLClient;
  }
}

class GraphqlService {
  Future<Either<List<GraphQLError>, Map<String, dynamic>>> getQuery(
    String document, [
    Map<String, dynamic> variables = const {},
  ]) async {
    try {
      final graphQLClient = GraphqlApi.createClient();

      QueryResult response = await graphQLClient.value.query<dynamic>(
        QueryOptions<dynamic>(
          document: gql(document),
          variables: variables,
        ),
      );

      if (response.hasException) {
        final err = response.exception;
        return left(err!.graphqlErrors);
      } else {
        return right(response.data!);
      }
    } catch (err) {
      return Left([GraphQLError(message: err.toString())]);
    }
  }

  Future<Either<List<GraphQLError>, Map<String, dynamic>>> postMutation(
    String document, [
    Map<String, dynamic> variables = const {},
  ]) async {
    try {
      final graphQLClient = GraphqlApi.createClient();

      QueryResult response = await graphQLClient.value.mutate<dynamic>(
        MutationOptions<dynamic>(
          document: gql(document),
          variables: variables,
        ),
      );
      if (response.hasException) {
        if (kDebugMode) {
          print(
              "Error nacjj ${response.exception!.graphqlErrors.first.message}");
        }
        final err = response.exception;
        return left(err!.graphqlErrors);
      } else {
        return right(response.data!);
      }
    } catch (err, s) {
      if (kDebugMode) {
        print("Error nacjj ${err.toString()}");
        print("Stack hit $s");
      }

      return Left([GraphQLError(message: err.toString())]);
    }
  }

  Stream<QueryResult<dynamic>> subscriptions(
    String document, [
    Map<String, dynamic> variables = const {},
  ]) async* {
    final graphQLClient = GraphqlApi.createClient();
    yield* graphQLClient.value.subscribe<dynamic>(
      SubscriptionOptions(document: gql(document), variables: variables),
    );
  }
}
