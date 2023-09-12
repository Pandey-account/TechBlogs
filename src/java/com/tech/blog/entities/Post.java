
package com.tech.blog.entities;

import java.sql.*;

public class Post {
    
    private int pid;
    private String ptitle;
    private String pcontent;
    private String pcode;
    private String pic;
    private Timestamp pdate;
    private int catId;
    private int userId;

    public Post() {
    }

    public Post(int pid, String ptitle, String pcontent, String pcode, String pic, Timestamp pdate, int catId,int userId) {
        this.pid = pid;
        this.ptitle = ptitle;
        this.pcontent = pcontent;
        this.pcode = pcode;
        this.pic = pic;
        this.pdate = pdate;
        this.catId = catId;
        this.userId = userId;
    }

    public Post(String ptitle, String pcontent, String pcode, String pic, Timestamp pdate, int catId,int userId) {
        this.ptitle = ptitle;
        this.pcontent = pcontent;
        this.pcode = pcode;
        this.pic = pic;
        this.pdate = pdate;
        this.catId = catId;
        this.userId = userId;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getPtitle() {
        return ptitle;
    }

    public void setPtitle(String ptitle) {
        this.ptitle = ptitle;
    }

    public String getPcontent() {
        return pcontent;
    }

    public void setPcontent(String pcontent) {
        this.pcontent = pcontent;
    }

    public String getPcode() {
        return pcode;
    }

    public void setPcode(String pcode) {
        this.pcode = pcode;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }

    public Timestamp getPdate() {
        return pdate;
    }

    public void setPdate(Timestamp pdate) {
        this.pdate = pdate;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

   
    
}
