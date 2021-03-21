<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../includes/header.jsp"></jsp:include>\

<script type="text/javascript">

$(document).ready(function(){
	var formObj = $("form");
	
	$("button").on("click", function(e){debugger;
		// 여기서 on메서드에서 , 혹은 저 default function에서 매개변수로 전달되는 애가 뭔지 알아보자. 
		// preventDefault는 버블링의 이벤트 효과를 무시하는 것이다.
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		if (operation === 'remove') {
			formObj.attr("action", "/board/remove");
			console.log(formObj.attr("action"));
		} else if (operation === 'list') {
			formObj.attr("action", "/board/list").attr("method", "get");
			//jquery empty의 경우는 내용만 지우는 메서드이다. 내용은 지우고 태그는 남아있음을 주의해야한다. 
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var typeTag = $("input[name='type']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(typeTag);
			formObj.append(keywordTag);
		}
		formObj.submit();
		
	});
});

</script>

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                	<div class="col-lg-12">
                		<h1 class="page-header">Board Read</h1>
                	</div>
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">get Account</h1>
                            </div>
                            	<form action="/board/modify" method="post">
                            		<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
                                    <input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
                                     <input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
                                  <input type="hidden" name="type" value="<c:out value='${cri.type}'/>">
	                            	<div class="form-group">
	                            		<label>Bno</label>
	                                     <input type="text" class="form-control form-control-user" name="bno" 
	                                     value='<c:out value="${board.bno}"></c:out>' readonly="readonly">
	                                </div>
	                                <div class="form-group">
	                                	<label>Title</label>
	                                     <input type="text" class="form-control form-control-user" name="title"
	                                        value='<c:out value="${board.title}"></c:out>' >
	                                </div>
	                                <div class="form-group">
	                                	<label>content</label>
	                                    <input type="text" class="form-control form-control-user" name="content"
	                                        value='<c:out value="${board.content}"></c:out>' >
	                                </div>
	                                <div class="form-group">
	                                	<label>writer</label>
	                                    <input type="text" class="form-control form-control-user" name="writer"
	                                        value='<c:out value="${board.writer}"></c:out>' readonly="readonly">
	                                </div>
	                                <hr>
	                                <button type="submit" data-oper="modify" class="btn btn-google btn-user btn-block">
	                                  modify
	                                </button>
	                                <button type="submit" data-oper="list" class="btn btn-facebook btn-user btn-block">
	                                  List
	                                </button>
	                                <button type="submit" data-oper="remove" class="btn btn-facebook btn-user btn-block">
	                                  remove
	                                </button>
                                </form>
                                
                            <hr>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
<jsp:include page="../includes/footer.jsp"></jsp:include>