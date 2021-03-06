<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/concourseconnect-taglib.tld" prefix="ccp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="applicationPrefs" class="com.concursive.connect.config.ApplicationPrefs" scope="application"/>
<jsp:useBean id="LoginBean" class="com.concursive.connect.web.modules.login.beans.LoginBean" scope="request"/>
<jsp:useBean id="clientType" class="com.concursive.connect.web.utils.ClientType" scope="session"/>
<jsp:useBean id="User" class="com.concursive.connect.web.modules.login.dao.User" scope="session"/>
<!DOCTYPE html>  
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta property="wb:webmaster" content="1627a2535b208995" />
<title>Mytotalworld</title>
<%@ include file="../../../initPage.jsp" %>
<%
boolean sslEnabled = "true".equals(applicationPrefs.get("SSL"));
boolean isUserLoggedIn = User.isLoggedIn();
request.setAttribute("isUserLoggedIn", isUserLoggedIn);
Object locale=session.getAttribute("LOCALE_LANG");
List<Map<String, String>> advList=applicationPrefs.getAdv("mtwIndexBanner", locale+"");
request.setAttribute("advList", advList);
%>
<c:forEach items="${advList}" var="adv">
	<c:if test="${!empty adv}"> 
	<br/><br/>
	 ${adv.advUrl}--${adv.resUrl}--${adv.advTitle}
	 <br/><br/>
	</c:if>
</c:forEach>
<link href="${ctx }/mtw/resources/css/basic.css" rel="stylesheet" type="text/css">
		<link href="${ctx }/mtw/mtwusercenter/view/mytotalworld/css/index.css" rel="stylesheet" type="text/css">
		<link href="${ctx }/mtw/resources/platform_comm/css/public.css" rel="stylesheet" type="text/css">
		<link href="${ctx }/mtw/resources/platform_comm/css/share.css" rel="stylesheet" type="text/css">
		<link href="${ctx}/mtw/resources/platform_comm/css/load8.css" rel="stylesheet"/>
<style>
			
.m_pop_show .mcont_winpop{position:fixed;z-index:9999;width:100%;top:50%;left:50%;-webkit-transform:translate(-50%,-50%);transform:translate(-50%,-50%);}
.m_pop_show .inner{border:1px solid #999;background-color:#fff;text-align:center;margin: 0 auto;width:400px;padding:10px 20px; line-height: 30px;}

			</style>
		<script type="text/javascript" src="${ctx }/mtw/mtwusercenter/view/mytotalworld/js/jquery-1.8.3.min.js"></script>
			<script type="text/javascript">
			//window.location.href='http://www.mytotalworld.com/seller_mall/';
			var js_lang_message_from='<%=lang.getString("popcommon.text.pop_title") %>';
			var js_lang_message_from_ok='<%=lang.getString("mtwhonme.pop.button.OK") %>';
			var js_lang_message_from_yes='<%=lang.getString("sns.group.manage.text.yes") %>';
			$(function(){
				$.ajax({
					url:"${ctx}/sgmtw/Home/So?r="+Math.random(),
		 			dataType:"json",
		 			type:"post",
		 			success:function(data){
		 				//alert(data.flag);
		 				if(data.flag==1){
		 					$("#login_show_usname").html("");
		 					$("#login_show_usname").html(data.us);
		 					$(".logreg").css("display","none");
		 					$(".logreg_after").css("display","block");
		 				}else{
		 					$(".logreg").css("display","block");	
		 				}
		 			},error:function(data){
		 				$(".logreg").css("display","block");
		 			}
				});
			});
			</script>
	<script type="text/javascript" src="${ctx}/mtw/resources/platform_comm/js/load.js"></script>
		<script type="text/javascript" src="${ctx }/mtw/resources/js/sgmtw.js"></script>
<script type="text/javascript" src="${ctx}/mtw/resources/js/jquery.qrcode.min.js"></script>
		<link href="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/favicon.ico" rel="shortcut icon">
		<script type="text/javascript" src="${ctx }/mtw/mtwusercenter/view/mytotalworld/js/index.js"></script>
			<script language="JavaScript">
			var calendar_path = "${ctx}";
			var share_img;
			$(document).ready(function() {
				//loadshow.show('','','',"正在加载中……");
				$.ajax({
					type:"post",
					url:calendar_path+"/Login.do?command=QueryLook",
					data:{},
					dataType:"json",
					success:function(data){
						$(".people_number").html(data.data);
						if(data.isLogin==1){
							if(data.b==0){
								<%--
								if(confirm("<%=lang.getString("sns.no.bind.mobile.tip") %>")){
									location.href = "${ctx}/sgmtw/UserSecurity/BindingMobile";
								}
								--%>
							}	
						}
					}
					
				}); 
				abb();
				$("#sharenow").click(function(){
					messagebox.showbox('<em class="mtwfont iconmtw-msgok green_a font_25"></em> Share successfully', 1000);
				})

				$("img").each(function(index,el){
					if(index>=3)return false;
					if(this.width>=180&&this.height>=180){
						share_img=this.src;return null;
					}
				});
				 var share_lis=$(".share_id");
				 $.each(share_lis,function(index,el){
					 $(this).click(function(){
						 $("#m_moresharsty").hide();
						 m_share_action($(this).attr("value"));
					 });
				});
			});

			 function m_weixin_popup_close(){
				var show = $('#m_weixin_qrcode_dialog_bg').css('display');
				$('#m_weixin_qrcode_dialog_bg').css('display',show =='block'?'none':'block');
			 }
			 //分享代码
			function m_share_action(share_web_name){
				var share_href=window.location.href;
				var share_title=document.title;
				var description=document.description;
				if (description==undefined){description="my total world";}
				//mtwAlert('<%=lang.getString("mtwhome.api.tip.info") %>');$('#sharemore').hide();return false;
				if(share_href==null||share_title==null||share_web_name==null){
					mtwAlert('<%=lang.getString("mtwhome.api.tip.info") %>');$('#sharemore').hide();return false;
				}
				if(share_img=='undefined'||share_img==''||share_img==null)share_img=share_href+"/mtw/mtwusercenter/view/mytotalworld/images/mtwindex.jpg";
				var share_url;
				if(share_web_name=='facebook'){
					share_url="https://www.facebook.com/dialog/share?app_id=1756596684554410&display=popup&href="+share_href+"&picture="+share_img+"&title="+share_title+"&description="+share_title+"&redirect_uri=";
				}else if(share_web_name=='weibo'){
					share_url="http://service.weibo.com/share/share.php?appkey=3170462830&searchPic=true&style=simple&url="+share_href+"&title="+share_title+"&pic="+share_img;
				}else if(share_web_name=='vk'){
					share_url="http://vk.com/share.php?url="+share_href+"&title="+share_title+"&description="+share_title+"&image="+share_img;	
				}else if(share_web_name=='twitter'){
					share_url="https://twitter.com/intent/tweet?via=Mytotalworld&text="+share_title+"&url="+share_href;
				}else if(share_web_name=='pinterest'){
					share_url="https://www.pinterest.com/pin/create/button/?url="+share_href+"&media="+share_img+"&description="+share_title;
				}else if(share_web_name=='linkedin'){
					share_url="https://www.linkedin.com/shareArticle?mini=true&url="+share_href+"&title="+share_title+"&summary="+share_title+"&source=";
				}else if(share_web_name=='google'){
					share_url="https://plus.google.com/share?url="+share_href+"&t="+share_title;
				}else if(share_web_name=='qq'){
					share_url="http://connect.qq.com/widget/shareqq/index.html?url="+share_href+"&desc="+share_title+"&title="+share_title+"&summary=&pics="+share_img+"&flash=&site=&style=201&width=32&height=32&showcount=";
				}else if(share_web_name=='wechat'){$('#sharemore').hide();
					 $('#m_weixin_qrcode_dialog_bg').css('display','block');
					 if($('#m_weixin_qrcode_dialog_bg').html()!='')return false;
					 $('#m_weixin_qrcode_dialog_bg').html('<div class="v_bg" onclick="m_weixin_popup_close()"></div><div class="inner"><div class="v_tt"><%=lang.getString("mtwhome.api.tip.weixininfo")%></div><div class="v_close"><a href="javascript:" onclick="m_weixin_popup_close()">x</a></div></div>');
					jQuery(function(){
						$("#m_weixin_qrcode_dialog_bg .inner").qrcode({
							render:"canvas",width: 150,height: 150,text:share_href
					});})
					$('#m_moresharsty').hide();
					return false;
				}
				if(share_url==null){
					mtwAlert('<%=lang.getString("mtwhome.api.tip.info") %>');$('#sharemore').hide();return false;
				}
				$('#m_moresharsty').hide();
				window.open(share_url,'_blank','');
			}
function abb(){
	var oDiv =document.getElementById("sharebox");
	var oP = document.getElementById("sharetnum");
	var oT = oDiv.getElementsByTagName('textarea')[0];
	var ie = !-[1,];
	var bBtn = true;
	var timer = null;
	var iNum = 0;
	var maxnum=280;
	oT.onfocus = function(){
		if(bBtn){
			oP.innerHTML=maxnum;
			bBtn = false;
		}
		
	};
	
	oT.onblur = function(){
		if(oT.value==''){
			oP.innerHTML=maxnum;
			bBtn = true;
		}
		
	};
	
	if(ie){
		oT.onpropertychange = toChange;
	}
	else{
		oT.oninput = toChange;
	}
	
	function toChange(){
		var num = Math.ceil(getLength(oT.value));//english
//		var num = Math.ceil(getLength(oT.value)/2);//china
		
		if(!oP){return}
		
		if(num<=maxnum){
			oP.innerHTML = maxnum - num;
			oP.style.color = '';
		}
		else{
			oP.innerHTML = "-"+(num - maxnum);
			oP.style.color = 'red';
		}
		

		
	}
	
	
	function getLength(str){
		return String(str).replace(/[^\x00-\xff]/g,'aa').length;
	}
	
	
};
var messagebox = {
	confirm: function(boxcss, title, cont, txtyes, calkback, txtno, calkback2, calkbackhtml) {
		if (!cont) {
			cont = "Are You Sure"
		}
		if (!txtyes) {
			txtyes = "yes"
		}
		if (!txtno) {
			txtno = "Cancel"
		}
		var html;
		html = '<div class="mask_bg"></div>';
		html += '<div class="mcont_winpop"><div class="inner">';
		if (title.length > 0) {
			html += '<div class="v_tt hui_b">' + title + '</div>';
			html += '<div class="v_cc">' + cont + '</div>';
		} else {
			html += '<div class="v_cc v_ccbig">' + cont + '</div>';
		}
		html += '<div class="v_bnt"><div class="s_cancle"><em>' + txtno + '</em></div><div class="s_yes"><em>' + txtyes + '</em></div></div>';
		html += '</div></div>';
		var confirmbox = document.createElement("div");
		confirmbox.setAttribute("class", "m_pop_confirm m_pop_confirmjs " + boxcss)
		confirmbox.innerHTML = html;
		document.body.appendChild(confirmbox);
		if (calkbackhtml) {
			calkbackhtml()
		}
		var Cbox = $(".m_pop_confirmjs");
		Cbox.find(".mask_bg").click(function() {
			removethis(Cbox)
		});
		Cbox.find(".s_cancle").click(function() {
			removethis(Cbox)
			calkback2();
		});
		Cbox.find(".s_yes").click(function() {
			removethis(Cbox);
			calkback();
		});

		function removethis(ts) {
			ts.remove();
		}

	},
	showbox: function(cont, times) {
		var html;
		html = '<div class="mcont_winpop"><div class="inner">';
		html += cont;
		html += '</div></div>';
		var confirmbox = document.createElement("div");
		confirmbox.setAttribute("class", "m_pop_show m_pop_showjs")
		confirmbox.innerHTML = html;
		document.body.appendChild(confirmbox);
		setTimeout(function() {
			$(".m_pop_showjs").remove();
		}, times)
		$(".m_pop_showjs").find(".js_hide").click(function() {
			$(".m_pop_showjs").remove();
		});

	},
	showalert: function(cont) {
		var html;
		html += '<div class="mcont_winpop"><div class="inner">';
		html += cont;
		html += '</div></div>';
		var confirmbox = document.createElement("div");
		confirmbox.setAttribute("class", "m_pop_show m_pop_showjs")
		confirmbox.innerHTML = html;
		document.body.appendChild(confirmbox);
	}
}

function switch_lang(lang){
	var url = window.location.href;
	if(url.indexOf('#')!=-1){
		var surl = url.substring(url.length-1);
		if(surl=='#'){
			url = url.substring(0, url.length-1);
		}	
	}
	if(url.indexOf('lang=en')!=-1){
		url = url.replace('lang=en', 'lang='+lang);
	}else if(url.indexOf('lang=zh')!=-1){
		url = url.replace('lang=zh', 'lang='+lang);
	}else if(url.indexOf('?')!=-1){
        var frontUrl = url.substring(0,url.indexOf("?")+1);
        var backUrl = url.substring(url.indexOf("?")+1);
        url = frontUrl + "lang="+lang+"&"+backUrl;
		//url = url + '&lang='+lang;
	}else{
		url = url + '?lang='+lang;
	}
	location.href = url;
};
			</script>
			<!-- google+登录 -->
 <meta name="google-signin-scope" content="profile email">
 <meta name="google-signin-client_id" content="977597429839-ts24lbumbsjfcsolh6og59sf52gng8m7.apps.googleusercontent.com">
 	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
<meta content="email=no,telephone=no" name="format-detection"/>
	</head>

	<body style="height: 100%;"><div id="m_weixin_qrcode_dialog_bg" style="display:none;" align="center"></div>
		<div class="m_pop_wind m_pop_w_share_cont" style="display: none;" id="m_pop_w_share_cont">
			<div class="mask_bg" onclick="$('#m_pop_w_share_cont').hide()"></div>
			<div class="mcont">
				<div class="inner">
					<div class="right p10_2 p5_1 hand" onclick="$('#m_pop_w_share_cont').hide()">
						<em class="mtwfont iconmtw-guanbi"></em>
					</div>
					<div class="mt p20_a font_t p20_1 p10_3 tal weight">Share to</div>
					<div class="mc p20_a tal">
						<div class="p10_1">
							<div class="left"><em class="red_a">*</em> Say something:</div>
							<div class="right"><span id="sharetnum">140</span> characters remaining</div>
						</div>
						<div class="p10_1">
							<div class="inp_abox" id="sharebox">
								<textarea name="" cols="" rows="" class="inp_area" placeholder="We are in MyTotalWorld.com now， the world is also yours, come and join us!"></textarea>
							</div>
						</div>
						<div class="p10_1">
							http://www.mytotalworld.com/
						</div>
						<div class="clear20"></div>
						<div class="p10_1 bd1"> Bounded</div>
						<div class="p10_1">
							<ul>
								<li>
									<label class="mtw_ui_cell h_check">
												<div class="left">
													<input name="Checkname" type="checkbox" value="" class="mtw_uicell_check" checked="checked" /><span class="mtw_uicell_icon_checked"></span>
												</div>
												<div class="left v_cont"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_weixin.png">Wechat</div>
											</label>

								</li>
								<li>
									<label class="mtw_ui_cell h_check">
												<div class="left">
													<input name="Checkname" type="checkbox" value="" class="mtw_uicell_check" checked="checked" /><span class="mtw_uicell_icon_checked"></span>
												</div>
											</label>
									<div class="left v_cont">
										<img src="/mytotalworld/public/img/share/logo_facebook.png"> Facebook
									</div>
								</li>

								<li>
									<label class="mtw_ui_cell h_check">
												<div class="left">
													<input name="Checkname" type="checkbox" value="" class="mtw_uicell_check" checked="checked" /><span class="mtw_uicell_icon_checked"></span>
												</div>
											</label>
									<div class="left v_cont">
										<img src="/mytotalworld/public/img/share/logo_twitter.png"> Twitter
									</div>
								</li>
								<li>
									<label class="mtw_ui_cell h_check">
												<div class="left">
													<input name="Checkname" type="checkbox" value="" class="mtw_uicell_check" checked="checked" /><span class="mtw_uicell_icon_checked"></span>
												</div>
											</label>
									<div class="left">
										<img src="/mytotalworld/public/img/share/logo_yahoo.png"> Yahoo
									</div>
								</li>
								<li>
									<label class="mtw_ui_cell h_check">
												<div class="left">
													<input name="Checkname" type="checkbox" value="" class="mtw_uicell_check" checked="checked" /><span class="mtw_uicell_icon_checked"></span>
												</div>
											</label>
									<div class="left">
										<img src="/mytotalworld/public/img/share/logo_whatsapp.png"> WhatsApp
									</div>
								</li>
								<li>
									<label class="mtw_ui_cell h_check">
												<div class="left">
													<input name="Checkname" type="checkbox" value="" class="mtw_uicell_check" checked="checked" /><span class="mtw_uicell_icon_checked"></span>
												</div>
											</label>
									<div class="left">
										<img src="/mytotalworld/public/img/share/logo_line.png"> Line
									</div>
								</li>
								<li>
									<label class="mtw_ui_cell h_check">
												<div class="left">
													<input name="Checkname" type="checkbox" value="" class="mtw_uicell_check" checked="checked" /><span class="mtw_uicell_icon_checked"></span>
												</div>
											</label>
									<div class="left">
										<img src="/mytotalworld/public/img/share/logo_viber.png"> Viber
									</div>
								</li>
								<li>
									<label class="mtw_ui_cell h_check">
												<div class="left">
													<input name="Checkname" type="checkbox" value="" class="mtw_uicell_check" checked="checked" /><span class="mtw_uicell_icon_checked"></span>
												</div>
											</label>
									<div class="left">
										<img src="/mytotalworld/public/img/share/instagram.png"> Instagram
									</div>
								</li>
								<li>
									<label class="mtw_ui_cell h_check">
												<div class="left">
													<input name="Checkname" type="checkbox" value="" class="mtw_uicell_check" checked="checked" /><span class="mtw_uicell_icon_checked"></span>
												</div>
											</label>
									<div class="left">
										<img src="/mytotalworld/public/img/share/pinterest.png"> Pinterest
									</div>
								</li>
								<li>
									<label class="mtw_ui_cell h_check">
												<div class="left">
													<input name="Checkname" type="checkbox" value="" class="mtw_uicell_check" checked="checked" /><span class="mtw_uicell_icon_checked"></span>
												</div>
											</label>
									<div class="left">
										<img src="/mytotalworld/public/img/share/vk.png"> VK
									</div>
								</li>
								<li>
									<label class="mtw_ui_cell h_check">
												<div class="left">
													<input name="Checkname" type="checkbox" value="" class="mtw_uicell_check" checked="checked" /><span class="mtw_uicell_icon_checked"></span>
												</div>
											</label>
									<div class="left">
										<img src="/mytotalworld/public/img/share/linkedin.png"> Linkedin
									</div>
								</li>
								<li>
									<label class="mtw_ui_cell h_check">
												<div class="left">
													<input name="Checkname" type="checkbox" value="" class="mtw_uicell_check" checked="checked" /><span class="mtw_uicell_icon_checked"></span>
												</div>
											</label>
									<div class="left">
										<img src="/mytotalworld/public/img/share/google.png"> Google
									</div>
								</li>
							</ul>
						</div>
						<div class="clear20"></div>
						<div class="p10_1 bd1"> Unbounded account</div>
						<div class="p10_1">
							<ul>
								<li>
									<img src="/mytotalworld/public/img/share/logo_qq_black.png"> QQ
								</li>
								<li>
									<img src="/mytotalworld/public/img/share/logo_weibo_black.png">Weibo
								</li>
							</ul>
						</div>
						<div class="m_sheetlist_bnt">
							<div class="v_bnt p0">
								<div id="sharenow"><a href="javascript:" onclick="$('#m_pop_w_share_cont').hide()" class="bnt_a bg3 h40 tac">Share Now</a></div>
								<div><a href="javascript:" onclick="$('#m_pop_w_share_cont').hide()" class="bnt_a bg2 h40 tac">Cancel</a></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="m_pop_wind" id="m_pop_w_sendmsg" style="display: none;">
			<div class="mask_bg" onclick="$('#m_pop_w_sendmsg').hide()"></div>
			<div class="mcont">
				<div class="inner">
					<div class="right p10_2 p5_1 hand" onclick="$('#m_pop_w_sendmsg').hide()">
						<em class="mtwfont iconmtw-guanbi"></em>
					</div>
					<div class="mt p20_a font_t p20_1 p10_3 tal weight">Send message</div>
					<div class="mc p20_a tal">
						<div class="p10_1"><em class="red_a">*</em> To</div>
						<div class="p10_1">
							<div class="inp_abox">
								<input type="text" class="inp_a all" placeholder="usename,email or mobile">
							</div>
						</div>
						<div class="p10_1"><em class="red_a">*</em> Subject</div>
						<div class="p10_1">
							<div class="inp_abox">
								<input type="text" class="inp_a all" placeholder='New 2015 Edition! Amazon Kindle Paperwhite 6" 300 PPI 4GB Touchscreen Wi-fi'>
							</div>
						</div>
						<div class="p10_1"><em class="red_a">*</em> Content</div>
						<div class="p10_1">
							<div class="inp_abox">
								<textarea name="" cols="" rows="" class="inp_area" placeholder="I find a good product and share it to you！    http://www.mytotalworld.com/product /123434234.html"></textarea>
							</div>
						</div>
						<div class="m_sheetlist_bnt">
							<div class="v_bnt p0">
								<div><a href="javascript:" onclick="$('#m_pop_w_sendmsg').hide()" class="bnt_a bg3 h40 tac">Send</a></div>
								<div><a href="javascript:" onclick="$('#m_pop_w_sendmsg').hide()" class="bnt_a bg2 h40 tac">Cancel</a></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="head_home">
			<div class="layout clearfix">
				<div class="logo">
					<a href="${ctx }"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_group.png"></a>
				</div>
				<div class="language">
					<span>
					<!-- <a href="javascript:;" class="en">English</a> -->
					 <c:if test="${LOCALE_LANG=='en'}">
						<a href="javascript:;" class="en">English</a>
					 </c:if>
					 <c:if test="${LOCALE_LANG=='zh'}">
						<a href="javascript:;" class="cn">简体中文</a>
					 </c:if>
						<i></i>
					</span>
					<div class="language_nav">
						<i></i>
						<dl>
						<!-- 
							<dd><a href="javascript:;" class="en">English</a></dd>
							<dd><a href="javascript:;" class="cn">简体中文</a></dd>
						-->
							<dd><a href="javascript:;" onclick="switch_lang('en')" class="en">English</a></dd>
							<dd><a href="javascript:;" onclick="switch_lang('zh')" class="cn">简体中文</a></dd>
						 
						</dl>
					</div>
				</div>
				<%-- <c:if test="${isUserLoggedIn==false}"> --%>
				<div class="logreg" style="display:none;">
				<%-- <form name="loginForm" method="post" action="http<ccp:evaluate if="<%= sslEnabled %>">s</ccp:evaluate>://<%= getServerUrl(request) %>/Login.do?command=Login&auto-populate=true" onSubmit="return checkForm(this);"> --%>
					<ul class="clearfix">
						<li>
							<input id="username" name="username" type="text" placeholder="<%=lang.getString("mtwhome.text_field.user_name") %>" class="input_text">
							<p>
								<label><input type="checkbox" id="addCookie" name="addCookie" value="true"> <%=lang.getString("mtwhome.checkbox.stay_signed_in") %></label>
							</p>
						</li>
						<li>
							<input id="password" name="password" type="password" placeholder="<%=lang.getString("mtwhome.text_field.password") %>" class="input_text">
							<p><a href="${ctx }/sgmtw/UserSecurity/ForgetPassword"><%=lang.getString("mtwhome.link.forget_password") %></a></p>
						</li>
						<li>
							<p><input type="button" class="input_button" value="<%=lang.getString("mtwhome.button.sign_in") %>" onclick="checkForm()"><a href="${ctx }/register" class="new"><%=lang.getString("mtwhome.link.new_to_mtw") %></a></p>
						</li>
					</ul>
					<!-- </form> -->
					<div class="login_with">
						<div class="tt"><%=lang.getString("login.text.login_with") %></div>
							<%--<script>
					
  // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    //登录状态 for FB.getLoginStatus().
    if (response.status === 'connected') {
      testAPI();
    } else if (response.status === 'not_authorized') {
    } else {
    }
  }

  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
  FB.init({
    appId      : '861463543959551',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.6' // use version 2.2
  });

  FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
  });

  };

  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  function testAPI() {
    FB.api('/me', function(response) {
      $.ajax({
			url:"${ctx}/sgmtw/extApi/FaceBookLoginSucc",
			dataType:"json",
			type:"post",
			data:{code:response.id,name:response.name},
			success:function(data){
				window.location.reload();
			}
		}); 
    });
  }
  function FBout(){
	  FB.logout(function(response) {
		   // Person is now logged out
		});
  }

</script>   --%>

<%-- 
<fb:login-button scope="public_profile,email" onlogin="checkLoginState();" data-auto-logout-link="true">
</fb:login-button>
--%>

 <%--<div id="status"></div>  --%>
<!-- fackbook登录结束 -->
						<%-- <a href="javascript:;" class="btn_loginshow1"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_facebook.png"></a> --%>
						<%-- <a href="#" class="btn_loginshow2"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/linkedin.png"></a> --%>  
<!-- vk -->						<%-- <a href="javascript:;" class="btn_loginshow3"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_weixin.png"></a> --%>
 <%--<script src="http://vk.com/js/api/openapi.js" type="text/javascript"></script>--%>
 <%--	<div id="login_button" onclick="VK.Auth.login(authInfo);"></div>--%>
<%--
	<script language="javascript">
	VK.init({
	  apiId: '5491468'
	});
	function authInfo(response) {
	  if (response.session) {
		  VK.api("users.get", {uids:response.session.mid}, function(data) {
	   			var myobj=eval(data.response);  
	   		 $.ajax({
	 			url:"${ctx}/sgmtw/extApi/VKLoginSucc",
	 			dataType:"json",
	 			type:"post",
	 			data:{id:myobj[0].uid,fname:myobj[0].first_name,lname:myobj[0].last_name},
	 			success:function(data){
	 				//window.location.reload();
	 			}
	 		}); 
			});
	  } else {
	  } 
	}
	VK.Auth.getLoginStatus(authInfo);
	VK.UI.button('login_button');
	</script>
 --%>
<!-- google -->
<%--<div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>--%>
  
<!-- google end -->
						<a href="javascript:;" onclick="fackbooklogin()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_facebook.png"></a>
						<a href="javascript:;" onclick="getTwitterCode()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_twitter.png"></a>
						<a href="javascript:;" onclick="OpenWXLogin()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_weixin.png"></a>
						<a href="javascript:;" onclick="OpenQQLogin()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_qq.png"></a>
						<%-- <a href="javascript:;" onclick="lineLogin()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_line.png"></a> --%>
						<%-- <a href="javascript:;" onclick="googleLogin()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/google.png"></a> --%>
						<%-- <a href="javascript:;" onclick="OpenSinaWeiboLogin()"><img src="${ctx}/mtw/mtwusercenter/view/mytotalworld/images/logo_weibo.png"></a> --%>
						<a href="javascript:" onclick="$('#m_moreloginsty').toggle();$('#m_moresharsty').hide()" class="v_more"><em>+</em></a>
						<a href="javascript:" onclick="$('#m_moresharsty').toggle();$('#m_moreloginsty').hide()" class="v_share"><em class=" mtwfont iconmtw-share1"></em></a>
						<%-- <a href="javascript:;" onclick="" class="btn_loginshow4"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_qq.png"></a> --%>
					</div>
					<div class="m_moreloginsty" id="m_moreloginsty">
					<div style="position:fixed;top:0; left:0;width:100%;height:100%;" onclick="$('#m_moreloginsty').hide()"></div>
						<div class="inner">
							<div class="mt"><%=lang.getString("login.text.login_with") %> </div>
							<div class="mc">
								<ul>
									<li>
										<a href="javascript:;" onclick="fackbooklogin()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_facebook.png">Facebook</a>
									</li>
									<li>
										<a href="javascript:;" onclick="getTwitterCode()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_twitter.png">Twitter</a>
									</li>
									<!--
									
									<li>
										<a href="javascript:;" class="btn_loginshow5" ><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_yahoo.png">Yahoo</a>
									</li> -->
									<!-- 
									<li>
										<a href="javascript:;" class="btn_loginshow5"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_whatsapp.png">WhatsApp</a>
									</li>
									 -->
									<li>
										<a href="javascript:;" onclick="lineLogin()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_line.png">Line</a>
									</li>
									<li>
										<a href="javascript:;" onclick="googleLogin()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/google.png">google</a>
									</li>
									<!-- 
									<li>
										<a href="javascript:;" class="btn_loginshow5" ><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_viber.png">Viber
									</li>
									 -->
									<li>
										<a href="javascript:;"  onclick="instagramLogin()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/instagram.png">Instagram</a>
									</li>
									<!-- 
									<li>
										<a href="javascript:;" class="btn_loginshow5" ><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/pinterest.png">Pinterest</a>
									</li>
									 -->
									<li>
										<a href="javascript:;" onclick="vklogin()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/vk.png">VK</a>
									</li>
									<li>
										<a href="javascript:;" onclick="OpenLinked()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/linkedin.png">Linkedin</a>
									</li>
									
									<li>
										<a href="javascript:;" onclick="OpenWXLogin()"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_weixin.png">Wechat</a>
									</li><!-- OpenWXLogin() -->
									 <li>
										<a href="javascript:;" onclick="OpenQQLogin()">
											<img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_qq.png">QQ
										</a>
									</li><!-- OpenQQLogin() -->
									
									<li>
										<a href="javascript:;" onclick="OpenSinaWeiboLogin()">
											<img src="${ctx}/mtw/mtwusercenter/view/mytotalworld/images/logo_weibo.png">Weibo
										</a>
									</li><!-- OpenSinaWeiboLogin() -->
								</ul>
							</div>
						</div>
					</div>
					<div class="m_moreloginsty share" id="m_moresharsty">
						<div style="position:fixed;top:0; left:0;width:100%;height:100%;" onclick="$('#m_moresharsty').hide()"></div>
						<div class="inner">
							<div class="mt"><%=lang.getString("snscalendar.text.share_to") %> </div>
							<div class="mc">
								<ul>
									<!-- 
									<li>
										<a href="javascript:;" class="share_id" value="email"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/email.png">Message</a>
									</li> -->
									<li>
										<a href="javascript:;" class="share_id" value="facebook"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_facebook.png">Facebook</a>
									</li>
									<li>
										<a href="javascript:;" class="share_id" value="twitter"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_twitter.png">Twitter</a>
									</li>
									<li>
										<a href="javascript:;" class="share_id" value="wechat"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_weixin.png">Wechat</a>
									</li>
									
									
									<li>
										<a href="javascript:;" class="share_id" value="qq"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_qq.png">QQ</a>
									</li>
									<!-- 
									<li>
										<a href="javascript:;" class="share_id" value="email"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_yahoo.png">Yahoo</a>
									</li> -->
									
									
									<li>
										<a href="javascript:;" class="share_id" value="weibo"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_weibo.png">Weibo</a>
									</li>
									<!-- 
									<li>
										<a href="javascript:;" class="share_id" value="email"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_whatsapp.png">WhatsApp</a>
									</li>
									<li>
										<a href="javascript:;" class="share_id" value="email"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_line.png">Line</a>
									</li>
									<li>
										<a href="javascript:;" class="share_id" value="email"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/logo_viber.png">Viber</li>
									<li>
										<a href="javascript:;" class="share_id" value="email"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/instagram.png">Instagram</a>
									</li>
									 -->
									<li>
										<a href="javascript:;" class="share_id" value="pinterest"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/pinterest.png">Pinterest</a>
									</li>
									<li>
										<a href="javascript:;" class="share_id" value="vk"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/vk.png">VK</a>
									</li>
									<li>
										<a href="javascript:;" class="share_id" value="linkedin"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/linkedin.png">Linkedin</a>
									</li>
									<li>
										<a href="javascript:;" class="share_id" value="google"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/google.png">google</a>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<%-- </c:if> --%>
				
				<%-- <c:if test="${isUserLoggedIn==true}"> --%>
					<div class="logreg_after" style="display:none;">
				      <p><%=lang.getString("snsgroups.text.welcome") %><a href="${ctx}/sgmtw/Home" id="login_show_usname"><%=User.getNick() %></a><em class="fg">|</em><a href="${ctx}/sgmtw/Login/Logout"  onclick="signOut()"><%=lang.getString("sns.group.text.sign.out") %></a></p>
				    </div>
				<%-- </c:if> --%>
			</div>
		</div>
		<div id="main">

			<div class="banner">
				<div class="m_indexbgbox" id="m_indexbgbox">
					<div class="inner"></div>
					<div class="inner_night "></div>
				</div>
				<!--<div id="kinMaxShow">
					<div><img src="images/mtwindex2.jpg" /></div>
					<div><img src="images/mtwindex.jpg" /></div>
				</div>-->
			</div>
			<a href="${frontServer}/help/index" class="howtouse"><%=lang.getString("mtwhome.link.how_to_use") %></a>
			<div class="nav">
				<a href="${frontServer}" class="l1" data-w="120"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/indimg/<%=lang.getString("index.wrold.images.pathcont") %>shoping.jpg"></a>
				<a href="${ctx}/sgmtw/Home/Home" class="l2"><em><%=lang.getString("index.wrold.images.you") %></em></a>
				<a href="${ctx}/sgmtw/GroupHome/Find?categoryId=62" class="l3" data-w="96"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/indimg/<%=lang.getString("index.wrold.images.pathcont") %>family.jpg"></a>
				<a href="${ctx}/sgmtw/GroupHome/Religion?f=cooking" class="l4" data-w="86"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/indimg/<%=lang.getString("index.wrold.images.pathcont") %>cooking.jpg"></a>
				<a href="${ctx}/sgmtw/GroupHome/Religion?f=study" class="l7" data-w="85"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/indimg/<%=lang.getString("index.wrold.images.pathcont") %>study.jpg"></a>
				<a href="${ctx}/sgmtw/GroupHome/Religion?f=sports" class="l6" data-w="105"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/indimg/<%=lang.getString("index.wrold.images.pathcont") %>sport.jpg"></a>
				<a href="${ctx}/sgmtw/ProjectTeam/FollowingsList<c:if test="${!empty seq}">?seq=${seq }</c:if>" class="l5" data-w="106"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/indimg/<%=lang.getString("index.wrold.images.pathcont") %>friends.jpg"></a>
				<a href="${ctx}/sgmtw/GroupHome/Religion?f=savemoney" class="l8" data-w="115"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/indimg/<%=lang.getString("index.wrold.images.pathcont") %>money.jpg"></a>
				<a href="${ctx}/sgmtw/Video<c:if test="${!empty seq}">?seq=${seq }</c:if>" class="l9" data-w="90"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/indimg/<%=lang.getString("index.wrold.images.pathcont") %>video.jpg"></a>
				<a href="${ctx}/sgmtw/GroupList<c:if test="${!empty seq}">?seq=${seq }</c:if>" class="l10" data-w="115"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/indimg/<%=lang.getString("index.wrold.images.pathcont") %>groups.jpg"></a>
				<a href="${ctx}/sgmtw/AccountBinding/Default<c:if test="${!empty seq}">?seq=${seq}</c:if>" class="l11" data-w="85"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/indimg/<%=lang.getString("index.wrold.images.pathcont") %>chat.jpg"></a>
				<a href="${ctx}/sgmtw/GroupHome/Religion?f=travel" class="l12" data-w="90"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/indimg/<%=lang.getString("index.wrold.images.pathcont") %>travel.jpg"></a>
				<a href="${ctx}/sgmtw/GroupHome/Religion?f=religion" class="l13" data-w="82"><img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/indimg/<%=lang.getString("index.wrold.images.pathcont") %>religion.jpg"></a>
			</div>
		</div>
		<div class="mtwindex_bg"></div>
		<div class="people_joined hide" style="margin-bottom:25px;">
			<p class="people_number"></p>
			<h3><%=lang.getString("mtwhome.text.people_have_joinde") %></h3>
		</div>
		<div id="footer">
			<p class="footer_personal">Copyright © 2016 My Total World Ltd. All Rights Reserved.User Agreement, Privacy and Cookies.</p>
		</div>
		<div class="box_login1">
			<div class="box_bg"></div>
			<div class="box_con">
				<i class="close"></i>
				<img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/facebook.jpg">
			</div>
		</div>
		<div class="box_login2">
			<div class="box_bg"></div>
			<div class="box_con">
				<i class="close"></i>
				<img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/twitter.jpg">
			</div>
		</div>
		<div class="box_login3">
			<div class="box_bg"></div>
			<div class="box_con">
				<i class="close"></i>
				<img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/wechat.jpg">
			</div>
		</div>
		<div class="box_login4">
			<div class="box_bg"></div>
			<div class="box_con">
				<i class="close"></i>
				<img src="${ctx }/mtw/mtwusercenter/view/mytotalworld/images/qq.jpg">
			</div>
		</div>

 
  <script>
  function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
    	window.location.reload();
    });
  }
</script>
		<script src="${ctx }/mtw/mtwusercenter/view/mytotalworld/js/jquery.kinMaxShow-1.1.min.js" type="text/javascript"></script>
		<script type="text/javascript">
		  var us_zh_tip_1 = '<%=lang.getString("mtwhome.api.tip.info")%>';
		</script>
		<script type="text/javascript">
		var mtw_domain_name='${PLATFORM_INDEX_URL}/';
		function checkForm(form) {
		  if ($("#username").val() == "" || $("#password").val() == "") {
			  mtwAlert("<%=lang.getString("mtwhonme.pop.text.input_username_password")%>");
		    $("#username").focus();
		    return false;
		  }
		  $.ajax({
				type:"post", 
		        async:false,
		        /* url:"${ctx}/Login.do?command=Login&auto-populate=true",
				data:{username:$("#username").val(),password:$("#password").val(),addCookie:$("#addCookie").val()}, */
		        url : "${SSO_PROJECT_URL}/casLogin", 
				data : {username:$("#username").val(),password:$("#password").val(),service:window.location.href},
		        dataType:"jsonp",
		        jsonp: "jsonpCallback",//服务端用于接收callback调用的function名的参数  
				success:function(data){
					if(data.success){
						triggerLocationLogin();
					}else{
						mtwAlert("<%=lang.getString("mtwhonme.pop.text.input_username_password")%>");
					}
				}
			}); 
		};
		function triggerLocationLogin(){
			$.ajax({
				url:"${ctx}/sgmtw/UserCenter/BasicForm",
	 			dataType:"json",
	 			type:"post",
	 			success:function(data){
	 				location.href="${PLATFORM_INDEX_URL}";
	 			},error:function(data){
	 				location.href="${PLATFORM_INDEX_URL}";
	 			}
			});
		};
		function focusForm(form) {
		  if (form.username.value == "") {
		    form.username.focus();
		  } else {
		    form.password.focus();
		  }
		  return false;
		};
		
		function getTwitterCode(){
			//url="";
			//var winObj = window.open(url,'mtw','width=800,height=600,status=0,toolbar=0');
			commOpenWin(mtw_domain_name+"sgmtw/extApi/GetTwitterCode?callbackURL=/sgmtw/extApi/GetTwitterUserinfo");
		};
		function instagramLogin(){
			//url="";
			//var winObj = window.open(url,'mtw','width=800,height=600,status=0,toolbar=0');
			commOpenWin("https://api.instagram.com/oauth/authorize/?client_id=44970d151d54434686338734be9f5c9f&redirect_uri="+mtw_domain_name+"mtw/extapi_callback_page/instagram_succ.jsp&response_type=token");
		}
		function googleLogin(){
			//url="";
			//var winObj = window.open(url,'mtw','width=800,height=600,status=0,toolbar=0');
			commOpenWin("https://accounts.google.com/o/oauth2/auth?scope=openid%20email&state=Reurl&redirect_uri="+mtw_domain_name+"/mtw/extapi_callback_page/google_succ.jsp&response_type=token&client_id=977597429839-ts24lbumbsjfcsolh6og59sf52gng8m7.apps.googleusercontent.com");
		}
		function fackbooklogin(){
			//url="";
			//var winObj = window.open(url,'mtw','width=800,height=600,status=0,toolbar=0');
			commOpenWin("https://www.facebook.com/dialog/oauth?client_id=311843945816268&response_type=token&redirect_uri="+mtw_domain_name+"mtw/extapi_callback_page/facebook_succ.jsp");
		}
		function vklogin(){
			//url="";
			//var winObj = window.open(url,'mtw','width=800,height=600,status=0,toolbar=0');
			commOpenWin("https://oauth.vk.com/authorize?client_id=5491468&scope=offline&redirect_uri="+mtw_domain_name+"mtw/extapi_callback_page/vk_succ.jsp&response_type=token");
		}
		function lineLogin(){
			//var winObj = window.open(url,'mtw','width=800,height=600,status=0,toolbar=0');
			commOpenWin("https://access.line.me/dialog/oauth/weblogin?response_type=code&client_id=1469691890&redirect_uri="+mtw_domain_name+"mtw/extapi_callback_page/line_succ.jsp&state=123abc");
		}
		function refreshfPage(code){
				if(code=='0')
					mtwAlert("<%=lang.getString("mtwhome.api.tip.connectTimeOut")%>");//网络超时
				if(code=='1')
					mtwAlert("<%=lang.getString("sns.server.incoming.parameter.error")%>");//无效参数
				if(code=='2')
					mtwAlert("<%=lang.getString("mtwhome.api.tip.getUserInfo_error")%>");//获取用户资料失败
				else
					window.location.reload();
		};
		
		// SinaWeibo
		function OpenSinaWeiboLogin(){
			commOpenWin("https://api.weibo.com/oauth2/authorize?client_id=3170462830&redirect_uri="+mtw_domain_name+"mtw/extapi_callback_page/sina_succ.html&response_type=code&state=&scope=all");
			//var winObj = window.open('https://api.weibo.com/oauth2/authorize?client_id=665854899&redirect_uri='+mtw_domain_name+'mtw/extapi_callback_page/sina_succ.html&response_type=code&state=&scope=all','mtw','width=800,height=600,status=0,toolbar=0');
			/*
			var loop = setInterval(function() {     
				if(winObj.closed) {
					clearInterval(loop);
					alert('closed');
				}    
			}, 1000);
			*/
		};
		function SinaWeiboLoginCallback(code){
			location.href = "${ctx}/sgmtw/extApi/SinaWeiboLoginSucc?code="+code;
		};
		
		
		// QQ
		function OpenQQLogin(){
			commOpenWin("https://graph.qq.com/oauth/show?which=Login&display=pc&client_id=101369525&response_type=token&scope=all&redirect_uri=http%3A%2F%2Fwww.mytotalworld.com%2Fmtw%2Fextapi_callback_page%2Fqqsucc.html");
			//var winObj = window.open('https://graph.qq.com/oauth/show?which=Login&display=pc&client_id=101326641&response_type=token&scope=all&redirect_uri=http%3A%2F%2Fwww.3597.com.cn%2Fqqsucc.html','mtw','width=800,height=600,status=0,toolbar=0');
		};
		function QQLoginCallback(openId, accessToken){
			location.href = "${ctx}/sgmtw/extApi/QQLogin?access_token="+accessToken+"&openId="+openId+"&key=101369525";
		};
		
		
		// WX
		function OpenWXLogin(){
			commOpenWin("https://open.weixin.qq.com/connect/qrconnect?appid=wx7bde95ad79c82865&redirect_uri=http%3A%2F%2Fwww.mytotalworld.com&response_type=code&state=wxe405cbd011a77fbb98698&scope=snsapi_login#wechat_redirect");
			//window.open('https://open.weixin.qq.com/connect/qrconnect?appid=wxe405cbd011a77fbb&redirect_uri=http%3A%2F%2Fwww.3597.com.cn&response_type=code&state=wxe405cbd011a77fbb98698&scope=snsapi_login#wechat_redirect','mtw','width=800,height=600,status=0,toolbar=0');
			//location.href="${ctx}/sgmtw/extApi/WXLogin?code=031XAYwP11ulEX0O13xP1I8XwP1XAYw3&key=wxe405cbd011a77fbb&st=3b2ee72e9b84a54d33ed46ce09acc66e";
		};
		function QueryString()
		{
			var name,value,i;
			var str=location.href;
			var num=str.indexOf("?")
			str=str.substr(num+1);
			var arrtmp=str.split("&");
			for(i=0;i < arrtmp.length;i++)
			{
				num=arrtmp[i].indexOf("=");
				if(num>0)
				{
					name=arrtmp[i].substring(0,num);
					value=arrtmp[i].substr(num+1);
					this[name]=value;
				}
			}
		};
		var query=new QueryString();
		var state = query["state"];
		if(typeof(state)!="undefined"){
		    if(state=='wxe405cbd011a77fbb98698'){
			  var code = query["code"];
			  if(typeof(code)!="undefined"){
				window.opener.WXLoginCallback(code);
			  }
			  close();
			}
		}
		function WXLoginCallback(code){
			location.href="${ctx}/sgmtw/extApi/WXLogin?code="+code+"&key=wx7bde95ad79c82865&st=d21d57c143e36365f98fef1e8fc8dbb1";
		};
		
		// Linkedin
		function OpenLinked(){
			//commOpenWin("https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=75g7ujy3vvvxiw&redirect_uri="+mtw_domain_name+"sgmtw/extApi/LinkedLoginSucc&state=11");
			commOpenWin("https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=75g7ujy3vvvxiw&state=11&redirect_uri="+mtw_domain_name+"sgmtw/extApi/LinkedLoginSucc");
			//window.open("",'mtw','width=800,height=600,status=0,toolbar=0');
		};
		
		function commOpenWin(url){
			var openUrl = "";//弹出窗口的url
			var iWidth=700; //弹出窗口的宽度;
			var iHeight=700; //弹出窗口的高度;
			var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
			var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
			window.open(url,"","height="+iHeight+", width="+iWidth+", top="+iTop+", left="+iLeft);
		};
		
		
		function urlParam(paraname){
			var reg = new RegExp("(^|&)" + paraname + "=([^&]*)(&|$)", "i"); 
			var r = window.location.search.substr(1).match(reg); 
			if (r != null) return unescape(r[2]); return null; 
		};
		var sog = urlParam("sog");
		var sc = urlParam("sc");
		if(sog==1 && sc!='' && sc!=null) {
			slogin();
		};
		function slogin(){
			$.ajax({  
		        type : "post",  
		        async:false,  
		        url : "${SSO_PROJECT_URL}/casThirdLogin",  
		        dataType : "jsonp",//数据类型为jsonp
		        data : {ak:urlParam("ak"),sc:sc,l:urlParam("l"),so_url:"${PLATFORM_INDEX_URL}"},
		        jsonp: "jsonpCallback",//服务端用于接收callback调用的function名的参数  
		        success : function(data){  
		            //alert(data.success);//true,false
		            location.href = "${PLATFORM_INDEX_URL}";
		        },  
		        error:function(){  
		            //alert('fail');  
		        }
		    });
		};
		
		
		</script>
	</body>
</html>
