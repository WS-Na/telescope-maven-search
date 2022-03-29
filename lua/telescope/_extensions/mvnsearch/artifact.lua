function MavenArtifact(
  groupId,
  artifactId,
  latestVersion
) {
  local self = {}

  self.groupdId = groupId
  self.artifactId = artifactId
  self.latestVersion = latestVersion

  return self
}

return MavenArtifact
