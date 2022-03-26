# Mapping from formatter type to the actual formatter function
_formatters = {}

def formatter(typ: str):
    def inner(func):
        global _formatters
        _formatters[typ] = func
        return func
    return inner

@formatter('maven')
def _mavenFormatter(artifact: 'MavenArtifact'):
    return f'''\
<dependency>
    <groupId>{artifact.groupId}</groupId>
    <artifactId>{artifact.artifactId}</artifactId>
    <version>{artifact.latestVersion}</version>
</dependency>'''


@formatter('gradle')
def _gradleFormatter(artifact: 'MavenArtifact'):
    return f'{artifact.groupId}:{artifact.artifactId}:{artifact.latestVersion}'


@formatter('leiningen')
def _leiningenFormatter(artifact: 'MavenArtifact'):
    return f'[{artifact.groupId}/{artifact.artifactId} "{artifact.latestVersion}"]'


@formatter('sbt')
def _sbtFormatter(artifact: 'MavenArtifact'):
    return f'libraryDependencies += "{artifact.groupdId}" % "{artifact.artifactId}" % "{artifact.latestVersion}"'


def getFormatter(typ: str):
    '''
    Return an appropriate formatter for the given type.
    '''
    global _formatters
    return _formatters.get(typ, 'maven')
