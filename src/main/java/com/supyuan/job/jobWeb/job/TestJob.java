package com.supyuan.job.jobWeb.job;

public class TestJob extends BaseJob {

    public String add(String name, String emali) {
        System.out.println("@@@@@@@@add: name->" + name + " emali->" + emali);
        return "";
    }

    public String del(String param1, String content, String data) {
        System.out.println("@@@@@@@@del: param1->" + param1 + " content->" + content + " data->" + data);
        return "";
    }

    public String upd(String adds, Integer tel) {
        System.out.println("@@@@@@@@upd: adds->" + adds + " tel->" + tel);
        return "";
    }

    public String sel(String uids, int num) {
        System.out.println("@@@@@@@@sel: uids->" + uids + " num->" + num);
        return "";
    }

    public String hello() {
        System.out.println("@@@@@@@@hello: hello");
        return "";
    }


}
