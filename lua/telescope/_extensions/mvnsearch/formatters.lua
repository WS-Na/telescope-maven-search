function mavenFormatter(artifact)
  return string.format([[
<dependency>
    <groupId>%s</groupId>
    <artifactId>%s</artifactId>
    <version>%s</version>
</dependency>
  ]], artifact.groupId, artifact.artifactId, artifact.latestVersion)
end

function gradleFormatter(artifact)
  return string.format("%s:%s:%s", artifact.groupId, artifact.artifactId, artifact.latestVersion)
end

function leiningenFormatter(artifact)
  return string.format('[%s/%s "%s"]', artifact.groupId, artifact.artifactId, artifact.latestVersion)
end

function sbtFormatter(artifact)
  return string.format(
    'libraryDependencies += "%s" %% "%s" %% "%s"',
    artifact.groupId, artifact.artifactId, artifact.latestVersion
  )
end

return {
  maven = mavenFormatter,
  gradle = gradleFormatter,
  leiningen = leiningenFormatter,
  sbt = sbtFormatter,
}
