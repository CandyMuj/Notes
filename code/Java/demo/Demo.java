class Demo {

    public static void log(Object... arg) {
        for (int i = 0; i < arg.length; ++i) {
            System.out.println(arg[i]);
        }
    }

    static class DemoThreadPool {
        public static void main(String[] arg) {
            log("先执行我哦~~~");

            ThreadPool.getInstance().submit(() -> {
                try {
                    Thread.sleep(10000);
                    log("我终于也执行完了~~~");
                } catch (Exception e) {
                    log("线程池内的方法执行出错...");
                    e.printStackTrace();
                }
            });

            log("我先返回结果啦~~~");
        }
    }

}