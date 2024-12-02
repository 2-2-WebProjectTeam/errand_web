<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="errand.Errand" %>
<%@ page import="errand.errandDAO" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>erand_show</title>
    <style>
        .title-container {
            width: 100%;
            position: relative;
            margin: 0 auto;
            padding-top: 20px; /* 상단 여백 */
        }
        .title-container img {
            position: absolute;
            top: 20px; /* 이미지의 상단 여백 */
            left: 20px; /* 이미지의 왼쪽 여백 */
            cursor: pointer; /* 클릭 가능하도록 커서 변경 */
        }
        h4 {
            padding: 40px 40px 0px;
            font-size: 25px;
        }
        .type {
            padding: 0px 40px;
            font-size: 15px;
            color : #ff9800;
            font-weight : bold;
            margin-top: -25px; /* 조금 더 위로 올리기 */
        }
        .explanation {
            padding: 50px 40px;
        }
        .explanation-item {
            margin-bottom: 20px; /* 각 항목 간의 간격 조정 */
            font-size: 17px;
        }
        .icon {
            margin-right: 20px; /* 아이콘과 텍스트 간의 간격 */
            vertical-align: middle; /* 아이콘 정렬 */
            height : 20px;
        }
        .map{
        	margin-top : 120px;
            width : 95%;
        }
        .place{
            margin-top : -220px;
        }
        h6{
            padding: 0px 40px;
            font-size: 17px; 
            color : #F7A239;

        }
        .content {
            padding: 0px 40px;
            margin-top : -50px;
            font-size: 15px;
            line-height: 1.6; /* 줄 간격 설정 */
            color: #333;
            word-wrap: break-word; /* 긴 단어 줄바꿈 */
            word-break: break-word; /* 단어가 영역을 벗어나지 않게 */
        }
        .submit-button {
            width: 250px;
            padding: 10px;
            border: none;
            border-radius: 15px;
            background-color: #fde7cd;
            font-size: 20px;
            cursor: pointer;
            color : #F7A239;
            display : block;
			margin-top : 150px;    
            margin-left: auto; 
            margin-right: auto; 
            text-align:center;
            margin-bottom : 100px;
        }
        .sub-button {
            width: 130px;
            padding: 10px;
            border: none;
            border-radius: 15px;
            background-color: #fde7cd;
            font-size: 20px;
            cursor: pointer;
            color : #F7A239;
            margin-top : 150px;
            display : block;
            margin-left: auto; 
            margin-right: auto; 
            text-align:center;
            margin-bottom: 100px;
        }
        .container{
        text-align : center;}
        .submit-button:hover {
            background-color: #ff9800;
        }
		a{
		text-decoration:none;
		}

    </style>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String) session.getAttribute("userID");
	}
	int errandID=0;
	if(request.getParameter("errandID")!=null){
		errandID=Integer.parseInt(request.getParameter("errandID"));
	}
	if(errandID==0){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");	
	}
	Errand errand=new errandDAO().getErrand(errandID);
%>
    <jsp:include page="../navigation.jsp"/>
	
    <div class="title-container">
        <img style="width:45px; height:45px;" src="../image/arrow.back.png" onclick="history.back()">
    </div>

    <h4><%=errand.getErrandTopic().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></h4>
    <div class="type"><%=errand.getErrandType() %></div>
    <div class="explanation">
        <div class="explanation-item">
            <img class="icon" src="../image/time.png">기한 : <%=errand.getErrandDeadLine() %>
        </div>
        <div class="explanation-item">
            <img class="icon" src="../image/place.png">장소 : <%=errand.getErrandPlace() %>
        </div>
        <div class="explanation-item">
            <img class="icon" src="../image/point.png">활동비 : <%=errand.getErrandFee() %>
        </div>
    </div>
    <div class="place">

        <img class="map" src="../image/dongguk.map.png"></div><br>
    <hr style=width:360px;><br><br>
    <div class="detail">
        <div class="type">요청 내용</div><br><br><br>
        <div class="content"><%=errand.getErrandContent().replaceAll(" ", "&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></div>
    </div>
    <%
    	if(userID!=null&&userID.equals(errand.getEnrollID())){
    %>
    	<div class="container">
	    	<a href="update.jsp?errandID=<%=errandID%>" class = "sub-button" style="display: inline-block; margin-right: 20px;">수정</a>
	    	<a href="deleteAction.jsp?errandID=<%=errandID%>" class = "sub-button" style="display: inline-block;">삭제</a>
	    </div>
   	<%
   		}else if(userID != null){
   	%>
   		<form method="post" action="errand_apply.jsp">
   			<input type="hidden" name="userID" value="<%= userID %>">
    		<input type="hidden" name="errandID" value="<%= errandID %>">
   			<input type="submit" value="신청하기" class="submit-button" >
   		</form>
    	
   	<%
   		}
   	%>
</body>
</html>
