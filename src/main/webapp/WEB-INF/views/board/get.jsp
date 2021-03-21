<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../includes/header.jsp"></jsp:include>
<script type="text/javascript">

var bnoValue = '<c:out value="${board.bno}"/>';

$(document).ready(function() {
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUl = $(".chat");
	
	showList(1);
	
	function showList(page) {
		
		console.log('show list : ' + page);
		
		replyService.getList({bno:bnoValue, page : page || 1},
				// start function
				function(replyCnt, list){
				console.log('replyCnt : ' , replyCnt);
				console.log('list : ' + list);
				console.log(list);
				
				// -1이면 마지막 페이지를 보여준다. 
				if (page == -1) {
					pageNum = Math.ceil(replyCnt / 10.0);
					showList(pageNum);
					return;
				}
				
				var str = "";
				
				if (list == null || list.length == 0 ) {
					replyUl.html("");
					
					return ;
				}
				console.log('list.length : ', list.length);
				for (var i = 0, len = list.length || 0; i < len; i++) {
					str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
					str += "  <div><div class='header'><strong class='primary-font'>" + list[i].replyer + "<strong>";
					str += "    <small class='pull-right text-muted' style='width:100%'>" +
							replyService.displayTime(list[i].replyDate) + "</small></div>";
					str += "    <p>"+list[i].reply+"</p></div></li>";
				}
				
				replyUl.html(str);
				showReplyPage(replyCnt);
			}); // end function 
	} // end showList
	
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");
	
	$("#addReplyBtn").on("click", function(){
		
		modal.find("input").val("");
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		$(".modal.fade").modal("show");
		
	});
	
	modalRegisterBtn.on("click", function(){
		var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno : bnoValue
		}
		
		console.log('stringify : ', reply);
		
		replyService.add(reply, function(result){
			alert(result);
			
			modal.find("input").val("");
			modal.modal("hide");
			
			showList(-1);
		})
		
	});
	
	$(".chat").on("click", "li", function(e){
		var rno = $(this).data("rno");
		
		console.log(rno);
	});
	
	var pageNum = 1;
	var replyPageFooter = $(".panel-footer");
	
	function showReplyPage(replyCnt){
		
		var endNum = Math.ceil(pageNum/10.0) * 10;
		var startNum = endNum - 9;
		
		var prev = startNum != 1;
		var next = false;
		
		if (endNum * 10 >= replyCnt) {
			endNum = Math.ceil(replyCnt / 10.0);
		}
		
		if (endNum * 10 < replyCnt) {
			next = true;
		}
		
		var str = "<ul calss='pagination pull-right' style='display:flex;'>";
		
		if (prev) {
			str += "<li class='page-item'>";
			str += "  <a class='page-link' href='"+ (startNum - 1) + "'>Previous</a>";
			str += "</li>";
		}
		
		for (var i = startNum; i <= endNum; i++) {
			var active = pageNum == i ? "active" : "";
			
			str += "<li class='page-item " + active + "'>";
			str += "  <a class='page-link' href='" + i + "'>" + i + "</a>";
			str += "</li>";
		}
		
		if (next) {
			str += "<li class='page-item '" + active + " '>";
			str += "  <a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
		}
		
		str += "</ul></div>";
		
		replyPageFooter.html(str);
	}
	
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		console.log('page lick');
		
		var targetPageNum = $(this).attr('href');
		
		pageNum = targetPageNum;
		
		showList(pageNum);
	});
	
	modalModBtn.on("click", function(e){
		
		var reply = {rno : modal.data("rno"), reply: modalInputReply.val()};
		
		repluService.update(reply, function(result){
			
			alert(result);
			modal.modal("hide");
			showList(pageNum);
			
		});
	});
	
	modalRemoveBtn.on("click", function(e){
		var rno = modal.data('rno');
		
		replyService.remove(rno, function(result){
			alert(result);
			modal.modal('hide');
			showList(pageNum);
		});
	});
	
});

// for replyService add test
/* replyService.add(
		{reply:"JS TEST", replyer:"tester", bno:bnoValue},
		function(result) {
			alert("RESULT : " + result);
			}
		); */

// for replyService remove test
/* replyService.remove(
		25,
		function(count) {
			console.log(count);
			
			if (count === "success") {
				alert("REMOVED");
			}
		}, 
		function(err){alert("ERROR....")}); */
		
// for replyService update test
/* replyService.update(
		{rno : 26,
		 bno : bnoValue,
		 reply : "Modified Reply ...."},
		 function(result){
			alert('수정완료');}
); */

/* replyService.get(10, function(data){
	console.log(data);
}); */

</script>

<script type="text/javascript">

$(document).ready(function(){
	var openFrom = $("#openForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		openFrom.attr("action", "/board/modify").submit();
	});
	
	$("button[data-oper='list']").on("click", function(e){
		//list의 경우는 parameter를 받지 않기 때문에 전달인자를 없애주는 것임.
		openFrom.find("#bno").remove();
		openFrom.attr("action", "/board/list");
		openFrom.submit();
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
                            	<div class="form-group">
                            		<label>Bno</label>
                                     <input type="text" class="form-control form-control-user" name="bno" 
                                     value='<c:out value="${board.bno}"></c:out>' readonly="readonly">
                                </div>
                                <div class="form-group">
                                	<label>Title</label>
                                     <input type="text" class="form-control form-control-user" name="title"
                                        value='<c:out value="${board.title}"></c:out>' readonly="readonly">
                                </div>
                                <div class="form-group">
                                	<label>content</label>
                                    <input type="text" class="form-control form-control-user" name="content"
                                        value='<c:out value="${board.content}"></c:out>' readonly="readonly">
                                </div>
                                <div class="form-group">
                                	<label>writer</label>
                                    <input type="text" class="form-control form-control-user" name="writer"
                                        value='<c:out value="${board.writer}"></c:out>' readonly="readonly">
                                </div>
                                <hr>
                                <div class="row">
                                  <div class="col-lg-12">
                                    <!-- start panel heading -->
                                    <div class="panel panel-heading">
                                      <i class="fa fa-comments fa-fw"></i> 
                                      <p style="margin:0 370px 0 0;">Reply</p>
                                      <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">NewReply</button>
                                    </div>
                                    <!-- end panel heading -->
                                    <div class="panel-body">
                                      <ul class="chat">
                                      </ul>
                                    </div>
                                    <div class="panel-footer">
                                    </div>
                                  </div>
                                </div>
                                <hr>
                                <button data-oper="modify" class="btn btn-google btn-user btn-block">modify</button>
                                <button data-oper="list" class="btn btn-facebook btn-user btn-block">List</button>
                                
                                <form id="openForm" action="/board/modify" method="get">
                                  <input type="hidden" id="bno" name="bno" value="<c:out value='${board.bno}'/>">
                                  <input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
                                  <input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
                                  <input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>">
                                  <input type="hidden" name="type" value="<c:out value='${cri.type}'/>">
                                </form>
                            <hr>
                        </div>
                    </div>
                </div>
                
			    <!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				  <div class="modal-dilog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				        <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
				      </div>
				      <div class="modal-body">
				        <div class="form-group">
				          <label>Reply</label>
				          <input class="form-control" name="reply" value="New Reply~!!!"/>
				        </div>
				        <div class="form-group">
				          <label>Replyer</label>
				          <input class="form-control" name="replyer" value="New Reply~!!!"/>
				        </div>
				        <div class="form-group">
				          <label>Reply Date</label>
				          <input class="form-control" name="replyDate" value="New Reply~!!!"/>
				        </div>
				      </div>
				      <div class="modal-footer">
				        <button id="modalRegisterBtn" type="button" class="btn btn-warning">Register</button>
				        <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
				        <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
				        <button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">close</button>
				        <button id="modalRemoveBtn" type="button" class="btn btn-default" data-dismiss="modal">close</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- End Modal -->
            </div>
        </div>
    </div>
    
    
<jsp:include page="../includes/footer.jsp"></jsp:include>