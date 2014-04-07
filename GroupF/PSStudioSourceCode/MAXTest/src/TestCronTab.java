import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;


public class TestCronTab {
	
	public static void main(String[] args) {
		ScheduledExecutorService scheduledExecutorService =
		        Executors.newScheduledThreadPool(1);
		
	    final Runnable beeper = new Runnable() {
	        public void run() { System.out.println("beep"); }
	    };
	    final ScheduledFuture<?> beeperHandle =
	    scheduledExecutorService.scheduleAtFixedRate(beeper, 1, 2, TimeUnit.SECONDS);
	    try {
			Thread.sleep(10000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    scheduledExecutorService.shutdown();
	}
}
