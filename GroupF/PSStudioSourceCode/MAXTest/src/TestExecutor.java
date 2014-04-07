import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;


public class TestExecutor {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		ScheduledExecutorService scheduledExecutorService =
		        Executors.newScheduledThreadPool(5);

		try {
			ScheduledFuture<?> scheduledFuture =
			    scheduledExecutorService.schedule(new Callable<Object>() {
			        public Object call() throws Exception {
			            System.out.println("Executed!");
			            return "Called!";
			        }
			    },
			    5,
			    TimeUnit.SECONDS);

			System.out.println("result = " + scheduledFuture.get());

			scheduledExecutorService.shutdown();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ExecutionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
