
<%@page import="com.tech.blog.entities.*" %>
<%@page errorPage="error_page.jsp" %>
<%@page import="com.tech.blog.dao.*" %>
<%@page import="com.tech.blog.helper.*" %>
<%@page import="java.util.*" %>

<%@page import="java.text.DateFormat" %>


<%
    User user=(User)session.getAttribute("currentUser");
    if(user==null){
    response.sendRedirect("login_page.jsp");
    
    }
%>

<%
    int postId=Integer.parseInt(request.getParameter("post_id"));
    
    PostDao d=new PostDao(ConnectionProvider.getConnection());
    Post p = d.getPostByPostId(postId);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
      
        <div id="fb-root"></div>
<script async defer crossorigin="anonymous"
src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v17.0" nonce="d1nTKqDR"></script>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getPtitle() %> || TechBlog by learncode with Online</title>

        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="CSS/Mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 99% 0, 100% 100%, 69% 97%, 30% 97%, 0 100%, 0 0);
            }
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 25px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user-info{
                font-size: 20px;
                font-weight: 120;
            }
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }
            body{
                background:url(img/images.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
</head>
<body>

    <!--navbar start-->

    <nav class="navbar navbar-expand-lg navbar-dark primary-background">
        <a class="navbar-brand" href="index.jsp"><span class ="fa fa-asterisk"></span>Tech Blog</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="profile.jsp"><span class="fa fa-bell-o"></span>Lern Code with Online <span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="fa fa-check-square-o"></span> Categories
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="#">Programming Language</a>
                        <a class="dropdown-item" href="#">Project Implementation</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Data Structure and Algorithm</a>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><span class="fa fa-address-card-o"></span>Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-asterisk"></span>Do Post</a>
                </li>


            </ul>
            <ul class="navbar-nav mr-right">

                <li class="nav-item">
                    <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle "></span><%= user.getName()%></a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="logoutServlet"><span class="fa fa-user-plus "></span>Logout</a>
                </li>
            </ul>
        </div>
    </nav>


    <!--navbar End-->

    <!--main content of body-->

    <div class="container">
        <div class="row my-4">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header primary-background text-white">
                        <h4 class="post-title"><%= p.getPtitle() %></h4>
                    </div>
                    <div class="card-body">
                        <img class="card-img-top my-2" src="post_pics/<%= p.getPic() %>" alt="Card image cap">

                        <div class="row my-3 row-user">
                            <div class="col-md-8">
                                <%
                                    UserDao ud=new UserDao(ConnectionProvider.getConnection());
                                    User u=ud.getUserByUserId(p.getUserId());
                                %>
                                <p class="post-user-info"><a href="#!"><%= u.getName() %></a> has posted:</p>
                            </div>
                            <div class="col-md-4">
                                <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getPdate()) %></p> 
                            </div>
                        </div>

                        <p class="post-content"><%= p.getPcontent() %></p>
                        <br>
                        <br>
                        <div class="post-code">
                            <pre><%= p.getPcode() %></pre>
                        </div>
                    </div>
                    <%
                        LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                    %>
                    <div class="card-footer primary-background text-center">
                        <a href="#!" id="like" onclick="doLike(<%= p.getPid() %>,<%= u.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"><span class="like-counter"><%= ld.countLikeOnPost(p.getPid()) %></span></i></a>

                        <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"><span>20</span></i></a>
                    </div>
                        <div class="card-footer">
                            <div class="fb-comments" data-href="http://localhost:9595/TechBloges/show_page.jsp?post_id=<%= u.getId() %>" data-width="400" data-numposts="10"></div>
                        </div>
                </div>
            </div>
        </div>
    </div>

    <!--end of main content-->

    <!-- Modal -->
    <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header primary-background text-white text-center">
                    <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container text-center ">
                        <img src="Pic/<%= user.getProfile() %>" class="img-fluid" style="border-radius: 50%; max-width: 100px;">
                        <br>
                        <%= user.getName()%>

                        <!--details-->
                        <div id="profile-details">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <th scope="row">ID :</th>
                                        <td><%=user.getId() %></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Email : </th>
                                        <td><%= user.getEmail() %></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Gender : </th>
                                        <td><%= user.getGender() %></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Status : </th>
                                        <td><%= user.getAbout() %></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Registered on :</th>
                                        <td><%= user.getDateTime().toString() %></td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!--profile edit-->

                        <div id="profile-edit" style="display: none;">
                            <h3 class="mt-3">Please Edit Carefully</h3>
                            <form action="EditServlet" method="post" enctype="multipart/form-data">
                                <table class="table">
                                    <tr>
                                        <td>ID :</td>
                                        <td><%=user.getId() %></td>
                                    </tr>
                                    <tr>
                                        <td>Email :</td>
                                        <td><input type="email"  class="form-control" name="user_email" value="<%= user.getEmail() %>"></td>
                                    </tr>
                                    <tr>
                                        <td>Name :</td>
                                        <td><input type="text"  class="form-control" name="user_name" value="<%= user.getName() %>"></td>
                                    </tr>
                                    <tr>
                                        <td>Password :</td>
                                        <td><input type="password"  class="form-control" name="user_password" value="<%= user.getPassword() %>"></td>
                                    </tr>

                                    <tr>
                                        <td>Gender :</td>
                                        <td><%= user.getGender().toUpperCase() %></td>
                                    </tr>
                                    <tr>
                                        <td>About :</td>
                                        <td><textarea  rows="3" class="form-control" name="user_about"><%= user.getAbout() %></textarea></td>
                                    </tr>
                                    <tr>
                                        <td>New Profile Pic :</td>
                                        <td><input type="file" name="image" class="form-control"></td>
                                    </tr>

                                </table>
                                <div class="container">
                                    <button type="submit" class="btn btn-outline-primary">Save</button>
                                </div>

                            </form>

                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                </div>
            </div>
        </div>
    </div>

    <!--end of profile modal-->

    <!--add post modal-->




    <!-- Modal -->
    <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Provide the post details...</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form  id="add-post-form" action="AddPostServlet" method="post">
                        <div class="form-group">
                            <select class="form-control" name="cid">
                                <option selected disabled>---Select Category---</option>
                                <%
                                    PostDao postd=new PostDao(ConnectionProvider.getConnection());
                                    ArrayList<Category> list = postd.getAllCategories();
                                    for(Category c:list){
                                        
                                %>
                                <option value="<%= c.getCid()%>"><%= c.getName() %></option>
                                <% 
                                    } 
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <input name="ptitle" type="text" placeholder="Enter post Title" class="form-control">  
                        </div>
                        <div class="form-group">
                            <textarea name="pcontent" class="form-control" style="height: 200px;" placeholder="Enter your content"></textarea>
                        </div>
                        <div class="form-group">
                            <textarea name="pcode" class="form-control" style="height: 200px;" placeholder="Enter your program(if any)"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Select your Pic...</label>
                            <br>
                            <input type="file" name="pic">
                        </div>
                        <div class="container text-center">
                            <button type="submit" class="btn-outline-primary">post</button>
                        </div>
                    </form>   
                </div>

            </div>
        </div>
    </div>

    <!--end post modal-->
    <!--javascripts-->
    <script

        src="https://code.jquery.com/jquery-3.7.0.min.js"
        integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
    crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script src="JavaScript/Myjs.js" type="text/javascript"></script>

    <script>
                            $(document).ready(function () {
                                let edit = false;
                                $("#edit-profile-button").click(function () {
                                    if (edit == false) {
                                        $("#profile-details").hide();
                                        $("#profile-edit").show();
                                        edit = true;
                                        $(this).text("back");
                                    } else {
                                        $("#profile-details").show();
                                        $("#profile-edit").hide();
                                        edit = false;
                                        $(this).text("Edit");
                                    }
                                });
                            });
    </script>
    <!--now add post js-->
    <script>
        $(document).ready(function (e) {
            $("#add-post-form").on("submit", function (event) {
//this code gets called when form is submitted...
                event.preventDefault();
                let form = new FormData(this);
//                    now requesting to server
                console.log("your data submited");
                $.ajax({
                    url: "AddPostServlet",
                    data: form,
                    type: "post",
                    success: function (data, textStatus, jqXHR) {
//                          success
                        console.log(data);
                        if (data.trim() === "done") {
                            swal("Good job!", "saved successfully", "success");
                        } else {
                            swal("Error !", "Something went wrong try again...", "error");
                        }


                    },
                    error: function (jqXHR, textStatus, errorThrown) {
//                      error     
                        swal("Error !", "Something went wrong try again...", "error");
                    },
                    processData: false,
                    contentType: false,
                    cache: false
                });
            });
        });
    </script>
    <script>
        document.getElementById("like").addEventListener("click", doLike, true);
        function doLike(pid, uid)
        {
            console.log(pid + "," + uid);
            const d = {
                uid: uid,
                pid: pid,
                operation: 'like'

            }
            $.ajax({
                url: "LikeServlet",
                data: d,
                success: function (data, textStatus, jqXHR) {
                    console.log(data);
                    if (data.trim() == 'true') {
                        let c = $(".like-counter").html();
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
