<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp"></jsp:include>

<script type="text/javascript">
  $(document).ready(function(){
	  // 내가 궁금한 점 중 하나가 왜 아래 있는 필드를 전역으로 빼면 코드가 진행이 안되는 것일까 ?! 궁금하다
	  
	  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	  var maxSize = 5242880; // 5MB
	  var uploadResult = $(".uploadResult ul");
	  
	  $("input[type='file']").change(function(e){
		  var formData = new FormData();
		  var inputFile = $("input[name='uploadFile']");
		  var files = inputFile[0].files;
		  
		  /* for (var idx in files) {
			  
			  if (!checkExtension(files[idx].name, files[idx].size)) {
				  return false;
			  }
			  formData.append("uploadFile", files[idx]);
		  } */
		  
		  for (var i = 0; i < files.length; i++) {
				
				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
		  
		  $.ajax({
			  url: "/uploadAjaxAction",
			  // 원래 ajax로 파라미터를 전달할 때 쿼리스트링으로 전달을 하는데 지금 여기서는 file을 전달하기 위해서 사용하는 것이다. 때문에 
			  // processData의 기본값인 true를 false로 설정을 해줘서 파일을 넘겨준다는 것을 알려주는 것이기도 하다. 
			  processData : false,
			  contentType : false,
			  data		: formData,
			  type		: 'POST',
			  dataType	: "json",
			  success		 : function(result) {
				  
				  console.log(result);
				  showUploadedFile(result);
				  
			  }
		  });
	  }); // End Change
	  
	  function checkExtension(fileName, fileSize) {
		    
		    if (fileSize > maxSize) {
		    	alert("파일 사이즈 초과");
		    	return false;
		    }
		    
		    if (regex.test(fileName)) {
		    	alert("해당 종류의 파일은 업로드할 수 없습니다");
		    	return false;
		    }
		    
		    return true;
		  }
		  
		  function showUploadedFile(uplaodResultArr) {
				console.log(uploadResult);
				var str = "";
				var uploadPath = "";
				
				console.log('uplaodResultArr : ', uplaodResultArr);
				$(uplaodResultArr).each(function(i, obj){
					
					uploadPath = obj.imageUri.replace("s_", "");
					
					if (!obj.image) {
						var fileCallPath = encodeURIComponent(obj.uploadPath + '/' + obj.fileName + obj.uuid + obj.fileExtends);
						str += "<li><div><a href='/download?fileName=" + uploadPath + "'><img src='/resources/img/chumbu.png'>" +
								obj.fileName + "</img></a>";
						str += "<span data-file='\'" + fileCallPath + "\' data-type='file'> x </span>" 
						str += "</div></li>";
						
					} else {
						// absolute path
						var fileCallPath = encodeURIComponent(obj.uploadPath + '/s_' + obj.fileName + "_" + obj.uuid + obj.fileExtends);
						
						// exclude root path (c:\upload)
						var originPath = obj.uploadPath.substr('c:\\upload'.length) + "\\" + obj.fileName + "_" + obj.uuid + obj.fileExtends;
						originPath = originPath.replaceAll("\\", "/");
						
						console.log("originPath : ", originPath);
						str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\"><img src='/display?fileName=" + obj.imageUri +"'></a>";
						str += "<span style='cursor:pointer;' data-file=\'" + fileCallPath + "\' data-type='image'> x </span></li>";
					}
				});
				
				uploadResult.append(str);
				
			}// end showUploadFile
  });// end ready
  
  
</script>
    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                            </div>
                            <form role="form" class="user" action="/board/register" method="post">
                                <div class="form-group">
                                     <input type="text" class="form-control form-control-user" name="title"
                                        placeholder="Title">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" name="content"
                                        placeholder="Text">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" name="writer"
                                        placeholder="Writer">
                                </div>
                                <hr>
                                <button type="submit" class="btn btn-google btn-user btn-block">Submit Button</button>
                                <button type="submit" class="btn btn-facebook btn-user btn-block">Reset Button</button>
                            </form>
                            <hr>
                        </div>
                    </div>
                </div>
                
                <!-- 첨부파일 관련 -->
                <div class="row">
                  <div class="col-lg-12">
                    <div class="panel panel-default">
                      <div class="panel-heading">File Attach</div>
                      <!-- /panel heading -->
                      <div class="panel-body">
                        <div class="form-group uploadDiv">
                          <input type="file" name="uploadFile" multiple />
                        </div>
                        
                        <div class="uploadResult">
                          <ul>
                          </ul>
                        </div>
                      </div>
                      <!-- end panel body -->
                    </div>
                  </div>
                  <!-- end panel -->
                </div>
                <!-- end row -->
            </div>
        </div>

    </div>
<jsp:include page="../includes/footer.jsp"></jsp:include>