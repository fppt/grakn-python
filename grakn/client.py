"""Grakn python client."""

from typing import Dict, Any

import requests

_HEADERS: Dict[str, str] = {'Accept': 'application/graql+json'}
_QUERY_ENDPOINT: str = '/kb/{}/graql'


class Client:
    """Client to a Grakn knowledge base, identified by a uri and a keyspace."""

    DEFAULT_URI: str = 'http://localhost:4567'
    DEFAULT_KEYSPACE: str = 'grakn'



    def __init__(self, uri: str = DEFAULT_URI, keyspace: str = DEFAULT_KEYSPACE):
        self.uri = uri
        self.keyspace = keyspace

    def execute(self, query: str, *, infer: bool = True) -> Any:
        """Execute a Graql query against the knowledge base

        :param query: the Graql query string to execute against the knowledge base
        :param infer: enable inference
        :return: a list of query results

        :raises: GraknError, requests.exceptions.ConnectionError
        """
        response = self._post(query, infer=infer)

        if response.ok:
            return response.json()
        else:
            raise GraknError(response.json()['exception'])

    def _post(self, query: str, *, infer: bool) -> requests.Response:
        params = self._params(infer=infer)
        url = self._url()
        return requests.post(url, data=query, params=params, headers=_HEADERS)

    def _url(self) -> str:
        endpoint = _QUERY_ENDPOINT.format(self.keyspace)
        return f'{self.uri}{endpoint}'

    def _params(self, *, infer: bool) -> Dict[str, Any]:
        return {
            'keyspace': self.keyspace, 'infer': infer, 'materialise': False
        }


class GraknError(Exception):
    """An exception when executing an operation on a Grakn knowledge base"""
    pass
