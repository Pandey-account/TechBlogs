package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.*;
import java.util.*;


public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> list = new ArrayList<>();

        try {
            String q = "select * from categories";
            Statement st = this.con.createStatement();
            ResultSet set = st.executeQuery(q);

            while (set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                Category c = new Category(cid, name, description);
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean savePost(Post p) {
        boolean f = false;
        try {

            String q = "insert into post(ptitle,pcontent,pcode,pic,catId,userId) values(?,?,?,?,?,?)";
            PreparedStatement pst = con.prepareStatement(q);
            pst.setString(1, p.getPtitle());
            pst.setString(2, p.getPcontent());
            pst.setString(3, p.getPcode());
            pst.setString(4, p.getPic());
            pst.setInt(5, p.getCatId());
            pst.setInt(6, p.getUserId());

            pst.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

//    get all the posts
    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();
//        fetch all the post
        try {
            PreparedStatement pst = con.prepareStatement("select * from post order by pid desc");
            ResultSet set = (ResultSet) pst.executeQuery();

            while (set.next()) {
                int pid = set.getInt("pid");
                String ptitle = set.getString("ptitle");
                String pcontent = set.getString("pcontent");
                String pcode = set.getString("pcode");
                String pic = set.getString("pic");
               Timestamp date = set.getTimestamp("pdate");
                int catId = set.getInt("catId");
                int userId = set.getInt("userId");

                Post post=new Post(pid, ptitle, pcontent, pcode, pic, date, catId, userId);

                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Post> getPostByCatId(int catId) {
        List<Post> list = new ArrayList<>();
//        fetch all post by id

        try {
            PreparedStatement pst = con.prepareStatement("select * from post where catId=?");
            pst.setInt(1, catId);
            ResultSet set = (ResultSet) pst.executeQuery();

            while (set.next()) {
                int pid = set.getInt("pid");
                String ptitle = set.getString("ptitle");
                String pcontent = set.getString("pcontent");
                String pcode = set.getString("pcode");
                String pic = set.getString("pic");
                Timestamp pdate = set.getTimestamp("pdate");

                int userId = set.getInt("userId");

                Post post = new Post(pid, ptitle, pcontent, pcode, pic, pdate, catId, userId);

                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public Post getPostByPostId(int postId){
        Post post=null;
        String q ="select * from post where pid=?";
        try{
            
        PreparedStatement pst=this.con.prepareStatement(q);
        pst.setInt(1, postId);
        ResultSet set=pst.executeQuery();
        
        if(set.next()){
                int pid=set.getInt("pid");
                String ptitle = set.getString("ptitle");
                String pcontent = set.getString("pcontent");
                String pcode = set.getString("pcode");
                String pic = set.getString("pic");
                Timestamp pdate = set.getTimestamp("pdate");
                int catId=set.getInt("catId");
                int userId = set.getInt("userId");

                 post = new Post(pid, ptitle, pcontent, pcode, pic, pdate, catId, userId);
        }
        
        }catch(Exception e){
            e.printStackTrace();
        }
        return post;
    }
}
