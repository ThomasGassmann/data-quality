import graphqlapi.utils as utils
from graphqlapi.proxy import proxy_request
from graphqlapi.interceptors import GraphQlRequestException, GraphQlRequestInterceptor
from flask_restplus import Resource, fields
from flask import request, abort, jsonify


def register_graphql(namespace, api):

    # Create expected headers and payload
    headers = api.parser()
    payload = api.model('Payload', {'query': fields.String(
        required=True,
        description='GraphQL query or mutation',
        example='{allIndicatorTypes{nodes{id,name}}}')})

    @namespace.route('/graphql', endpoint='with-parser')
    @namespace.doc()
    class GraphQL(Resource):

        @namespace.expect(headers, payload, validate=True)
        def post(self):
            """
            Execute GraphQL queries and mutations
            Use this endpoint to send http request to the GraphQL API.
            """
            payload = request.json
            try:
                code, result = proxy_request(payload)
                return jsonify(result), code
            except GraphQlRequestException as ex:
                return ex.to_response()