﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>合约报价- <%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/PMS/CSS.aspx"-->
<link href="<%=MinifyUrl("FormCss")%>" rel="stylesheet" type="text/css" />
</head>
<body code="">

<link href="city/css/cityLayout.css" type="text/css" rel="stylesheet">
    <style>
        .FormTable > tbody > tr > td { width:9.09% !important;}
        /*.areaTable .province .city_input {
           width:100% !important;
           background-size:100% 29px !important;
        }*/
        .num.active .btn,ul .active a{border-top:2px solid #DF771E !important; color:#888 !important;}
        .num .btn:hover,.title1 li a:hover,.ld a.btn:hover{border-top:2px solid #DF771E !important; color:#888 !important;}
        .num .selectCarr {width: 80px !important;border:1px solid #ddd;}
        .tab-pane{display:none;}
        .tab-pane.active{display: table-row-group;}
        .ld a,.title1 a{color:#888;}
        .num.active .selectpicker a{border:0px !important;}
        .title1 a.btn{background:#eee;width:82px;}
        .ld a.btn{border: 1px solid #ddd;}
        .num .bootstrap-select,.ld input[name="From"]{height:32px;margin-top:0;}
        .list-inline > li {padding-right:0;}
        /*.tab-pane .backgroundGray{ position:relative;}*/
        .tab-pane .backgroundGray input { position:relative;}
        .tab-pane .backgroundGray p {position:absolute; top:3px; left:8px; line-height:28px; color:#888;}
        .tab-pane .backgroundGray p span {margin-left:5px; color:#09c;}
        .btn.focus, .btn:focus, .btn:hover { box-shadow:none;}
        .tips {background-color:#F9CD9C !important; color:#333 !important; border:0 !important;height:30px !important;}
        .f {
            width: 306px;
            height: 35px;
            position: relative;
            background-color:transparent;
        }

            .f:before {
                position: absolute;
                top: 0px;
                right: 0;
                left: 0;
                bottom: 0;
                border-bottom: 35px solid #666;
                border-right: 306px solid transparent;
                content: "";
            }

            .f:after {
                position: absolute;
                left: 0;
                right: 1px;
                top: 1px;
                bottom: 0;
                border-bottom: 34px solid rgb(242,242,242);
                border-right: 305px solid transparent;
                content: "";
            }
        .blText {position:absolute; bottom:3px; left:8px; color:#666; }
        .trText {position:absolute; top:3px; right:8px; color:#666;}
        .signArea {float:left; margin-top:7px;position:absolute;}
        input[name="Max"] {float:right;width:88% !important;}
        .bootstrap-select.btn-group .btn .filter-option {
            color: #666;
        }
        .ld .filter-option{color:#888;}
		.ld .proCitySelAll{border:1px solid #ddd !important;}
        .relativeDiv{position:relative;}
        .province .city_input {
            margin-top:0;
        }
    </style>
<!-- 通用对话框开始-->
<div class="modal fade text-center" id="win-Common-Dialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-body">
				<div class="content">
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 通用对话框结尾 -->
    <div class="modal fade" id="ClosedModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                    <%--<button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>--%>
                    <h4 class="modal-title text-left" id="H1">
                        <div style="padding-left: 3px; background-color: #f27302;">
                            <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">审核报价单</p>
                        </div>
                    </h4>
                </div>
                <div style="position:relative; padding:20px;">
                    <div class="row">
                        <label class="col-md-2 control-Label" style="color:#333;">说明</label>
                        <div class="col-md-10">
                            <textarea name="CDescription" class="form-control" rows="3" cols="70"></textarea>
                            <input type="hidden" name="Op" />
                            <input type="hidden" name="DocID" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
					<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="VerifyDoc()" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
					<button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
<!-- 通用对话框开始1-->
<div class="modal fade text-center" id="CarType_Length" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" style="width:auto;display: inline-block;">
        <div class="modal-content">
			<div class="modal-header" style="padding: 5px 10px;">
			</div>
            <div class="" style="padding:20px;position:relative">
                <div class="content">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 通用对话框1结尾 -->
<!-- 通用对话框2开始 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                    <%--<button type="button" class="close"
                        data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>--%>

                    <h4 class="modal-title text-left" id="myModalLabel">
                        <div style="padding-left: 3px; background-color: #f27302;">
                            <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">发送报价单</p>
                            <input type="hidden"  name="DocID"/>
                        </div>
                    </h4>
                </div>
                <div class="modal-body">
                    是否确定发送报价单
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
                    <button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="SendDoc()"><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left: 2px;"></span></button>
                    <button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left: 2px; color: #888;"></span></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
<!-- 通用对话框2结尾 -->
<!--通用头部文件开始-->
<!--#include file="/Controls/PMS/header.aspx"-->
<!--通用头部文件结尾-->
<div class="formcontainer" style="display:none;">
<!-- 表单开始-->
<script language="javascript">
    var __saveNdtCfg = '{"main":{"insertVml":"pml_0008","updateVml":"pml_0008","queryVml":"pml_0027"},"PMS_LessLoad":{"insertVml":"pml_0010","updateVml":"pml_0010","queryVml":"pml_0020","deleteVml":"pml_0018"},"PMS_FullLoad":{"insertVml":"pml_0012","updateVml":"pml_0012","queryVml":"city_fullload_query","deleteVml":"pml_0018"},"CityPickPrice":{"insertVml":"pml_0011","updateVml":"pml_0011","queryVml":"city_pick_query","deleteVml":"pml_0018"}' +
    ',"CityDeliveryPrice":{"insertVml":"pml_0013","updateVml":"pml_0013","queryVml":"city_delivery_query","deleteVml":"pml_0018"},"LoadPrice2":{"insertVml":"pml_0015","updateVml":"pml_0015","queryVml":"city_load_query","deleteVml":"pml_0018"},"MinPrice":{"insertVml":"pml_0016","updateVml":"pml_0016","queryVml":"city_min_query","deleteVml":"pml_0018"}' +
    ',"InsurancePrice":{"insertVml":"pml_0017","updateVml":"pml_0017","queryVml":"city_insurance_query","deleteVml":"pml_0018"},"TaxPrice":{"insertVml":"pml_0028","updateVml":"pml_0028","queryVml":"city_tax_query","deleteVml":"pml_0018"}}';
</script><!--  -->
 <table class="FormTable Y_alter areaTable" style="width:100%;" id="25ccf24c-9c73-44a5-899b-2565511d81d0" path="Price/qksbgqsk" code="qksbgqsk">
  <colgroup>
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width: 120px;">
    <col style="width:120px;">
  </colgroup>
  <tbody>
    <tr class="td-container tr-fixed" style="">
        <td class="text-left" rowspan="1" colspan="4" style="font-size: 14px; border: 0; border-bottom: 1px solid #e1e6eb; padding-right: 0; padding-left: 0;width:100% !important">
        <div style="padding-top:20px;" >
                <div style="padding-left: 3px; background-color: #f27302;">
                    <p style="background-color: white; padding-left: 8px; height: 20px; line-height: 20px; margin-bottom: 25px;">合约报价</p>
                </div>
            </div>
        </td>
       
      <td colspan="5" style="border: 0;">
        <input type="hidden" name="id">
        <div class="toolbar">
          <div style="text-align:right;" class="button_workflow">
              <a class="btn btn-red footKeepBtn agreenBtn" href="javascript:void(0);" onclick="VerifyDocOk()" style="display: inline-block;">同意&nbsp;<span class="glyphicon glyphicon-ok-sign"></span></a>
              <a class="btn btn-red noBtn" href="javascript:void(0);" onclick="VerifyDocNo()" style="display: inline-block;">拒绝&nbsp;<span class="glyphicon glyphicon-thumbs-down"></span></a>
              <a class="btn btn-red hide footKeepBtn copy" " >复制&nbsp;<span class="glyphicon glyphicon-copyright-mark"></span></a>
              <a class="btn btn-red" href="javascript:void(0);" onclick="back()">返回&nbsp;<span class="glyphicon glyphicon-share-alt"></span></a>
          </div>
          <div class="clear"></div>
          <div class="content_workflow"></div>
        </div>
      </td>
    </tr>
      <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 64px;"></td>
    </tr>
    <tr style="height: 26px;">
      <td class="" style="background-color: rgb(242, 242, 242);width:100px !important;">报价单名</td>
      <td class="" rowspan="1" colspan="4">
        <input name="Name" class="edit form-control transparent" readonly f-options="{'code':'Name','type':'text','etype':'','len':''}" verify="{'title':'Name','length':'','required':true}">
		<input type="hidden" name="DocID" value=0 />
	  </td>
      <td class="" style="background-color: rgb(242, 242, 242);">合同编码</td>
      <td class="" rowspan="1" colspan="4">
        <input name="PactCode" readonly class="edit form-control transparent" f-options="{'code':'PactCode','type':'text','etype':'','len':''}" verify="{'title':'PactCode','length':'','required':true}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="td_name" style="background-color: rgb(242, 242, 242);width:100px !important;">
          <span>
             客户
			 <input type="hidden" name="CustomerID" value="0" />
            </span>
      </td>
      <td class="" rowspan="1" colspan="9">
         <input name="CustomerName" placeholder="点击“客户”进行选择" readonly class="edit form-control transparent" f-options="{'code':'CustomerName','type':'text','etype':'editable','len':'50'}" verify="{'title':'CustomerName','length':'50','required':true}">
      </td>
    </tr>
    <tr style="height: 26px;">
      <td class="" style="background-color: rgb(242, 242, 242);width:100px !important;">合约起始时间</td>
      <td class="" rowspan="1" colspan="4">
        <input name="StartTime" disabled class="laydate-icon edit" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD' } )" f-options="{'code':'StartTime','type':'date','etype':'','len':''}" verify="{'title':'StartTime','length':'','required':true}">
      </td>
      <td class="" style="background-color: rgb(242, 242, 242);">合约结束时间</td>
      <td class="" rowspan="1" colspan="4">
        <input name="EndTime" disabled class="laydate-icon edit" onclick="TrigerDateEvent( this, { format: 'YYYY-MM-DD', min: $('input[name=\'StartTime\']').val() } )" f-options="{'code':'EndTime','type':'date','etype':'','len':''}" verify="{'title':'EndTime','length':'','required':true}">
      </td>
    </tr>
    <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
    <tr>
    	<td class="" colspan="10" style="border: 0px;border-bottom: 1px solid #ddd;padding-left:5px;">
    		<ul class="list-inline title1" style="margin-bottom: 15px;" role="tablist">
    			<li role="presentation" class="active"><a class="btn " href="javascript:void(0)" aria-controls="PMS_LessLoad" role="tab" data-toggle="tab">零担</a></li>
    			<li role="presentation"><a class="btn " href="javascript:void(0)" aria-controls="PMS_FullLoad" role="tab" data-toggle="tab">整车</a></li>
    			<li role="presentation"><a class="btn " href="javascript:void(0)" aria-controls="CityPickPrice" role="tab" data-toggle="tab">提货费</a></li>
    			<li role="presentation"><a class="btn " href="javascript:void(0)" aria-controls="CityDeliveryPrice" role="tab" data-toggle="tab">送货费</a></li>
    			<li role="presentation"><a class="btn " href="javascript:void(0)" aria-controls="LoadPrice2" role="tab" data-toggle="tab">装卸费</a></li>
    			<li role="presentation"><a class="btn " href="javascript:void(0)" aria-controls="MinPrice" role="tab" data-toggle="tab">最低收费</a></li>
    			<li role="presentation"><a class="btn " href="javascript:void(0)" aria-controls="InsurancePrice" role="tab" data-toggle="tab">保险费</a></li>
    			<li role="presentation"><a class="btn " href="javascript:void(0)" aria-controls="TaxPrice" role="tab" data-toggle="tab">税费</a></li>
    		</ul>
    	</td>
    </tr>
    </tbody>
    <tbody id="PMS_LessLoad" role="tab" class="tab-pane active">
    	<tr class="insert">
    		<td colspan="10" style="border: 0px;border-bottom: 1px solid #ddd;padding-left:5px;">
				<ul class="list-inline ld" style="margin-bottom: 15px;" role="tablist1">
	    			<li role="presentation" class="active"><a class="btn " href="javascript:void(0)" aria-controls="KG" role="tab" data-toggle="tab">重量/公斤</a></li>
	    			<li role="presentation"><a class="btn " href="javascript:void(0)" aria-controls="Ton" role="tab" data-toggle="tab">重量/吨</a></li>
	    			<li role="presentation"><a class="btn " href="javascript:void(0)" aria-controls="CMetre" role="tab" data-toggle="tab">体积/立方米</a></li>
	    			<li role="presentation"><a class="btn " href="javascript:void(0)" aria-controls="Square" role="tab" data-toggle="tab">体积/升</a></li>
	    			<li class="num" role="tab" data-toggle="tab" aria-controls="num" >
                        <a class="hide" role="tab" data-toggle="tab" aria-controls="num"></a>                        
                        <input type="hidden" name="Unit"> 
                        <select name="Unit_id" class="edit transparent selectCarr show-tick form-control" data-live-search="true"  f-options="{'code':'','type':'combobox','etype':'','len':''}" verify="{'title':'','length':'','textarea1':true}" style="display: none;">
    		                  <option value="">数量</option>
    		                  <option value="5">个</option>
    		                  <option value="6">托</option>
    		                  <option value="7">台</option>
                          <option value="8">箱</option>
                          <option value="9">包</option>
                          <option value="10">捆</option>
                          <option value="11">辆</option>
                          <option value="12">件</option>
                          <option value="13">袋</option>
                          <option value="14">架</option>
                          <option value="15">盒</option>
                          <option value="16">桶</option>
                          <option value="17">其它</option>
		                </select>
	    			</li>
	    			<li class="province">    
                        <span style="margin-left:5px;">起点城市:</span>                    
                        <input name="From" type="text" readonly="" value="请选择起点城市" class="city_input inputFocus proCitySelAll" style="border:1px solid #bbb">
                        <input name="FromProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'FromProvince','type':'text','etype':'','len':''}" verify="" value="">
                        <input name="FromCity" type="hidden" class="edit form-control transparent" f-options="{'code':'FromCity','type':'text','etype':'','len':''}" verify="" value="">   
                        <input name="FromDistrict" type="hidden" class="edit form-control transparent" f-options="{'code':'FromDistrict','type':'text','etype':'','len':''}" verify="" value="">               
                          <div class="provinceCityAll">
                              <div class="tabs clearfix">
                                <ul class="">
                                  <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                                  <li><a href="javascript:" tb="provinceAll">省份</a></li>
                                  <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                                  <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                                </ul>
                              </div>
                              <div class="con">
                            <div class="hotCityAll invis">
                              <div class="pre"><a></a></div>
                              <div class="list">
                                <ul>
                                  <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                                </ul>
                              </div>
                              <div class="next"><a class="can"></a></div>
                            </div>
                            <div class="provinceAll invis">
                              <div class="pre"><a onclick="provinceAllPre()"></a></div>
                              <div class="list">
                                <ul>
                                  <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                                </ul>
                              </div>
                              <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                            </div>
                            <div class="cityAll invis">
                              <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                              <div class="list">
                                <ul>
                                  <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                                </ul>
                              </div>
                              <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                            </div>
                            <div class="countyAll invis">
                              <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                              <div class="list">
                                <ul>
                                </ul>
                              </div>
                              <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                            </div>
                          </div>
                        </div>
	    			</li>
	    		</ul>
    		</td>
    	</tr>
        <tr><td colspan="10" class="tips">提示：只需填写区间最大值</td></tr>
        <tr>
            <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
        </tr>
        <tr style="height: 26px;" class="select hide">
          <td class="backgroundGray" colspan="2">起点省市</td>
          <td class="backgroundGray" colspan="2">目的省市</td>
          <td class="backgroundGray" colspan="2">单位类型</td>
          <td class="backgroundGray">单位</td>
          <td class="backgroundGray">最小体积或重量(≥)</td>
          <td class="backgroundGray">最大体积或重量(＜)</td>
          <td class="backgroundGray">价格（RMB/元）</td>
        </tr>
        
    </tbody>
    <!-- 零担下属内容 -->
    <tbody id="KG" role="tab1" class="tab-pane active">
        <tr>
            <td class="backgroundGray slashTd" colspan="2" style="padding:0;"><div class="relativeDiv"><div class="f"></div><span class="blText">目的城市</span><span class="trText">区间值</span></div></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray">
                <a href="javascript:void(0);" onclick="add(this)" name="add" class="button edit">新增</a>
            </td>
        </tr>
        <tr class="hide" style="height: 26px;">
            <td colspan="2" class="province">
                <input name="ToName" type="text" readonly placeholder="请选择目的城市" class="city_input inputFocus proCitySelAll"/>
                <input name="ToProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'ToProvince','type':'text','etype':'','len':''}" verify="">
                <input name="ToCity" type="hidden" class="edit form-control transparent" f-options="{'code':'ToCity','type':'text','etype':'','len':''}" verify="">
                <input name="ToDistrict" type="hidden" class="edit form-control transparent" f-options="{'code':'ToDistrict','type':'text','etype':'','len':''}" verify="">                                  
                  <div class="provinceCityAll">
                      <div class="tabs clearfix">
                        <ul class="">
                          <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                          <li><a href="javascript:" tb="provinceAll">省份</a></li>
                          <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                          <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                        </ul>
                      </div>
                      <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div>
            </td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent hotKey" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td class="">
                <a href="javascript:void(0);" class="button edit" onclick="DelPrice(this, 'pml_0018')">删除</a>
                <a href="javascript:void(0);" class="button edit copy " onclick="CopyDoc(this)">复制</a>
            </td>
        </tr>
        <tr class="" style="height: 26px;">
            <td colspan="2" class="province">
                <input name="ToName" type="text" readonly placeholder="请选择目的城市" class="city_input inputFocus proCitySelAll"/>
                <input name="ToProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'ToProvince','type':'text','etype':'','len':''}" verify="">
                <input name="ToCity" type="hidden" class="edit form-control transparent" f-options="{'code':'ToCity','type':'text','etype':'','len':''}" verify="">
                <input name="ToDistrict" type="hidden" class="edit form-control transparent" f-options="{'code':'ToDistrict','type':'text','etype':'','len':''}" verify="">                                  
                  <div class="provinceCityAll">
                      <div class="tabs clearfix">
                        <ul class="">
                          <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                          <li><a href="javascript:" tb="provinceAll">省份</a></li>
                          <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                          <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                        </ul>
                      </div>
                      <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div>
            </td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent hotKey" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td class="">
                <a href="javascript:void(0);" class="button edit" onclick="DelPrice(this, 'pml_0018')">删除</a>
                <a href="javascript:void(0);" class="button edit copy " onclick="CopyDoc(this)">复制</a>
            </td>
        </tr>
    </tbody>
    <tbody id="Ton" role="tab1" class="tab-pane">
        <tr>
            <td class="backgroundGray slashTd" colspan="2" style="padding:0;"><div class="relativeDiv"><div class="f"></div><span class="blText">目的城市</span><span class="trText">区间值</span></div></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray">
                <a href="javascript:void(0);" onclick="add(this)" name="add" class="button edit" >新增</a>
            </td>
        </tr>
        <tr class="hide" style="height: 26px;">
            <td colspan="2" class="province">                
                <input name="ToName" type="text" readonly placeholder="请选择目的城市" class="city_input inputFocus proCitySelAll"/>
                <input name="ToProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'ToProvince','type':'text','etype':'','len':''}" verify="">
                <input name="ToCity" type="hidden" class="edit form-control transparent" f-options="{'code':'ToCity','type':'text','etype':'','len':''}" verify="">
                <input name="ToDistrict" type="hidden" class="edit form-control transparent" f-options="{'code':'ToDistrict','type':'text','etype':'','len':''}" verify="">                                  
                  <div class="provinceCityAll">
                      <div class="tabs clearfix">
                        <ul class="">
                          <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                          <li><a href="javascript:" tb="provinceAll">省份</a></li>
                          <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                          <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                        </ul>
                      </div>
                      <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div>
            </td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent hotKey" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td class="">
                <a href="javascript:void(0);" class="button edit" onclick="DelPrice(this, 'pml_0018')">删除</a>
                <a href="javascript:void(0);" class="button edit copy " onclick="CopyDoc(this)">复制</a>
            </td>
        </tr>
        <tr class="" style="height: 26px;">
            <td colspan="2" class="province">
                <input name="ToName" type="text" readonly placeholder="请选择目的城市" class="city_input inputFocus proCitySelAll"/>
                <input name="ToProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'ToProvince','type':'text','etype':'','len':''}" verify="">
                <input name="ToCity" type="hidden" class="edit form-control transparent" f-options="{'code':'ToCity','type':'text','etype':'','len':''}" verify="">                 
                <input name="ToDistrict" type="hidden" class="edit form-control transparent" f-options="{'code':'ToDistrict','type':'text','etype':'','len':''}" verify="">  
                <div class="provinceCityAll">
                      <div class="tabs clearfix">
                        <ul class="">
                          <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                          <li><a href="javascript:" tb="provinceAll">省份</a></li>
                          <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                          <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                        </ul>
                      </div>
                      <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div>
            </td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent hotKey" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td class="">
                <a href="javascript:void(0);" tar="PMS_LessLoad" class="button edit" onclick="DelPrice(this, 'pml_0018')" f-options="{'code':'','type':'_button','etype':'','len':''}" verify="{'title':'','length':'','textarea1':true}">删除</a>
            	<a href="javascript:void(0);" class="button edit copy " onclick="CopyDoc(this)">复制</a>
            </td>
        </tr>
        
    </tbody>
    <tbody id="CMetre" role="tab1" class="tab-pane">
        <tr>
            <td class="backgroundGray slashTd" colspan="2" style="padding:0;"><div class="relativeDiv"><div class="f"></div><span class="blText">目的城市</span><span class="trText">区间值</span></div></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray">
                <a href="javascript:void(0);" onclick="add(this)" name="add" class="button edit">新增</a>
            </td>
        </tr>
        <tr class="hide" style="height: 26px;">
            <td colspan="2" class="province">                
                <input name="ToName" type="text" readonly placeholder="请选择目的城市" class="city_input inputFocus proCitySelAll"/>
                <input name="ToProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'ToProvince','type':'text','etype':'','len':''}" verify="">
                <input name="ToCity" type="hidden" class="edit form-control transparent" f-options="{'code':'ToCity','type':'text','etype':'','len':''}" verify="">
                <input name="ToDistrict" type="hidden" class="edit form-control transparent" f-options="{'code':'ToDistrict','type':'text','etype':'','len':''}" verify="">                                  
                  <div class="provinceCityAll">
                      <div class="tabs clearfix">
                        <ul class="">
                          <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                          <li><a href="javascript:" tb="provinceAll">省份</a></li>
                          <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                          <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                        </ul>
                      </div>
                      <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div>
            </td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent hotKey" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td class="">
                <a href="javascript:void(0);" class="button edit" onclick="DelPrice(this, 'pml_0018')">删除</a>
                <a href="javascript:void(0);" class="button edit copy " onclick="CopyDoc(this)">复制</a>
            </td>
        </tr>
        <tr class="" style="height: 26px;">
            <td colspan="2" class="province">
                <input name="ToName" type="text" readonly placeholder="请选择目的城市" class="city_input inputFocus proCitySelAll"/>
                <input name="ToProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'ToProvince','type':'text','etype':'','len':''}" verify="">
                <input name="ToCity" type="hidden" class="edit form-control transparent" f-options="{'code':'ToCity','type':'text','etype':'','len':''}" verify="">                 
                <input name="ToDistrict" type="hidden" class="edit form-control transparent" f-options="{'code':'ToDistrict','type':'text','etype':'','len':''}" verify="">  
                <div class="provinceCityAll">
                      <div class="tabs clearfix">
                        <ul class="">
                          <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                          <li><a href="javascript:" tb="provinceAll">省份</a></li>
                          <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                          <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                        </ul>
                      </div>
                      <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div>
            </td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent hotKey" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td class="">
                <a href="javascript:void(0);" tar="PMS_LessLoad" class="button edit" onclick="DelPrice(this, 'pml_0018')" f-options="{'code':'','type':'_button','etype':'','len':''}" verify="{'title':'','length':'','textarea1':true}">删除</a>
            	<a href="javascript:void(0);" class="button edit copy " onclick="CopyDoc(this)">复制</a>
            </td>
        </tr>
    </tbody>
    <tbody id="Square" role="tab1" class="tab-pane">
        <tr>
            <td class="backgroundGray slashTd" colspan="2" style="padding:0;"><div class="relativeDiv"><div class="f"></div><span class="blText">目的城市</span><span class="trText">区间值</span></div></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray">
                <a href="javascript:void(0);" onclick="add(this)" name="add" class="button edit">新增</a>
            </td>
        </tr>
        <tr class="hide" style="height: 26px;">
            <td colspan="2" class="province">                
                <input name="ToName" type="text" readonly placeholder="请选择目的城市" class="city_input inputFocus proCitySelAll"/>
                <input name="ToProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'ToProvince','type':'text','etype':'','len':''}" verify="">
                <input name="ToCity" type="hidden" class="edit form-control transparent" f-options="{'code':'ToCity','type':'text','etype':'','len':''}" verify="">
                <input name="ToDistrict" type="hidden" class="edit form-control transparent" f-options="{'code':'ToDistrict','type':'text','etype':'','len':''}" verify="">                                  
                  <div class="provinceCityAll">
                      <div class="tabs clearfix">
                        <ul class="">
                          <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                          <li><a href="javascript:" tb="provinceAll">省份</a></li>
                          <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                          <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                        </ul>
                      </div>
                      <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div>
            </td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent hotKey" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td class="">
                <a href="javascript:void(0);" class="button edit" onclick="DelPrice(this, 'pml_0018')">删除</a>
                <a href="javascript:void(0);" class="button edit copy " onclick="CopyDoc(this)">复制</a>
            </td>
        </tr>
        <tr class="" style="height: 26px;">
            <td colspan="2" class="province">
                <input name="ToName" type="text" readonly placeholder="请选择目的城市" class="city_input inputFocus proCitySelAll"/>
                <input name="ToProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'ToProvince','type':'text','etype':'','len':''}" verify="">
                <input name="ToCity" type="hidden" class="edit form-control transparent" f-options="{'code':'ToCity','type':'text','etype':'','len':''}" verify="">                 
                <input name="ToDistrict" type="hidden" class="edit form-control transparent" f-options="{'code':'ToDistrict','type':'text','etype':'','len':''}" verify="">  
                <div class="provinceCityAll">
                      <div class="tabs clearfix">
                        <ul class="">
                          <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                          <li><a href="javascript:" tb="provinceAll">省份</a></li>
                          <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                          <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                        </ul>
                      </div>
                      <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div>
            </td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent hotKey" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td class="">
                <a href="javascript:void(0);" tar="PMS_LessLoad" class="button edit" onclick="DelPrice(this, 'pml_0018')" f-options="{'code':'','type':'_button','etype':'','len':''}" verify="{'title':'','length':'','textarea1':true}">删除</a>
            	<a href="javascript:void(0);" class="button edit copy " onclick="CopyDoc(this)">复制</a>
            </td>
        </tr>
    </tbody>
    <tbody id="num" role="tab1" class="tab-pane">
        <tr>
            <td class="backgroundGray slashTd" colspan="2" style="padding:0;"><div class="relativeDiv"><div class="f"></div><span class="blText">目的城市</span><span class="trText">区间值</span></div></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray"><input type="text" onkeyup="value=value.replace(/[^\d.]/g,'')" name="Max" class="edit form-control transparent" placeholder="0.00"/><span class="signArea"><</span></td>
            <td class="backgroundGray">
                <a href="javascript:void(0);" onclick="add(this)" name="add" class="button edit">新增</a>
            </td>
        </tr>
        <tr class="hide" style="height: 26px;">
            <td colspan="2" class="province">                
                <input name="ToName" type="text" readonly placeholder="请选择目的城市" class="city_input inputFocus proCitySelAll"/>
                <input name="ToProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'ToProvince','type':'text','etype':'','len':''}" verify="">
                <input name="ToCity" type="hidden" class="edit form-control transparent" f-options="{'code':'ToCity','type':'text','etype':'','len':''}" verify="">
                <input name="ToDistrict" type="hidden" class="edit form-control transparent" f-options="{'code':'ToDistrict','type':'text','etype':'','len':''}" verify="">                                  
                  <div class="provinceCityAll">
                      <div class="tabs clearfix">
                        <ul class="">
                          <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                          <li><a href="javascript:" tb="provinceAll">省份</a></li>
                          <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                          <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                        </ul>
                      </div>
                      <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div>
            </td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent hotKey" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td class="">
                <a href="javascript:void(0);" class="button edit" onclick="DelPrice(this, 'pml_0018')">删除</a>
                <a href="javascript:void(0);" class="button edit copy " onclick="CopyDoc(this)">复制</a>
            </td>
        </tr>
        <tr class="" style="height: 26px;">
            <td colspan="2" class="province">
                <input name="ToName" type="text" readonly placeholder="请选择目的城市" class="city_input inputFocus proCitySelAll"/>
                <input name="ToProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'ToProvince','type':'text','etype':'','len':''}" verify="">
                <input name="ToCity" type="hidden" class="edit form-control transparent" f-options="{'code':'ToCity','type':'text','etype':'','len':''}" verify="">                 
                <input name="ToDistrict" type="hidden" class="edit form-control transparent" f-options="{'code':'ToDistrict','type':'text','etype':'','len':''}" verify="">  
                <div class="provinceCityAll">
                      <div class="tabs clearfix">
                        <ul class="">
                          <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                          <li><a href="javascript:" tb="provinceAll">省份</a></li>
                          <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                          <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                        </ul>
                      </div>
                      <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div>
            </td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td><input name="Price" onkeyup="value=value.replace(/[^\d.]/g,'')" class="edit form-control transparent hotKey" placeholder="请输入单价"/><input type="hidden" name="DetailID" value="0"></td>
            <td class="">
                <a href="javascript:void(0);" tar="PMS_LessLoad" class="button edit" onclick="DelPrice(this, 'pml_0018')" f-options="{'code':'','type':'_button','etype':'','len':''}" verify="{'title':'','length':'','textarea1':true}">删除</a>
            	<a href="javascript:void(0);" class="button edit copy " onclick="CopyDoc(this)">复制</a>
            </td>
        </tr>
        
    </tbody>
     
    <!-- 零担同级 整车等 -->
    <tbody id="PMS_FullLoad" role="tab" class="tab-pane">
        <tr>
        <td rowspan="1" colspan="11" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
        <tr>
            <td class="backgroundGray" rowspan="1" colspan="3">起点省市区</td>
            <td class="province setOff" rowspan="1" colspan="7">			    
                <input name="FromName" type="text" readonly placeholder="请选择起点省市区" class="city_input inputFocus proCitySelAll"/>
                <input name="FromProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'FromProvince','type':'text','etype':'','len':''}" verify="">
                <input name="FromCity" type="hidden" class="edit form-control transparent" f-options="{'code':'FromCity','type':'text','etype':'','len':''}" verify="">                 
                <div class="provinceCityAll">
                  <div class="tabs clearfix">
                    <ul class="">
                      <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                      <li><a href="javascript:" tb="provinceAll">省份</a></li>
                      <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                      <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                    </ul>
                  </div>
                  <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div>            
          </td>
        </tr>
        <tr>
            <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
        </tr>
        <tr style="height: 26px;">          
          <td class="backgroundGray" rowspan="1" colspan="3">目的省市区</td>
          <td class="backgroundGray">车型</td>
          <td class="backgroundGray">规格/车长（米）</td>
          <td class="backgroundGray">容积（方）</td>
          <td class="backgroundGray">载重（吨）</td>
          <td class="backgroundGray">价格（RMB/元）</td>
          <td class="backgroundGray">备注</td>
          <td class="backgroundGray">
            <a href="javascript:void(0);" tar="PMS_FullLoad" name="add" class="button edit" executecode="%23add%23" f-options="{'code':'add','type':'_button','etype':'','len':''}" verify="{'title':'add','length':'','textarea1':true}">新增</a>
          </td>
        </tr>
        <tr style="height: 26px; display: none;" class="" fb-options="{'rowid':'PMS_FullLoad','initialRows':'','maxrows':'','content':''}" rowid="PMS_FullLoad">  
          <td class="province" rowspan="1" colspan="3">
              <input type="hidden" name="DetailID" value="0" />
              <input name="ToName" type="text" readonly placeholder="请选择目的省市区" class="city_input inputFocus proCitySelAll"/>
                <input name="ToProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'ToProvince','type':'text','etype':'','len':''}" verify="">
                <input name="ToCity" type="hidden" class="edit form-control transparent" f-options="{'code':'ToCity','type':'text','etype':'','len':''}" verify="">                 
                <div class="provinceCityAll">
                    <div class="tabs clearfix">
                    <ul class="">
                        <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                        <li><a href="javascript:" tb="provinceAll">省份</a></li>
                        <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                        <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                    </ul>
                    </div>
                    <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div> 
          </td>
          <td class="CarType">
            <input type="hidden" name="CarType" readonly value="0" class="edit form-control transparent">
            <input type="text" name="CarTypeName" placeholder="点击选择车型车长" onclick="showCarType_length( this )" readonly class="edit form-control transparent">
          </td>
          <td class="CarLength">
            <input type="hidden" name="CarLength" readonly class="edit form-control transparent">
            <input type="text" name="CarLengthName" readonly class="edit form-control transparent">
          </td>
          <td>
               <input type="text" name="CarVolume" readonly class="edit form-control transparent">
	      </td>
	      <td>
              <input type="text" name="CarWeight" readonly class="edit form-control transparent">
	      </td>
          <td class="">
            <input name="Price" class="edit form-control transparent onfocus" f-options="{'code':'Price','type':'number','etype':'','len':''}" verify="{'title':'Price','length':'','textarea1':true}">
          </td>
          <td class="">
            <input name="Description" class="edit form-control transparent onfocus" f-options="{'code':'Description','type':'text','etype':'','len':''}" verify="{'title':'Description','length':'','textarea1':true">
          </td>
          <td class="">
            <a href="javascript:void(0);" tar="PMS_FullLoad" class="button edit" onclick="DelPrice(this, 'pml_0018')" f-options="{'code':'','type':'_button','etype':'','len':''}" verify="{'title':'','length':'','textarea1':true}">删除</a>
          	<a href="javascript:void(0);" class="button edit copy " onclick="CopyDoc(this)">复制</a>
          </td>
          <td class="hide province">
                <input name="FromName" type="text" readonly placeholder="请选择起点省市" class="city_input inputFocus proCitySelAll" style="width: 280px !important;"/>
                <input name="FromProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'FromProvince','type':'text','etype':'','len':''}" verify="">
                <input name="FromCity" type="hidden" class="edit form-control transparent" f-options="{'code':'FromCity','type':'text','etype':'','len':''}" verify="">                 
          </td>
        </tr>        
    </tbody>
    <tr>
        <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
    </tr>
    <tbody id="CityPickPrice" role="tab" class="tab-pane">
        <tr style="height: 26px;">
          <td class="backgroundGray" rowspan="1">提货省/市/区县</td>
          <td class="backgroundGray" colspan="">单位类型&nbsp;&nbsp;&nbsp;</td>
          <td class="backgroundGray">单位</td>
          <td class="backgroundGray">最小体积或重量(≥)</td>
          <td class="backgroundGray">最大体积或重量(＜)</td>      
          <td class="backgroundGray" colspan="">车型</td>
          <td class="backgroundGray">规格/车长（米）</td>
          <td class="backgroundGray">容积（方）</td>
          <td class="backgroundGray">载重（吨）</td>
          <td class="backgroundGray">价格（RMB/元）</td>
        </tr>
        <tr style="height: 26px; display: none;" class="" fb-options="{'rowid':'CityPickPrice','initialRows':'','maxrows':'','content':''}" rowid="CityPickPrice">
          <td class="province" rowspan="1">
		    <input type="hidden" name="DetailID" value="0" />
              <input name="FromName" type="text" disabled placeholder="请选择目的城市" class="city_input inputFocus proCitySelAll"/>
                <input name="FromProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'FromProvince','type':'text','etype':'','len':''}" verify="">
                <input name="FromCity" type="hidden" class="edit form-control transparent" f-options="{'code':'FromCity','type':'text','etype':'','len':''}" verify="">  
                <input name="FromDistrict" type="hidden" class="edit form-control transparent" f-options="{'code':'FromDistrict','type':'text','etype':'','len':''}" verify="">               
              <div class="provinceCityAll">
                  <div class="tabs clearfix">
                    <ul class="">
                      <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                      <li><a href="javascript:" tb="provinceAll">省份</a></li>
                      <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                      <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                    </ul>
                  </div>
                  <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div>  
            
          </td>
         <td class="UnitType" colspan="">
            <input type="hidden" name="UnitType">
            <select name="UnitType_id" disabled class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);Unit(this)" f-options="{'code':'UnitType','type':'combobox','etype':'','len':''}" verify="{'title':'UnitType','length':'','textarea1':true}">
              <option value="">-------------------------</option>
              <option value="1">重量</option>
              <option value="2">体积</option>
              <option value="3">数量</option>
            </select>
          </td>
          <td class="Unit">
            <input type="hidden" name="Unit">     
            <select name="Unit_id" disabled class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);UnitType(this)" f-options="{'code':'Unit','type':'combobox','etype':'','len':''}" verify="{'title':'Unit','length':'','textarea1':true}">
              <option value="">-------------------------</option>
              <!--#include file="/Controls/Unit.aspx"-->
            </select>
          </td>
          <td class="">
            <input name="Min" readonly class="edit form-control transparent" f-options="{'code':'Min','type':'text','etype':'','len':''}" verify="{'title':'Min','length':'','textarea1':true}">
        </td>
          <td class="">
            <input name="Max" readonly class="edit form-control transparent" f-options="{'code':'Max','type':'text','etype':'','len':''}" verify="{'title':'Max','length':'','textarea1':true}">
        </td>
        <td class="CarType" colspan="">         
            <input type="hidden" name="CarType" readonly value="0" class="edit form-control transparent">
            <input type="text" disabled name="CarTypeName" placeholder="点击选择车型车长" onclick="showCarType_length( this )" readonly class="edit form-control transparent">
          </td>
          <td class="CarLength">       
            <input type="hidden" readonly  name="CarLength" readonly class="edit form-control transparent">
            <input type="text" name="CarLengthName" readonly class="edit form-control transparent">
          </td>
        <td>
               <input type="text" readonly name="CarVolume" readonly class="edit form-control transparent">
        </td>
        <td>
              <input type="text" readonly name="CarWeight" readonly class="edit form-control transparent">
        </td>
          <td class="">
            <input name="Price" readonly class="edit form-control transparent" f-options="{'code':'Price','type':'number','etype':'','len':''}" verify="{'title':'Price','length':'','textarea1':true}">
          </td>
        </tr>
        <tr>
            <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
        </tr>
    </tbody>
    <tbody id="CityDeliveryPrice" role="tab" class="tab-pane">
        <tr style="height: 26px;" class="" fb-options="{'rowid':'','initialRows':'','maxrows':'','content':''}">
          <td class="backgroundGray" rowspan="1">目的省/市/区县</td>
          <td class="backgroundGray" colspan="">单位类型</td>
          <td class="backgroundGray">单位</td>
          <td class="backgroundGray">最小体积或重量(≥)</td>
          <td class="backgroundGray">最大体积或重量(＜)</td>      
          <td class="backgroundGray" colspan="">车型</td>
          <td class="backgroundGray">规格/车长（米）</td>
          <td class="backgroundGray">容积（方）</td>
          <td class="backgroundGray">载重（吨）</td>
          <td class="backgroundGray">价格（RMB/元）</td>
        </tr>
        <tr style="height: 26px;display: none;" class="" fb-options="{'rowid':'CityDeliveryPrice ','initialRows':'','maxrows':'','content':''}" rowid="CityDeliveryPrice">
          <td class="province" rowspan="1">
		    <input type="hidden" name="DetailID" value="0" />
             <input name="ToName" type="text" disabled placeholder="请选择目的城市" class="city_input inputFocus proCitySelAll"/>
                <input name="ToProvince" type="hidden" class="edit form-control transparent" f-options="{'code':'ToProvince','type':'text','etype':'','len':''}" verify="">
                <input name="ToCity" type="hidden" class="edit form-control transparent" f-options="{'code':'ToCity','type':'text','etype':'','len':''}" verify="">  
                <input name="ToDistrict" type="hidden" class="edit form-control transparent" f-options="{'code':'ToDistrict','type':'text','etype':'','len':''}" verify="">               
              <div class="provinceCityAll">
                  <div class="tabs clearfix">
                    <ul class="">
                      <li><a href="javascript:" class="current" tb="hotCityAll">热门城市</a></li>
                      <li><a href="javascript:" tb="provinceAll">省份</a></li>
                      <li><a href="javascript:" tb="cityAll" class="city">城市</a></li>
                      <li><a href="javascript:" tb="countyAll" class="district">区县</a></li>
                    </ul>
                  </div>
                  <div class="con">
                    <div class="hotCityAll invis">
                      <div class="pre"><a></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can"></a></div>
                    </div>
                    <div class="provinceAll invis">
                      <div class="pre"><a onclick="provinceAllPre()"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                    </div>
                    <div class="cityAll invis">
                      <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                          <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                    </div>
                    <div class="countyAll invis">
                      <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                      <div class="list">
                        <ul>
                        </ul>
                      </div>
                      <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                    </div>
                  </div>
                </div>  
          </td>
          <td class="UnitType" colspan="">
            <input type="hidden" name="UnitType">
            <select name="UnitType_id" disabled class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);Unit(this)" f-options="{'code':'UnitType','type':'combobox','etype':'','len':''}" verify="{'title':'UnitType','length':'','textarea1':true}">
              <option value="">-------------------------</option>
              <option value="1">重量</option>
              <option value="2">体积</option>
              <option value="3">数量</option>
            </select>
          </td>
          <td class="Unit">
            <input type="hidden" name="Unit">     
            <select name="Unit_id" disabled class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);UnitType(this)" f-options="{'code':'Unit','type':'combobox','etype':'','len':''}" verify="{'title':'Unit','length':'','textarea1':true}">
              <option value="">-------------------------</option>
              <!--#include file="/Controls/Unit.aspx"-->
            </select>
          </td>
          <td class="">
            <input name="Min" readonly class="edit form-control transparent" f-options="{'code':'Min','type':'text','etype':'','len':''}" verify="{'title':'Min','length':'','textarea1':true}">
        </td>
          <td class="">
            <input name="Max" readonly class="edit form-control transparent" f-options="{'code':'Max','type':'text','etype':'','len':''}" verify="{'title':'Max','length':'','textarea1':true}">
        </td>
        <td class="CarType" colspan="">         
            <input type="hidden" name="CarType" readonly value="0" class="edit form-control transparent">
            <input type="text" disabled name="CarTypeName" placeholder="点击选择车型车长" onclick="showCarType_length( this )" readonly class="edit form-control transparent">
          </td>
          <td class="CarLength">       
            <input type="hidden" readonly name="CarLength" readonly class="edit form-control transparent">
             <input type="text" name="CarLengthName" readonly class="edit form-control transparent">
          </td>
        <td>
               <input type="text" readonly name="CarVolume" readonly class="edit form-control transparent">
        </td>
        <td>
              <input type="text" readonly name="CarWeight" readonly class="edit form-control transparent">
        </td>
          <td class="">
            <input name="Price" readonly class="edit form-control transparent" f-options="{'code':'Price','type':'number','etype':'','len':''}" verify="{'title':'Price','length':'','textarea1':true}">
          </td>
        </tr>
        <tr>
            <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
        </tr>
    </tbody>
    <tbody id="LoadPrice2" role="tab" class="tab-pane">
        <tr style="height: 26px;">
          <td class="backgroundGray" rowspan="1" colspan="1">报价类型</td>
          <td class="backgroundGray" rowspan="1" colspan="1">单位类型</td>
          <td class="backgroundGray" rowspan="1" colspan="1" style="border-right:0;">单位</td>
          <td class="backgroundGray" colspan="1" style="border-left:0;"></td>
          <td class="backgroundGray" colspan="1" style="border-right:0;">最小体积或重量(≥)</td>
          <td class="backgroundGray" colspan="1" style="border-left:0;"></td>
          <td class="backgroundGray" colspan="1" style="border-right:0;">最大体积或重量(＜)</td>
          <td class="backgroundGray" colspan="1" style="border-left:0;"></td>
          <td class="backgroundGray" colspan="1" style="border-right:0;">价格（RMB/元）</td>
          <td class="backgroundGray">
            <a href="javascript:void(0);" tar="LoadPrice2" name="add" class="button edit" executecode="%23add%23" f-options="{'code':'add','type':'_button','etype':'','len':''}" verify="{'title':'add','length':'','textarea1':true}">新增</a>
          </td>
        </tr>
        <tr style="height: 26px; display: none;" class="" fb-options="{'rowid':'LoadPrice2','initialRows':'','maxrows':'','content':''}" rowid="LoadPrice2">
          <td class="DocType" rowspan="1" colspan="1">
            <input type="hidden" name="DocType">
            <select name="DocType_id" disabled class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);" f-options="{'code':'DocType','type':'combobox','etype':'','len':''}" verify="{}">
              <option value="0">---------------------------</option>
              <option value="5">装货费</option>
              <option value="6">卸货费</option>
            </select>
          </td>
          <td class="UnitType" colspan="1">
            <input type="hidden" name="UnitType">
		    <select name="UnitType_id" disabled class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);Unit(this)" f-options="{'code':'UnitType','type':'combobox','etype':'','len':''}" verify="{'title':'UnitType','length':'','textarea1':true}">
		      <option value="0">-------------------------</option>
		      <option value="1">重量</option>
		      <option value="2">体积</option>
		      <option value="3">数量</option>
		    </select>
          </td>
          <td class="Unit" colspan="2">
            <input type="hidden" name="Unit">     
		    <select name="Unit_id" disabled class="edit transparent selectCarr show-tick form-control" data-live-search="true" onchange="pushDisplayValue(this);_DoComboLinking(this);UnitType(this)" f-options="{'code':'Unit','type':'combobox','etype':'','len':''}" verify="{'title':'Unit','length':'','textarea1':true}">
		      <option value="0">-------------------------</option>
		      <!--#include file="/Controls/Unit.aspx"-->
		    </select>
          </td>
          <td class="" colspan="2">
		    <input type="hidden" name="DetailID" value="0" />
            <input name="Min" readonly class="edit form-control transparent" f-options="{'code':'Min','type':'text','etype':'','len':''}" verify="{'title':'Min','length':'','textarea1':true}">
	      </td>
          <td class="" colspan="2">
            <input name="Max" readonly class="edit form-control transparent" f-options="{'code':'Max','type':'text','etype':'','len':''}" verify="{'title':'Max','length':'','textarea1':true}">
	      </td>
          <td class="" colspan="1">
            <input name="Price" readonly class="edit form-control transparent" f-options="{'code':'Price','type':'number','etype':'','len':''}" verify="{'title':'Price','length':'','textarea1':true}">
          </td>
          <td class="">
            <a href="javascript:void(0);" tar="LoadPrice2" class="button edit" onclick="DelPrice(this, 'pml_0018')" f-options="{'code':'','type':'_button','etype':'','len':''}" verify="{'title':'','length':'','textarea1':true}">删除</a>
          </td>
        </tr>
        <tr>
            <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
        </tr>
    </tbody>
    <tbody id="MinPrice" role="tab" class="tab-pane">
        <tr style="height: 26px;">
          <td class="backgroundGray" rowspan="1" colspan="2" style="border-right:none;">价格（RMB/元）</td>
          <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border-left:none" colspan="1"></td>
        </tr>
        <tr style="height: 26px; display: none;" class="" fb-options="{'rowid':'MinPrice','initialRows':'','maxrows':'','content':''}" rowid="MinPrice">
          <td class="" rowspan="1" colspan="9" style="border-right:0;">
 		    <input type="hidden" name="DetailID" value="0" />
           <input name="Price" readonly class="edit form-control transparent" f-options="{'code':'Price','type':'number','etype':'','len':''}" verify="{'title':'Price','length':'','textarea1':true}">
          </td>
            <td style="border-left:0;"></td>
        </tr>
        <tr>
            <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
        </tr>
    </tbody>
    <tbody id="InsurancePrice" role="tab" class="tab-pane">
        <tr style="height: 26px;">
          <td class="backgroundGray" rowspan="1" colspan="2" style="border-right:none;">价格</td>
            <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border-left:none" colspan="1"></td>
          <!--td class="backgroundGray">
            <a href="javascript:void(0);" tar="InsurancePrice" name="add" class="button edit" executecode="%23add%23" f-options="{'code':'add','type':'_button','etype':'','len':''}" verify="{'title':'add','length':'','textarea1':true}">新增</a>
          </td-->
        </tr>
        <tr style="height: 26px; display: none;" class="" fb-options="{'rowid':'InsurancePrice','initialRows':'','maxrows':'','content':''}" rowid="InsurancePrice">
          <td class="" style="border-right:none;" colspan="9">
		    <input type="hidden" name="DetailID" value="0" />
            <input name="Price" readonly class="edit form-control transparent" f-options="{'code':'Price','type':'number','etype':'','len':''}" verify="{'title':'Price','length':'','textarea1':true}">
          </td>
	      <td class="" style="border-left:none" colspan="1">
	      %
          </td>
        </tr>
        <tr style="height: 15px;">
          <td class="" rowspan="1" colspan="10" style="border:0;font-size:13px;height:15px;"></td>
        </tr>
    </tbody>
    <tbody id="TaxPrice" role="tab" class="tab-pane">
        <tr style="height: 26px;">
          <td class="backgroundGray" rowspan="1" colspan="2" style="border-right:none;">价格</td>
            <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border:none" colspan="1"></td>
             <td class="backgroundGray" style="border-left:none" colspan="1"></td>
          <!--td class="backgroundGray">
            <a href="javascript:void(0);" tar="TaxPrice" name="add" class="button edit" executecode="%23add%23" f-options="{'code':'add','type':'_button','etype':'','len':''}" verify="{'title':'add','length':'','textarea1':true}">新增</a>
          </td-->
        </tr>
        <tr style="height: 26px; display: none;" class="" fb-options="{'rowid':'TaxPrice','initialRows':'','maxrows':'','content':''}" rowid="TaxPrice">
          <td class="" style="border-right:none;" colspan="9">
        <input type="hidden" name="DetailID" value="0" />
            <input  name="Price" readonly  class="edit form-control transparent" f-options="{'code':'Price','type':'number','etype':'','len':''}" verify="{'title':'Price','length':'','textarea1':true}">
          </td>
        <td class="" style="border-left:none"  colspan="1">
        %
          </td>
        </tr>
        <tr>
            <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
        </tr>
    </tbody>
    <tbody>
        <tr style="height: 26px;">
          <td class="td_name" colspan="10">备注</td>
        </tr>   
        <tr style="height: 26px;">
            <td colspan="10" style="height:100px;">
                <textarea name="Description" readonly style="line-height: 28px;height:100px;"  class="edit form-control transparent" f-options="{'code':'Description','type':'richtext','etype':'','len':''}" verify="{'title':'Description','length':'','textarea1':true}"></textarea>
              </td>   
        </tr>
        <tr>
            <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
        </tr>
    	<tr style="height: 26px;">
    		<td class="td_name" colspan="10">报价单跟踪信息</td>
    	</tr>                
    	<tr class="" name="TrackDetail" style="height: 26px;">
    		<td  colspan="10">
    			<span name="History"></span>
    			<div style="display:none">
    				<span name="InsertTime" view-fld='{fld:"InsertTime",method:"show"}'></span>
    				<span name="CreatorName" view-fld='{fld:"Creator",method:"show"}'></span>
    				<span name="SrcStatusName" view-fld='{fld:"SrcStatus",method:"show"}' ></span>
    				<span name="DstStatusName" view-fld='{fld:"DstStatus",method:"show"}'></span>
    				<span name="Operation" view-fld='{fld:"Operation",method:"show"}'></span>
    				<span name="descriptions" view-fld='{fld:"description",method:"show"}'></span>
    				<span name="CompanyName" view-fld='{fld:"CompanyName",method:"show"}'></span>
    			</div>
    		</td>
    	</tr>
         <tr>
            <td rowspan="1" colspan="10" style="background-color: white; border: 0; height: 15px;"></td>
        </tr>

  </tbody>
 </table>
<!-- 表单结尾 -->
</div>

<!--通用页尾开始-->
<!--#include file="/Controls/PMS/footer.aspx"-->
<!--通用页尾结尾-->
<script type="text/javascript">
    function _DoPageLoad()
    {
        


    }
    var reqeustDone = function () {		/*所有JS加载完成以后执行*/
        if (typeof (initHeader) != "undefined") initHeader();					/*初始化页面通用头部*/
        if (typeof (initFooter) != "undefined") initFooter();					/*初始化页面通用底部*/

        initTableForm( $( '#25ccf24c-9c73-44a5-899b-2565511d81d0' ), false, function ()
        {            
            var _docid = getUrlParam( 'id' );
            if ( _docid != null ) {
                LtlDisplay( _docid );
                
                setTimeout( "hasTabData($('#PMS_LessLoad input'));hasTabData($('#PMS_FullLoad input'));hasTabData($('#CityPickPrice input'));hasTabData($('#CityDeliveryPrice input'));hasTabData($('#LoadPrice2 input'));hasTabData($('#MinPrice input'));hasTabData($('#InsurancePrice input'));hasTabData($('#TaxPrice input'));ShowVehicle();", 100 );
                setTimeout("hasLD($('#KG input'));hasLD($('#Ton input'));hasLD($('#CMetre input'));hasLD($('#Square input'));hasLD($('#num input'));",100);
            } else {
                $( '.select' ).hide();
            }

            setTimeout(function() {
                CarName();      //显示车型
                autoHead();     //初始化固定头部的宽度
                hoverTips();
            }, 300)     
        });

        
        $('body').attr( "code", getUrlParam("code") );
        
        //报价单跟踪信息
        var _docid = getUrlParam('id');

        $('tr[name="TrackDetail"]').attr('view-id', '{ id:"pml_0026",cross:"false", rowIdentClass:"TrackDetail", paras:[{"name":"docid","value":' + _docid + '}]}');
        var _myEvents = new NSF.System.Data.Grid();
        _myEvents.Pagination("first-ds-pag", $("div[name='first-ds-pag']"));
        _myEvents.Initialize("/", "TrackDetail", $("tr[name='TrackDetail']").attr("view-id"), $("tr[name='TrackDetail']"));
        
        $('.TrackDetail').each(function (index) {
            var _History;
            var _InsertTime = $(this).find('span[name="InsertTime"]').text();
            var _CreatorName = $(this).find('span[name="CreatorName"]').text();
            var _SrcStatusName = $(this).find('span[name="SrcStatusName"]').text();
            var _DstStatusName = $(this).find('span[name="DstStatusName"]').text();
            var _Operation = $(this).find('span[name="Operation"]').text();
            var _Description = $(this).find('span[name="descriptions"]').text();
    			var _CompanyName = $( this ).find( 'span[name="CompanyName"]' ).text();

            if (_Operation == '0') {
                _History = (index + 1) + '.  ' + _InsertTime + ',由' + _CompanyName + '：' + _CreatorName + '发送了报价单，并将报价单状态从' + _SrcStatusName + '变成' + _DstStatusName;
            }
            else if (_Operation == '1') {
                _History = (index + 1) + '.  ' + _InsertTime + ',由' + _CompanyName + '：' + _CreatorName + '拒绝了报价单，将报价单打回到待发送列表，订单状态变成' + _DstStatusName + '，拒绝原因：' + _Description;
            }
         
            //判断是否是已发送状态
            if (getUrlParam('status')) {
                $('.agreenBtn').css('display', 'inline-block');
                $('.noBtn').css('display', 'inline-block');
                $('input').attr('disabled', 'disabled');
                //$('select').attr('disabled', 'disabled');
                $('select').next().find('div.open').addClass('hide');
                $('#KG td>a, #Ton td>a, #CMetre td>a, #Square td>a, #num td>a').removeAttr('onclick').css('color', '#ddd');
                $('#PMS_FullLoad td>a').removeAttr('executecode onclick').css('color', '#ddd');
            } else {
                $('.agreenBtn').css('display', 'none');
                $('.noBtn').css('display', 'none');
            }
            if (getUrlParam('read')) {
                $('input').attr('disabled', 'disabled');
                //$('select').attr('disabled', 'disabled');
                $('select').next().find('div.open').addClass('hide');
                $('#KG td>a, #Ton td>a, #CMetre td>a, #Square td>a, #num td>a').removeAttr('onclick').css('color', '#ddd');
                $('#PMS_FullLoad td>a').removeAttr('executecode onclick').css('color', '#ddd');
            } 
            $(this).find('span[name="History"]').text(_History);

            //所有编辑框设置为只读
            $('input').attr('disabled', 'disabled');
            //$('select').attr('disabled', 'disabled');
            $('select').next().find('div.open').addClass('hide');
            $('#KG td>a, #Ton td>a, #CMetre td>a, #Square td>a, #num td>a').removeAttr('onclick').css('color', '#ddd');
            $('#PMS_FullLoad td>a').removeAttr('executecode onclick').css('color', '#ddd');
        });

        //报价单搜索显示复制按钮
        if (getUrlParam('code') == 'MySearch') {
            $('a.copy').removeClass('hide');
            $('a.copy').attr('href', 'DocByCompact.aspx?id=' + getUrlParam('id') + '&copy=1');
        }
        $( '.ld li' ).click( function () {
            var name = $( this ).find( 'a' ).attr( 'aria-controls' );
            if ( name != undefined )
            {
                $( 'tbody[role="tab1"]' ).removeClass( 'active' );
                $( '#' + name ).addClass( 'active' );
            }
            if ( name == 'num' )
            {
                $( '.ld li' ).removeClass( 'active' );
                $( '.ld li.num' ).addClass( 'active' );
            }
        } );
        $( '.title1 li a' ).click( function () {
            var name = $( this ).attr( 'aria-controls' );
            $( 'tbody[role="tab"]' ).removeClass( 'active' );
            $( '#' + name ).addClass( 'active' );
            if ( name == 'PMS_LessLoad' )
            {
               
				var two = $( '.ld li.active' ).find( 'a' ).attr( 'aria-controls' );
				$( '#' + two ).addClass( 'active' );
                
            }
            else
            {
                $( 'tbody[role="tab1"]' ).removeClass( 'active' );
            }
           
        } );
        //零担输入框change事件
        $( '#KG input, #Ton input, #CMetre input, #Square input, #num input' ).change( function (){
            var name = $( this ).parent().parent().parent().attr( 'id' );
            var stat = false;
            if ( $( this ).val() != '' )
            {                
                $('li a[aria-controls="' + name + '"]').attr('style', 'color:#DF771E !important');
                $('li a[aria-controls="PMS_LessLoad"]').attr('style', 'color:#DF771E !important');
                if ( name == 'num' )
                {
                    $( 'li a[aria-controls="' + name + '"]' ).nextAll().find( 'button' ).attr( 'style', 'color:#DF771E !important' );
                }
            }
            else
            {
                $( '#' + name ).find('tr').each( function ( index )
                {
                    for ( var i = 0; i < $( '#' + name ).find('tr').eq( index ).find( 'td' ).length;i++)
                    {
                        if ( $( '#' + name ).find( 'tr' ).eq( index ).find( 'td' ).eq( i ).find( 'input' ).val() != undefined && $( '#' + name ).find( 'tr' ).eq( index ).find( 'td' ).eq( i ).find( 'input' ).val() != '' && $( '#' + name ).find( 'tr' ).eq( index ).find( 'td' ).eq( i ).find( 'input' ).val() != '请选择目的城市' &&
                            $( '#' + name ).find( 'tr' ).eq( index ).find( 'td' ).eq( i ).find( 'input' ).val() != 0)
                        {
                            stat = true;                            
                        }
                    }
                });
               
                if ( stat == false)
                {
                    $( 'li a[aria-controls="' + name + '"]' ).attr( 'style', 'color:#333' );
                    if ( name == 'num' )
                    {
                        $( 'li a[aria-controls="' + name + '"]' ).nextAll().find( 'button' ).attr( 'style', 'color:#333' );
                    }
                }
            }
        });

        //除零担意外其它几项的输入框change事件
        $('#PMS_FullLoad input , #CityPickPrice input , #CityDeliveryPrice input , #LoadPrice2 input , #MinPrice input , #InsurancePrice input , #TaxPrice input').change(function () {
            var name = $(this).parents('tbody').attr('id');
            var stat = false;
            if ($(this).val() != '') {
                $('li a[aria-controls="' + name + '"]').attr('style', 'color:#DF771E !important');
            }
            else {
                $('#' + name).find('tr').each(function (index) {
                    for (var i = 0; i < $('#' + name).find('tr').eq(index).find('td').length; i++) {
                        if ($('#' + name).find('tr').eq(index).find('td').eq(i).find('input').val() != undefined && $('#' + name).find('tr').eq(index).find('td').eq(i).find('input').val() != '' && $('#' + name).find('tr').eq(index).find('td').eq(i).find('input').val() != '请选择目的城市' &&
                            $('#' + name).find('tr').eq(index).find('td').eq(i).find('input').val() != 0) {
                            stat = true;
                        }
                    }
                });
                if (stat == false) {
                    $('li a[aria-controls="' + name + '"]').attr('style', 'color:#888');
                }
            }
        });
        //价格最后以为快捷键
        $( document ).on( 'keydown', '.hotKey', function ( e ) {
            if ( e.which == 13 )
            {
                add( $( this ).parent().parent().parent().find( 'a[onclick="add(this)"]' ) );
            }
        } );
        
    };
    var _jsUrl = "<%=MinifyUrl("FormJs")%>";
    
    function hasTabData(tag) {
        var name = tag.parents('tbody').attr('id');
        var stat = false;
        
            $('#' + name).find('tr').each(function (index) {
                if ($('#' + name).find('tr').eq(index).css('display') == "table-row") {
                    
                        if ($('#' + name).find('tr').eq(index).find('td').find('input[name="Price"]').val() != undefined && $('#' + name).find('tr').eq(index).find('td').find('input[name="Price"]').val() != '' && $('#' + name).find('tr').eq(index).find('td').find('input[name="Price"]').val() != '请选择目的城市' &&
                            Number($('#' + name).find('tr').eq(index).find('td').find('input[name="Price"]').val()) != 0) {
                            stat = true;
                        }
                   
                }
            });
        
            if (stat == false) {
                $('li a[aria-controls="' + name + '"]').attr('style', 'color:#888');
            } else {
                $('li a[aria-controls="' + name + '"]').attr('style', 'color:#DF771E !important');
            }
    }

    function hasLD(tag) {
            var name = tag.parents('tbody').attr('id');
            var stat = false;
            
                $('#' + name).find('tr').each(function (index) {
                    for (var i = 0; i < $('#' + name).find('tr').eq(index).find('td').length; i++) {
                        if ($('#' + name).find('tr').eq(index).find('td').eq(i).find('input').val() != undefined && $('#' + name).find('tr').eq(index).find('td').eq(i).find('input').val() != '' && $('#' + name).find('tr').eq(index).find('td').eq(i).find('input').val() != '请选择目的城市' &&
                            $('#' + name).find('tr').eq(index).find('td').eq(i).find('input').val() != 0) {
                            stat = true;
                        }
                    }
                });
               
                if (stat == false) {
                    $('li a[aria-controls="' + name + '"]').attr('style', 'color:#333');
                    if (name == 'num') {
                        $('li a[aria-controls="' + name + '"]').nextAll().find('button').attr('style', 'color:#333');
                    }
                } else {
                    $('li a[aria-controls="' + name + '"]').attr('style', 'color:#DF771E !important');
                    $('li a[aria-controls="PMS_LessLoad"]').attr('style', 'color:#DF771E !important');
                    if (name == 'num') {
                        $('li a[aria-controls="' + name + '"]').nextAll().find('button').attr('style', 'color:#DF771E !important');
                        $('li a[aria-controls="' + name + '"]').nextAll().find('button').find('span').css('color', '#DF771E !important');
                    }
                }
           
    }
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--#include file="/Controls/PMS/JS.aspx"-->
<script src="/assets/request_minify.js"></script>
</body>
</html>