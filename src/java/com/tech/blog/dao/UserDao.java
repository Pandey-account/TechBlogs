package com.tech.blog.dao;

import com.tech.blog.entities.User;
import java.sql.*;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    //method to insert user to data bas;
    public boolean saveUser(User user) {

        boolean f = false;
        try {
//            User --> database

            String q = "insert into  user(name,email,password,gender,about) values(?,?,?,?,?)";
            PreparedStatement pst = this.con.prepareStatement(q);

            pst.setString(1, user.getName());
            pst.setString(2, user.getEmail());
            pst.setString(3, user.getPassword());
            pst.setString(4, user.getGender());
            pst.setString(5, user.getAbout());

            pst.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
//    get user by useremail and userpassword

    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;
        try {
            String q = "select * from user where email=? and password=?";

            PreparedStatement pst = con.prepareStatement(q);
            pst.setString(1, email);
            pst.setString(2, password);

            ResultSet set = pst.executeQuery();

            if (set.next()) {
                user = new User();
//               Data db
                String name = set.getString("name");
//               set to user object
                user.setName(name);
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public boolean UpdateUser(User user){
        boolean f=false;
        try{
            String q="update user set name = ?, email = ?,password = ?, about = ?, gender = ?,profile = ? where id=?";
            
            PreparedStatement pst=con.prepareStatement(q);
            pst.setString(1,user.getName() );
            pst.setString(2, user.getEmail());
            pst.setString(3,user.getPassword() );
            pst.setString(4,user.getAbout() );
            pst.setString(5, user.getGender());
            pst.setString(6, user.getProfile());
            pst.setInt(7, user.getId());
            
            pst.executeUpdate();
            f=true;
        }catch(Exception e){
            e.printStackTrace();
        }
         return f;
    }
    public User getUserByUserId(int userId){
        User user=null;
        try{
            
            String q="select * from user where id=?";
            PreparedStatement pst=this.con.prepareStatement(q);
            pst.setInt(1, userId);
            ResultSet set=pst.executeQuery();
            
            if(set.next()){
                  user = new User();
//               Data db
                String name = set.getString("name");
//               set to user object
                user.setName(name);
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }
            
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return user;
    }
   
}
