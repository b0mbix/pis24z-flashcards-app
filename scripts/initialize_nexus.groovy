import org.sonatype.nexus.repository.storage.WritePolicy
import org.sonatype.nexus.repository.maven.MavenHostedRepository

repository.createMavenHosted('pis24z-dependencies', 'default', true, WritePolicy.ALLOW, null, MavenHostedRepository.ContentDisposition.INLINE)
