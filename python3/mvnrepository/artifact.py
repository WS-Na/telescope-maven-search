from typing import Mapping
from collections import namedtuple


MavenArtifact = namedtuple('MavenArtifact', ['groupId', 'artifactId', 'latestVersion'])

def fromJson(json: Mapping[str, str]) -> 'MavenArtifact':
    return MavenArtifact(
        groupId       = json['g'],
        artifactId    = json['a'],
        latestVersion = json['latestVersion']
    )
