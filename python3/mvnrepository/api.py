from .search import search
from .formatters import getFormatter


def searchDeps(query: str):
    return list(search(query))
