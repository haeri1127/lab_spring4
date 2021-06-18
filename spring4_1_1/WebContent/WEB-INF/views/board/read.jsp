<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	StringBuilder path = new StringBuilder(request.getContextPath());
	path.append("/");
	List<Map<String,Object>> boardDetail = null;
	boardDetail = (List<Map<String,Object>>)request.getAttribute("boardDetail");
	int size = 0;
	String bm_email 	= null;
	String bs_file 		= null;
	String bm_title 	= null;
	String bm_writer 	= null;
	String bm_content 	= null;
	String bm_pw 		= null;
	String bm_no		= null;
	String bm_group 	= null;
	String bm_pos 		= null;
	String bm_step 		= null;
	if(boardDetail!=null){
		size = boardDetail.size();
		Map<String,Object> rmap = boardDetail.get(0);
		bm_title = boardDetail.get(0).get("BM_TITLE").toString();
		bm_writer = boardDetail.get(0).get("BM_WRITER").toString();
		if(rmap.get("BM_EMAIL")!=null){
			bm_email = rmap.get("BM_EMAIL").toString();
		}else{
			bm_email="";
		}
		bm_content = boardDetail.get(0).get("BM_CONTENT").toString();
		bm_no = boardDetail.get(0).get("BM_NO").toString();
		bm_group = boardDetail.get(0).get("BM_GROUP").toString();
		bm_pos = boardDetail.get(0).get("BM_POS").toString();
		bm_step = boardDetail.get(0).get("BM_STEP").toString();
		if(rmap.get("BM_PW")!=null){
			bm_pw = rmap.get("BM_PW").toString();		
		}else{
			bm_pw = "";
		}
	}
	out.print("boardDetail:"+boardDetail);
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=path.toString() %>themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path.toString() %>themes/icon.css"> 
<!-- jEasyUI JS 시작 -->
<script type="text/javascript" src="<%=path.toString() %>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path.toString() %>js/jquery.easyui.min.js"></script>
<script type="text/javascript">
//댓글쓰기
	function repleForm(){
		$("#dlg_ins").dialog('open');
	}
	function boardDelClose(){
		$("#dlg_del").dialog('close');
	}
	function insAction(){
		console.log("입력액션 호출");
		$('#board_ins').submit();
    }
	function updAction(){
		console.log("수정액션 호출");
		$('#board_upd').submit();
    }
	function boardDelAction(){
		console.log("삭제확인 호출");
		let db_pw = <%=bm_pw%>;
		let u_pw = $("#user_pw").textbox('getValue');
		if(db_pw == u_pw){
			$.messager.confirm('Comfirm', '정말 삭제할거야?', function(r){
				if (r){
					location.href="boardDelete.sp4?bm_no=<%=bm_no%>&bs_file=<%=bs_file%>";
				}
			});			
		}else{
			alert("비번이 틀립니다.");
			return;//함수 탈출
		}
	}
	function boardDelView(){
		$('#dlg_del').dialog({
		    title: '글삭제',
		    width: 400,
		    height: 200,
		    closed: false,
		    cache: false,
		    modal: true
		});
	}
	function updateForm(){
		/* $("#dlg_upd").dialog('open'); */
		$('#dlg_upd').dialog({
		    title: '글수정',
		    width: 700,
		    height: 650,
		    closed: false,
		    cache: false,
		    href: 'updateForm.jsp?bm_no=<%=bm_no%>&bm_title=<%=bm_title%>&bm_writer=<%=bm_writer%>&bm_content=<%=bm_content%>&bs_file=<%=bs_file%>',
		    modal: true
		});
	}
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
	    		<td><input id="bm_title" value="<%=bm_title%>" name="bm_title" data-options="width:'450px'" class="easyui-textbox"></td>
	    	</tr>
	    	<tr>
	    		<td>작성자</td>
	    		<td><input id="bm_writer" value="<%=bm_writer%>" name="bm_writer" class="easyui-textbox"></td>
	    	</tr>
	    	<tr>
	    		<td>이메일</td>
	    		<td><input id="bm_email" value="<%=bm_email%>" name="bm_email" class="easyui-textbox"></td>
	    	</tr>
	    	<tr>
	    		<td>내용</td>
	    		<td><input id="bm_content" value="<%=bm_content%>" name="bm_content" data-options="multiline:'true', width:'570px', height:'90px'" class="easyui-textbox"></td>
	    	</tr>
	    	<tr>
	    		<td>비밀번호</td>
	    		<td><input id="bm_pw" value="<%=bm_pw%>" name="bm_pw" class="easyui-passwordbox"></td>
	    	</tr>	    	
	   </table>
	 <div id="tb_read" style="padding:2px 5px;" align="center">
	    <a href="javascript:repleForm()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">댓글쓰기</a>
	    <a href="javascript:updateForm()" class="easyui-linkbutton" iconCls="icon-add" plain="true">수정</a>
	    <a href="javascript:boardDelView()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">삭제</a>
	    <a href="javascript:boardList()" class="easyui-linkbutton" iconCls="icon-search" plain="true">목록</a>
	</div>
	
	<!--=========================== [[글삭제 화면 시작]] =============================-->
	<div id="dlg_del" class="easyui-dialog" title="비번확인" data-options="closed:true" style="width:600px;height:650px;padding:10px">
 		<div style="margin-bottom:20px">
            <input class="easyui-textbox" id="user_pw" name="user_pw" label="비번:" labelPosition="top" data-options="prompt:'비번입력하세요'" style="width:200;">
 		</div>
 		<a href="javascript:boardDelAction()" class="easyui-linkbutton" iconCls="icon-ok" style="width:90px">저장</a>
		<a href="javascript:boardDelClose()" class="easyui-linkbutton" iconCls="icon-cancel" style="width:90px">취소</a>
 	</div>
	<!--=========================== [[글삭제 화면 끝]] =============================-->
	<!--=========================== [[글쓰기 화면 시작]] =============================-->
    <div id="dlg_ins" class="easyui-dialog" title="댓글쓰기" data-options="iconCls:'icon-save', closed:true, footer:'#ft_ins'" style="width:600px;height:650px;padding:10px">
    	<form id="board_ins" method="post" enctype="multipart/form-data" action="boardInsert.sp4">    
    	<input type="hidden" name="bm_no" value="<%=bm_no%>">
    	<input type="hidden" name="bm_group" value="<%=bm_group%>">
    	<input type="hidden" name="bm_pos" value="<%=bm_pos%>">
    	<input type="hidden" name="bm_step" value="<%=bm_step%>">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="bm_title" label="제목:" labelPosition="top" data-options="prompt:'제목'" style="width:400px;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  name="bm_writer" label="작성자:" labelPosition="top" data-options="prompt:'작성자'" style="width:250px;">
        </div>        
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  name="bm_content" label="내용:" labelPosition="top" data-options="prompt:'내용',multiline:true, width:500, height:120">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="bm_email" label="Email:" labelPosition="top" data-options="prompt:'Enter a email address...',validType:'email'" style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  name="bm_pw" label="비밀번호:" labelPosition="top" style="width:200;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-filebox" label="첨부파일:"  name="bs_file" labelPosition="top" data-options="width:'400px'" >
        </div>
    	</form>
    </div>    
    <div id="ft_ins">
		<a href="javascript:insAction()" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">저장</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true">취소</a>
	</div>
    <!--=========================== [[글쓰기 화면   끝 ]] =============================--> 
	<div id="dlg_upd"></div>
</body>
</html>