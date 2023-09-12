

package com.tech.blog.helper;

import java.sql.Connection;
import java.sql.DriverManager;


public class ConnectionProvider {
    
     public static Connection con;
    public static Connection getConnection(){
    try{
            
          if(con==null){
              
                //Driver class load
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            //Create a connection
            
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog","root","Pandey7759@");
            
          }
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return con;
}
}
