from .search import search


def searchDeps(query: str):
    return [f'{a.groupId}:{a.artifactId}:{a.latestVersion}' for a in search(query)]
