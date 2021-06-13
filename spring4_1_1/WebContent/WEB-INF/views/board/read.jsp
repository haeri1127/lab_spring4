<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	StringBuilder path = new StringBuilder(request.getContextPath());
	path.append("/");
	List<Map<String,Object>> boardDetail = null;
	boardDetail = (List<Map<String,Object>>)request.getAttribute("boardDetail");
	//bm_no, bm_title, bm_date, bs_file, bm_hit, bm_group, bm_pos, bm_step, bm_email, bm_pw ,bm_writer, bm_content
	int size = 0;
	String bm_no		= null;
	String bm_title 	= null;
	String bm_writer 	= null;
	String bm_email 	= null;
	String bm_content 	= null;
	String bm_group 	= null;
	String bm_pos 		= null;
	String bm_step 		= null;
	String bm_pw 		= null;
	String bs_file 		= null;
	if(boardDetail!=null){
		size 		= boardDetail.size();		
		bm_no 		= boardDetail.get(0).get("BM_NO").toString();
		bm_title 	= boardDetail.get(0).get("BM_TITLE").toString();
		bm_writer 	= boardDetail.get(0).get("BM_WRITER").toString();
		bm_email 	= boardDetail.get(0).get("BM_EMAIL").toString();
		bm_content 	= boardDetail.get(0).get("BM_CONTENT").toString();
		bm_group 	= boardDetail.get(0).get("BM_GROUP").toString();
		bm_pos 		= boardDetail.get(0).get("BM_POS").toString();
		bm_step 	= boardDetail.get(0).get("BM_STEP").toString();
		bm_pw 		= boardDetail.get(0).get("BM_PW").toString();
		bs_file 	= boardDetail.get(0).get("BS_FILE").toString();
	}
	out.print("size : "+size);
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 조회 페이지</title>
<!-- jEasyUI 시작 -->
<link rel="stylesheet" type="text/css" href="<%=path.toString() %>themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path.toString() %>themes/icon.css"> 
<!-- jEasyUI JS 시작 -->
<script type="text/javascript" src="<%=path.toString() %>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path.toString() %>js/jquery.easyui.min.js"></script>
<script type="text/javascript">
	//댓글쓰기
	function repleForm(){
		$("#dlg_boardAdd").dialog('open');
	}
	
	//수정창
	function updateForm(){
		$('#d_boardUpd').dialog({
			title:'글수정'
		  ,width:720
		  ,height:450
		  ,closed:false
		  ,cache:false
		 ,modal:true	  
		});
	}
	
	//수정완료버튼
	function upd_check(){
		let upd_title = document.getElementById('upd_title').value;
		let upd_content = document.getElementById('upd_content').value;
		let upd_pw = document.getElementById('upd_pw').value;
		
		if(upd_title == "") {
		    alert("제목을 입력해 주세요.");
		    return false;
		    }
		else if(upd_content == "") {
		    alert("내용을 입력해 주세요.");
		    return false;
		}
		else if(upd_pw==""){ //비밀번호가 null일때
				alert("비밀번호를 입력해주세요.");
			    return false;
		}
		else {
			if(upd_pw!=""){
				if(<%=bm_pw%>==upd_pw){
					alert("수정되었습니다.");
					return true;
				}else{
					alert("비밀번호 틀림 ㅅㄱ");
					return false;
				}
			}
		}
	}
	
	//수정취소버튼
	function boardUpdClose(){
		$("#d_boardUpd").dialog({closed:true});
	}
	
	//삭제
	function boardDelView(){
		alert("삭제되었습니다.");
		<%-- console.log("bm_no : "+<%= bm_no%>); --%>
		location.href="./boardDelete.sp4?bm_no="+<%=bm_no%>;
	}
	
	//목록 돌아가기
	function boardList(){
		location.href="./getBoardList.sp4";
	}
	
</script>
</head>
<body>
	<table align="center" id="p" class="easyui-panel" title="글상세보기" data-options="footer:'#tb_read'"
        style="width:670px;height:380px;padding:10px;background:#fafafa;">
	    	<tr>
	    		<td>제목</td>
	    		<td><input id="bm_title" value="<%=bm_title%>" name="bm_title" data-options="width:'450px'" class="easyui-textbox" readonly></td>
	    	</tr>
	    	<tr>
	    		<td>작성자</td>
	    		<td><input id="bm_writer" value="<%=bm_writer%>" name="bm_writer" class="easyui-textbox" readonly></td>
	    	</tr>
	    	<tr>
	    		<td>이메일</td>
	    		<td><input id="bm_email" value="<%=bm_email%>" name="bm_email" class="easyui-textbox" readonly></td>
	    	</tr>
	    	<tr>
	    		<td>내용</td>
	    		<td><input id="bm_content" value="<%=bm_content%>" name="bm_content" data-options="multiline:'true', width:'570px', height:'90px'" class="easyui-textbox" readonly></td>
	    	</tr>
	    	<tr>
	    		<td>비밀번호</td>
	    		<td><input id="bm_pw" value="<%=bm_pw%>" name="bm_pw" class="easyui-passwordbox" readonly></td>
	    	</tr>	    	
	   </table>
	 <div id="tb_read" style="padding:2px 5px;" align="center">
	    <a href="javascript:repleForm()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">댓글쓰기</a>
	    <a href="javascript:updateForm()" class="easyui-linkbutton" iconCls="icon-add" plain="true">수정</a>
	    <a href="javascript:boardDelView()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">삭제</a>
	    <a href="javascript:boardList()" class="easyui-linkbutton" iconCls="icon-search" plain="true">목록</a>
	</div>
	<!--================== [[댓글쓰기 화면]] ==================-->
	<div id="dlg_boardAdd" title="댓글쓰기" class="easyui-dialog" style="width:600px;height:400px;padding:10px" data-options="closed:'true',modal:'true',footer:'#tbar_boardAdd'">	
	<!-- 
	form전송시 encType옵션이 추가되면 request객체로 사용자가 입력한 값을 꺼낼 수 없다.
	MultipartRequest  => cos.jar
	 -->	
		<form id="f_boardAdd" method="get">
		<input type="hidden" name="bm_no" value="<%=bm_no%>">
		<input type="hidden" name="bm_group" value="<%=bm_group%>">
		<input type="hidden" name="bm_pos" value="<%=bm_pos%>">
		<input type="hidden" name="bm_step" value="<%=bm_step%>">
		<!-- <form id="f_boardAdd"> -->
		<table>
			<tr>
				<td width="100px">제목</td>
				<td width="500px">
					<input class="easyui-textbox" data-options="width:'350px'" id="bm_title" name="bm_title" required>
				</td>
			</tr>
			<tr>	
				<td width="100px">작성자</td>
				<td width="500px">
					<input class="easyui-textbox" data-options="width:'150px'" id="bm_writer" name="bm_writer" required>
				</td>
			</tr>
			<tr>
				<td width="100px">이메일</td>
				<td width="500px">
					<input class="easyui-textbox" data-options="width:'250px'" id="bm_email" name="bm_email">
				</td>
			</tr>
			<tr>			
				<td width="100px">내용</td>
				<td width="500px">
					<input class="easyui-textbox" id="bm_content" name="bm_content" data-options="multiline:'true',width:'400px',height:'90px'" required>
				</td>
			</tr>
			<tr>			
				<td width="100px">비번</td>
				<td width="500px">
					<input class="easyui-textbox" data-options="width:'100px'" id="bm_pw" name="bm_pw" required>
				</td>
			</tr>
		</table>
		</form>
	</div>
	<!-- 입력 화면 버튼 추가 -->
	<div id="tbar_boardAdd" align="right">
		<a href="javascript:addAction()" class="easyui-linkbutton" iconCls="icon-save">저장</a>
		<a href="javascript:$('#dlg_boardAdd').dialog('close')" 
		   class="easyui-linkbutton" iconCls="icon-cancel">닫기</a>
	</div>
	
	<!--=========================== 글수정 폼  =======================================-->
	<div id="d_boardUpd" closed="true" class="easyui-dialog" style="padding:20px 50px">
		<form id="uf_board" method="get" enctype="multipart/form-data" action="./boardUpdate.sp4" onsubmit="return upd_check()">
			<%-- <input type="hidden" id="b_no" name="b_no" value="<%=bm_no %>">
			<input type="hidden" id="b_seq" name="b_seq" value="<%=1 %>">
			<input type="hidden" id="old_file" name="old_file" value="<%=bs_file %>"> --%>
			<table align="center" width="650px" height="280px">
				<tr>
					<td width="120px">글번호</td>
					<td width="580px">
						<input id="upd_no" value="<%=bm_no %>" name="bm_no" class="easyui-textbox" readonly style="width:80px">
					</td>
				</tr>
				<tr>
					<td width="120px">글제목</td>
					<td width="580px">
						<input id="upd_title" value="<%=bm_title %>" name="bm_title" class="easyui-textbox">
					</td>
				</tr>
				<tr>
					<td width="120px">작성자</td>
					<td width="580px">
						<input id="upd_writer" value="<%=bm_writer %>" name="bm_writer" class="easyui-textbox" readonly>
					</td>
				</tr>	
				<tr>
					<td width="120px">내용</td>
					<td width="580px">
						<input id="upd_content" multiline="true" value="<%=bm_content %>" name="bm_content" class="easyui-textbox" style="width:100%;height:100px">
					</td>
				</tr>	
				<tr>
					<td width="120px">비번</td>
					<td width="580px">
						<input type="password" id="upd_pw" name="bm_pw" class="easyui-textbox" style="width:100px">
					</td>
				</tr>	
			</table>
		</form>
		<div id="btn_boardUpd" align="right" >
			<button type="submit" form="uf_board" class="easyui-linkbutton" iconCls="icon-ok" style="width:90px">등록</button>
			<button onClick="javascript:boardUpdClose()" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">닫기</button>
		</div>		
		<!-- <div id="btn_boardUpd" align="right" type="submit">
			<a class="easyui-linkbutton" iconCls="icon-ok" style="width:90px">등록</a>
			<a href="javascript:boardUpdClose()" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">닫기</a>
		</div> -->
	</div>
	<!-- 글수정끝 -->
	
	
	
</body>
</html>