import urllib.request as request
import urllib.parse as parse
import json
import functools as f

from . import artifact

def compose(f, g):
    return lambda x: f(g(x))


def composeM(*fs):
    return f.reduce(compose, fs[1:], fs[0])


def get_in(m, *field_names):
    return f.reduce(lambda acc, field: acc[field], field_names, m)


def search(query: str):
    '''
    Search for `query` in Maven Central and return the corresponding list of `MavenArtifact`s.
    '''
    try:
        return composeM(
            f.partial(map, artifact.fromJson),
            lambda m: get_in(m, 'response', 'docs'),
            json.loads,
            lambda r: r.read(),
            request.urlopen
        )(f'https://search.maven.org/solrsearch/select?q={parse.quote(query)}&rows=50&wt=json')
    except:
        return []
