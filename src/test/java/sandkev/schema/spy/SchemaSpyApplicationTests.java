package sandkev.schema.spy;

import net.sourceforge.schemaspy.Config;
import net.sourceforge.schemaspy.SchemaAnalyzer;
import org.hsqldb.Server;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class SchemaSpyApplicationTests {

	@Test
	public void contextLoads() throws Exception {
		//expose our database to schema spy...
		Server hsqlServer = new Server();
		hsqlServer.setDatabaseName(0, "testDb");
		hsqlServer.setDatabasePath(0, "mem:testDb");
		hsqlServer.start();

		// commandline tools
		//java -jar schemaspy-5.0.0.jar -t hsqldb -db testDb -s PUBLIC -u sa -host localhost -o . -dp hsqldb-2.3.3.jar
		//java -cp hsqldb-2.3.3.jar org.hsqldb.util.DatabaseManagerSwing

		//generate schema diagrams
		SchemaAnalyzer sa = new SchemaAnalyzer();
		Config config = new Config();
		config.setDbType("hsqldb");
		config.setUser("sa");
		config.setHost("localhost");
		config.setSchema("PUBLIC");
		config.setDb("testDb");
		config.setHighQuality(true);
		config.setOutputDir("target/_diagrams");
		config.setGraphvizDir("/usr/local/bin"); //unpacked by dependency plugin

		sa.analyze(config);

	}

}
