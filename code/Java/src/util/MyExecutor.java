package util;

import java.util.concurrent.*;

/**
 * 这也是一个线程池，可以自定义一些参数
 */
public class MyExecutor {
    private static ThreadPools threadPool;

    public static ThreadPools getInstance() {
        synchronized (ThreadPools.class) {
            if (threadPool == null) {
                threadPool = new ThreadPools(3, 5, 0L);
            }
            return threadPool;
        }
    }

    public static class ThreadPools {
        private ThreadPoolExecutor poolExecutor;
        private int corePoolSize;
        private int maximumPoolSize;
        private long keepAliveTime;

        public ThreadPools(int corePoolSize, int maximumPoolSize, long keepAliveTime) {
            this.corePoolSize = corePoolSize;
            this.maximumPoolSize = maximumPoolSize;
            this.keepAliveTime = keepAliveTime;
        }

        public void execute(Runnable runnable) {
            if (poolExecutor == null || poolExecutor.isShutdown()) {
                poolExecutor = new ThreadPoolExecutor(
                        corePoolSize,
                        maximumPoolSize,
                        keepAliveTime,
                        TimeUnit.MILLISECONDS,
                        new LinkedBlockingQueue<Runnable>(),
                        Executors.defaultThreadFactory()
                );
            }
            System.out.println("running thread on pool");
            poolExecutor.execute(runnable);
        }
    }

}
