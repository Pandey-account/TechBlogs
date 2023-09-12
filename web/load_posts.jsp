
<%@page  import="com.tech.blog.entities.*" %>
<%@page  import="java.util.*" %>
<%@page  import="com.tech.blog.helper.*" %>
<%@page  import="com.tech.blog.dao.*" %>
<%@page errorPage="error_page.jsp" %>

<html>
<body>
<div class="row">
<%
    Thread.sleep(1000);
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    
    int cid=Integer.parseInt(request.getParameter("cid"));
    List<Post> posts =null;
    if(cid == 0){
    posts = d.getAllPosts();
    }else{
    posts=d.getPostByCatId(cid);
    }
    if(posts.size()==0){
    out.println("<h5 class='display-3 text-center'>No posts in this category..</h5>");
    return;
    }
    for(Post p:posts){
    %>
    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="post_pics/<%= p.getPic() %>" alt="Card image cap">
            <div class="card-body">
                <b><%= p.getPtitle() %> </b>
                <p><%= p.getPcontent() %></p>
                
            </div>
                <%
                    LikeDao li=new LikeDao(ConnectionProvider.getConnection());
                    User u= (User)session.getAttribute("currentUser");
                    %>
                <div class="card-footer primary-background text-center">
                    <a href="#!" id="like" onclick="doLike(<%= p.getPid()%>,<%= u.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"><span class="like-counter"><%= li.countLikeOnPost(p.getPid()) %></span></i></a>
                     <a href="show_page.jsp?post_id=<%= p.getPid() %>" class="btn btn-outline-light btn-sm">Read More...</a>
                    <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"><span>20</span></i></a>
                </div>
        </div>
    </div>
    
    <%
    }
%>
</div>
  <!--javascripts-->
        <script

            src="https://code.jquery.com/jquery-3.7.0.min.js"
            integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
<script>
            document.getElementById ("like").addEventListener ("click", doLike, true);
            function doLike(pid, uid)
            {
            console.log(pid + "," + uid);
            const d={
                uid:uid,
                pid:pid,
                operation:'like'
                
            }
            $.ajax({
               url: "LikeServlet",
               data: d,
               success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        if(data.trim=='true'){
                            let c=$(".like-counter").html();
                            c++;
                            $(".like-counter").html(c);
                        }
                    },
               error: function (jqXHR, textStatus, errorThrown) {
                        console.log(data);
                    }
         
            });
        }
        </script>
  </body>
</html>
    
