function MavenArtifact(groupId, artifactId, latestVersion)
  local self = {}

  self.groupId = groupId
  self.artifactId = artifactId
  self.latestVersion = latestVersion

  return self
end

return MavenArtifact
