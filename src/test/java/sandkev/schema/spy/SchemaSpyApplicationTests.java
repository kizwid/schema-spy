package sandkev.schema.spy;

import net.sourceforge.schemaspy.Config;
import net.sourceforge.schemaspy.SchemaAnalyzer;
import org.hsqldb.Server;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@RunWith(SpringRunner.class)
@SpringBootTest
public class SchemaSpyApplicationTests {

	@Test
	public void contextLoads() throws Exception {

		CountDownLatch startLatch = new CountDownLatch(1);
		ExecutorService executorService = Executors.newFixedThreadPool(1);
		executorService.submit(new Runnable() {
			@Override
			public void run() {
				//expose our database to schema spy...
				Server hsqlServer = new Server();
				hsqlServer.setPort(9137);
				hsqlServer.setDatabaseName(0, "testDb");
				hsqlServer.setDatabasePath(0, "mem:testDb");
				hsqlServer.start();
				startLatch.countDown();
			}
		});

		startLatch.await();

		// commandline tools
		//java -jar schemaspy-5.0.0.jar -t hsqldb -db testDb -s PUBLIC -u sa -host localhost:9137 -o . -dp C:/Users/kevsa/.m2/repository/org/hsqldb/hsqldb/2.3.3/hsqldb-2.3.3.jar
		//java -cp hsqldb-2.3.3.jar org.hsqldb.util.DatabaseManagerSwing

		//6.1.0
		//java -jar schemaspy-6.1.0.jar -t hsqldb -dp C:/Users/kevsa/.m2/repository/org/hsqldb/hsqldb/2.3.3/hsqldb-2.3.3.jar -db testDb -host localhost -port 9137 -s PUBLIC -u sa -o .

		//CountDownLatch latch = new CountDownLatch(1);
		//latch.await();

		//generate schema diagrams
		SchemaAnalyzer sa = new SchemaAnalyzer();
		Config config = new Config();
		config.setDbType("hsqldb");
		config.setUser("sa");
		config.setHost("localhost:9137");
		config.setSchema("PUBLIC");
		config.setDb("testDb");
		config.setHighQuality(true);
		config.setOutputDir("target/_diagrams");
		config.setGraphvizDir("target/graphviz-2.38/bin"); //unpacked by dependency plugin

		sa.analyze(config);

	}

}
