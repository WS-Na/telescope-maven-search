function mavenFormatter(artifact)
  return {
    '<dependency>',
    string.format('    <groupId>%s</groupId>', artifact.groupId),
    string.format('    <artifactId>%s</artifactId>', artifact.artifactId),
    string.format('    <version>%s</version>', artifact.latestVersion),
    '</dependency>'
  }
end

function gradleFormatter(artifact)
  return {
    string.format("%s:%s:%s", artifact.groupId, artifact.artifactId, artifact.latestVersion)
  }
end

function leiningenFormatter(artifact)
  return {
    string.format('[%s/%s "%s"]', artifact.groupId, artifact.artifactId, artifact.latestVersion)
  }
end

function sbtFormatter(artifact)
  return {
    string.format(
      'libraryDependencies += "%s" %% "%s" %% "%s"',
      artifact.groupId, artifact.artifactId, artifact.latestVersion
    )
  }
end

return {
  maven = mavenFormatter,
  gradle = gradleFormatter,
  leiningen = leiningenFormatter,
  sbt = sbtFormatter,
}
