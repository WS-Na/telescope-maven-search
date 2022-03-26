from .search import search
from .formatters import getFormatter


def searchDeps(query: str, format: str = 'gradle'):
    formatter = getFormatter(format)
    return [formatter(artifact) for artifact in search(query)]
