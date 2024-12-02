<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="errand.errandDAO" %>
<%@ page import="errand.Errand" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인페이지(홈)</title>
    <style>
       /* category-박스 설정 */
        .category-container {
            display: flex;
            flex-wrap: wrap;
            gap: 20px; /* 버튼 간 간격 조정 */
            justify-content: center;
            margin-top: 20px; /* 상단 여백 조정 */
        }

        /* category-버튼 스타일 */
        .category-button {
            width: 20%; /* 버튼 너비 조정 */
            padding: 5px 0px; /* 버튼 내부 여백 조정 */
            border: 1px solid #ddd;
            border-radius: 15px;
            background-color: #f5f5f5;
            font-size: 12px; /* 글자 크기 조정 */
            color: #333;
            cursor: pointer; /* 마우스 오버 시 포인터 커서 이미지 */
            text-align: center;
            margin-left: 3px;  /* 버튼 왼쪽 간격 조정 */
    		margin-right: 3px; /* 버튼 오른쪽 간격 조정 */
        }
        .first-row {
        display: flex;
        justify-content: center;
        width: 100%;
    }

    		/* 두 번째 행 (문서 작성, 단순 서비스, 기타) */
    		.second-row {
        display: flex;
        justify-content: center;
        width: 100%;
    }
        

        /* 정렬-박스 설정 */
        .sorting-container {
            display: flex;
            gap: 5px;
            justify-content: center;
            margin-top: 15px;
            margin-left: 55%;
        }

        /* 정렬-버튼 스타일 */
        .sorting-button {
            width: 70px;
            padding: 8px 0px;
            border: 1px solid #ddd;
            border-radius: 15px;
            background-color: #f5f5f5;
            font-size: 11px;
            color: #333;
            cursor: pointer;
            text-align: center;
        }

        /* 선택된 버튼 스타일 */
        .selected {
            background-color: #ffae42;
            color: white;
            border-color: #ffae42;
        }

        /* 박스 위에 올렸을 때 */
        .category-button:hover {
            background-color: #ffae42;
            color: #f5f5f5;
        }
        .sorting-button:hover {
            background-color: #ffae42;
            color: #f5f5f5;
        }

        /* 플러스 버튼 */
        .plus {
            position: fixed;
            width: 50px;
            height: 50px;
            bottom: 90px;
            right: 20px;
        }

        /* 줄 바꿈용 */
        .break {
            width: 100%;
            height: 0;
        }
    	.task {
	      background-color: #fff;
	      padding: 15px;
	      margin-bottom: 15px;
	      border-radius: 8px;
	      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    	}

    	.task-title {
	      font-size: 16px;
	      font-weight: bold;
	      margin-bottom: 10px;
   		}

    	.task-details {
      	font-size: 14px;
      	margin-bottom: 5px;
    	}
    	a{
    	color:#000000;
    	text-decoration:none;
    	}
    	.content {
      	padding: 20px;
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

	String category = request.getParameter("category");
	if (category == null || category.isEmpty()) {
	    category = "전체";
	}

	String sort = request.getParameter("sort");
	if (sort == null || sort.isEmpty()) {
	    sort = "최신순";
	}
        // 데이터베이스에서 리스트 조회
        errandDAO errandDAO = new errandDAO();
        ArrayList<Errand> list = errandDAO.getListSorted(category, sort);
    %>

    <!-- 카테고리 버튼 -->
    <div class="category-container">
        <div class="first-row">
        <div class="category-button <%= category.equals("전체") ? "selected" : "" %>" onclick="updatePage('전체', '<%= sort %>')">전체</div>
        <div class="category-button <%= category.equals("물품 대여") ? "selected" : "" %>" onclick="updatePage('물품 대여', '<%= sort %>')">물품 대여</div>
        <div class="category-button <%= category.equals("배달") ? "selected" : "" %>" onclick="updatePage('배달', '<%= sort %>')">배달</div>
        </div>
    <div class="second-row">
        <div class="category-button <%= category.equals("문서 작성") ? "selected" : "" %>" onclick="updatePage('문서 작성', '<%= sort %>')">문서 작성</div>
        <div class="category-button <%= category.equals("단순 서비스") ? "selected" : "" %>" onclick="updatePage('단순 서비스', '<%= sort %>')">단순 서비스</div>
        <div class="category-button <%= category.equals("기타") ? "selected" : "" %>" onclick="updatePage('기타', '<%= sort %>')">기타</div>
        </div>
    </div>

    <!-- 정렬 버튼 -->
    <div class="sorting-container">
        <div class="sorting-button <%= sort.equals("최신순") ? "selected" : "" %>" onclick="updatePage('<%= category %>', '최신순')">최신순</div>
        <div class="sorting-button <%= sort.equals("포인트순") ? "selected" : "" %>" onclick="updatePage('<%= category %>', '포인트순')">포인트순</div>
    </div>

    <!-- 업무 리스트 출력 -->
    <%
        if (list != null && !list.isEmpty()) {
            for (Errand errand : list) {
    %>
    <div class="task">
        <a href="<%= request.getContextPath() %>/errand_enroll/errand_show.jsp?errandID=<%= errand.getErrandID() %>">
            <div class="task-title"><%= errand.getErrandTopic().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></div>
            <div class="task-details">기한: <%= errand.getErrandDeadLine() %></div>
            <div class="task-details">장소: <%= errand.getErrandPlace() %></div>
            <div class="task-details">포인트: <%= errand.getErrandFee() %></div>
            <div class="task-details">등록일: <%= errand.getEnrollDate().substring(0, 16).replace("T", " ") %></div>
        </a>
    </div>
    <%
            }
        } 
    %>
    <br>
  	<br>
  	<br>
    <script>
    function updatePage(category, sort) {
        // JavaScript에서만 encodeURIComponent를 사용하도록 수정
        location.href = "main.jsp?category=" + encodeURIComponent(category) + "&sort=" + encodeURIComponent(sort);
    }
    function gotoPage() {
        const userID = "<%= userID %>";
        if(userID != null)
           {
           location.href='errand_enroll/errand_enroll.jsp';
           }
     }
	</script>
	<img class="plus" src="./image/plus.png" onclick="gotoPage();">
	<jsp:include page="navigation.jsp"/>
</body>
</html>

