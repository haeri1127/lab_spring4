<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	StringBuilder path = new StringBuilder(request.getContextPath());
	path.append("/");
	List<Map<String,Object>> boardList = null;
	boardList = (List<Map<String,Object>>)request.getAttribute("boardList");
	int size = 0;
	if(boardList!=null){
		size = boardList.size();		
	}
	/* out.print("size : "+size); */
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 구현 - [WEB-INF]</title>
<!-- jEasyUI 시작 -->
<link rel="stylesheet" type="text/css" href="<%=path.toString() %>themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path.toString() %>themes/icon.css"> 
<!-- jEasyUI JS 시작 -->
<script type="text/javascript" src="<%=path.toString() %>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path.toString() %>js/jquery.easyui.min.js"></script>
<script type="text/javascript">
	function boardSel(){
		$('#dg_board').datagrid({ 
			url:'./jsonGetBoardList.sp4'
			,onLoadSuccess: function(){
				alert("조회 호출 성공");
			}
		});
	}
	
	//글쓰기 폼 열림
	function boardInsFrom(){
		//왜안돼 ㅅㅂ
		// $('#dlg_ins').dialog('open');
		$('#dlg_ins').dialog({
			title:'글수정'
		  ,width:720
		  ,height:450
		  ,closed:false
		  ,cache:false
		 ,modal:true	  
		});
	}
	
	//수정체크
	function ins_check(){
		
		
		if(form_ins.ins_title.value == "") {
		    alert("제목을 입력해 주세요.");
		    form_ins.ins_title.focus();
		    return false;
		  }
		  else if(form_ins.ins_content.value == "") {
		    alert("내용을 입력해 주세요.");
		    fr.pw.focus();
		    return false;
		  }
		  else return true;
	}
	
	function boardUpd(){
		
	}
	function boardDel(){
		
	}
</script>
</head>
<body>
<script type="text/javascript">
/* 
	호이스팅이 일어나는 것이 아니라면 반드시 순서를 지킨다. ->절차지향
	아래 코드는 ready가 붙어있기 때문에
*/
	$(document).ready(function(){/* 익명함수 */
		$('#dg_board').datagrid({ /* #-유니크(여기서는 id, 자바에서는 property..? ,erd-pk)
									datagrid() datagrid-오브젝트, 뒤에 괄호오기 때문에 생성자 */
									/* 바깥쪽에 더블, 안쪽에 싱글, 구문자는 콜론 */
		    columns:[[
		        {field:'BM_NO',title:'글번호',width:100, align:'center'},
		        {field:'BM_TITLE',title:'제목',width:400, align:'left'},
		        {field:'BM_DATE',title:'작성일',width:150, align:'center'},
		        {field:'BS_FILE',title:'첨부파일',width:230, align:'center'},
		        {field:'BM_HIT',title:'조회수',width:100, align:'center'}
		    ]]
		});
		/* $('#btn_sel').bind('click', function(){
	        //alert('조회');
	        boardSel();
	    });
		$('#btn_ins').bind('click', function(){
	       	//alert('입력');
	        boardIns();
	    });
		$('#btn_upd').bind('click', function(){
	        //alert('수정');
	        boardUpd();
	    });
		$('#btn_del').bind('click', function(){
	        //alert('삭제');
	        boardDel();
	    }); */
	});
</script>
	<table id="dg_board" class="easyui-datagrid" data-options="title:'게시판',toolbar:'#tb_board'" style="width:1000px;height:350px">
<!-- 	    <thead>
	        <tr>
	            <th>글번호</th>
	            <th>제목</th>
	            <th>작성일</th>
	            <th>첨부파일</th>
	            <th>조회수</th>
	        </tr>
	    </thead> -->
	    <tbody>
<%
	//조회 결과가 없는 거야?
	if(size==0){
%>
		<tr>
	            <th colspan="5">조회결과가 없습니다.</th>
	    <tr>
<%
	}
	else{ //조회결과가 없는데..
		for(int i=0;i<size;i++){
			Map<String,Object> rmap = boardList.get(i);
			if(i==size) break;
%>
		<tr>
	            <td><%=rmap.get("BM_NO") %></td>
	            <td><a href="getBoardDetail.sp4?bm_no=<%=rmap.get("BM_NO") %>"><%=rmap.get("BM_TITLE") %></td>
	            <td><%=rmap.get("BM_DATE") %></td>
	            <td><%=rmap.get("BS_FILE") %></td>
	            <td><%=rmap.get("BM_HIT") %></td>
	    </tr>
<%
	}///////////////////end of for
}//////////////////////end of else
%>
	    </tbody>
	</table>
	<div id="tb_board" style="padding:2px 5px;">
		<a id="btn_sel" href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true">조회</a>
		<a id="btn_ins" href="javascript:boardInsFrom()" class="easyui-linkbutton" iconCls="icon-add" plain="true">입력</a>
		<a id="btn_upd" href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true">수정</a>
		<a id="btn_del" href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">삭제</a>
	</div>
	
<!-- ================================== [[글쓰기 화면 시작]] =============================================== -->
	<div id="dlg_ins" class="easyui-dialog" title="글쓰기" data-options="iconCls:'icon-save', closed:'true'" style="width:700px;height:650px;padding:10px">
	     	<form id="form_ins" action="./boardInsert.sp4" method="get" onsubmit="return ins_check()">
		        <div style="margin-bottom:20px">
		            <input name="bm_title" class="easyui-textbox" label="제목" labelPosition="top" style="width:50%;">
		        </div>
		        <div style="margin-bottom:20px">
		            <input name="bm_writer" class="easyui-textbox" label="작성자" labelPosition="top" style="width:20%;">
		        </div>
		        <div style="margin-bottom:20px">
		            <input name="bm_email" class="easyui-textbox" label="email" labelPosition="top"  data-options="prompt:'Enter a email address...',validType:'email'" style="width:50%;">
		        </div>
		        <div style="margin-bottom:20px">
		            <input name="bm_content" class="easyui-textbox" label="글 내용" labelPosition="top" style="width:100%; height: 100px;">
		        </div>
		        <div style="margin-bottom:20px">
		            <input name="bm_pw" class="easyui-textbox" label="비밀번호" labelPosition="top" style="width:50%;">
		        </div>
	        </form>
	        <div id="btn_boardIns">
	            <!-- <a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100%;height:32px">작성 완료<a> -->
	            <button type="submit" form="form_ins" class="easyui-linkbutton" iconCls="icon-ok" style="width:100%;height:32px">등록</button>
	        </div>
    </div>
 <!-- ================================== [[글쓰기 화면   끝]] =============================================== -->
	
</body>
</html>