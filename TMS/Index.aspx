<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="../Libs/Environment.aspx.cs" Inherits="OTMS.Environment" %>
<!doctype html>
<html>
<head>		
<title>个人中心-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--#include file="/Controls/Meta.aspx"-->
<!--#include file="/Controls/TMS/CSS.aspx"-->
<link href="<%=MinifyUrl("ListCss")%>" rel="stylesheet" type="text/css" />
<link href="../../css/guideBrows.css" rel="stylesheet" type="text/css"/>
<link href="city/css/cityLayout.css" type="text/css" rel="stylesheet">
<script src="/assets/js/csdu.queue.js"></script>

</head>
<body code="Index">
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
<!-- 发送拼车单开始 -->
<div class="modal fade" id="CombinedModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                    

                    <h4 class="modal-title text-left" id="H1">
                        <div style="padding-left: 3px; background-color: #f27302;">
                           <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">发送拼车单</p>
                        </div>
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <label class="col-md-2 control-Label">描述</label>
                        <div class="col-md-10">
                            <textarea name="CDescription" class="form-control" rows="3" cols="70"></textarea>
                            <input type="hidden" name="COrderID" />
                            <input type="hidden" name="OrderID" />
                            <input type="hidden" name="SupplierName" >
                            <input type="hidden" name="NoticeKey" value="">
                            <input type="hidden" name="OpenId" />
                            <input type="hidden" name="CombinedQty" />
                            <input type="hidden" name="IsSend" >
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
                    <button type="button" class="btn btn-default  okButton" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="确定" onclick="SendCombineOrder( $(this).closest('div#CombinedModal'))" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;color:#888;"></span></button>
                    <button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
<!-- 发送拼车单结束 -->

<!--获取制单时段开始-->
<div class="modal fade" id="rangeModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog" style="height:200px">
          <div class="modal-content" style="height:100%">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
               
                <h4 class="modal-title text-left" id="myModalLabel">
                    <div style="padding-left: 3px; background-color: #f27302;">
                        <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">时间段</p>
                    </div>
                </h4>
                </div>
                <div class="modal-body">
                  <div class="form-group">
                    <div class="col-md-5">
                    <input type="text"  onclick="GetDateEvent(this, { format: 'YYYY-MM-DD'})" class="form-control min" placeholder="起始时间">
                    </div>
                    <div class="col-md-1">-</div>
                    <div class="col-md-5">
                    <input type="text"  onclick="GetDateEvent(this, { format: 'YYYY-MM-DD'})" class="form-control max" placeholder="结束时间">
                    </div>
                  </div>
                    
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
		          <button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="rangeOk( $(this).closest('div#rangeModal') )" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
		          <button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<!--获取制单时段结束-->

<!--发货时间段开始-->
<div class="modal fade" id="rangeFromModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog" style="height:200px">
          <div class="modal-content" style="height:100%">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
	                <h4 class="modal-title text-left" id="myModalLabel">
	                    <div style="padding-left: 3px; background-color: #f27302;">
	                        <p class="time_ment fahuo" style="">时间段</p>
	                    </div>
	                </h4>
                </div>
                <div class="modal-body">
                	<div class="form-group">
                		<div class="col-md-5">
            				<input type="text"  onclick="GetDateEvent(this, { format: 'YYYY-MM-DD'})" class="form-control min" placeholder="起始时间">
                		</div>
                		<div class="col-md-1">-</div>
                		<div class="col-md-5">
            				<input type="text"  onclick="GetDateEvent(this, { format: 'YYYY-MM-DD'})" class="form-control max" placeholder="结束时间">
                		</div>
                	</div>
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
					<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="rangeOk( $(this).closest('div#rangeFromModal') )" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
					<button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div> 


<!--批量接收订单开始---->
<div class="modal fade" id="receive-Modal"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div class="modal-dialog" style="width:90%;" >
        <div class="modal-content" style="width:100%;" >
            <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                <h4 class="modal-title text-left" id="myModalLabel">
                    <div style="padding-left: 3px; background-color: #f27302;">
                        <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">批量接收订单</p>
                    </div>
                </h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="list-item box jplist-panel tabbtn" >
                        <div class="" style="height:410px;overflow-y:scroll;"><!-- block right -->
                            <table class="jptable  table FailureTable ">
                                <thead>
                                    <tr class="trtitle">
                                        <td class="title">单据编号</td>
                                        <td class="title">合同编号</td>
                                        <td class="title">客户名称</td>
                                        <td class="title">错误代码</td>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <p class="SuccessTips text-center hide" style="font-size:14px;color:#f27302;margin-top:80px;">恭喜您，接收订单全部成功，没有错误数据提醒</p>
                            <div class="text-center">
                                <div class="num" id="num"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;" >
                <!--<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="确定" onclick="SendBackOrder()" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>-->
                <button type="button" class="btn btn-default cancer " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;"></span></button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>
<!--批量接收订单结束---->


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
                        <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">接收拼车单</p>
                    </div>
                </h4>
                </div>
                <div class="modal-body tab_jsjj">
                    <span name="content">是否确定接收拼车单</span>
                    <input type="hidden" name="Accept" />
                    <input type="hidden" name="OrderID" />
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
					<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="确定" onclick="ReceiveCombineOrders()" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
					<button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
    </div>

<div class="modal fade" id="signModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
       <div class="modal-dialog">
          <div class="modal-content" >
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                <%--<button type="button" class="close" 
                    data-dismiss="modal" aria-hidden="true">
                        &times;
                </button>--%>
                <h4 class="modal-title text-left" id="myModalLabel">
                    <div style="padding-left: 3px; background-color: #f27302;">
                        <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">签收订单</p>
                    </div>
                </h4>
                </div>
                <div class="modal-body">
                    是否确定签收订单
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
                    <button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none; text-shadow:none;" aria-label="OK" title="确定" onclick="SignOrderAuto( $( 'input[name=\'OrderID\']').val() )" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
                    <input type="hidden" name="OrderID" >
                    <button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
          </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

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
                           <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">关闭订单</p>
                        </div>
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <label class="col-md-2 control-Label" style="color:#333;font-size:12px;">关闭原因</label>
                        <div class="col-md-10">
                            <textarea name="CDescription" class="form-control" rows="3" cols="70"></textarea>
                            <input type="hidden" name="COrderID" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
					<button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;" aria-label="OK" title="确定" onclick="ClosedOrder()" ><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left:2px;"></span></button>
					<button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left:2px;color:#888;"></span></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
        </div>
        <div class="modal fade" id="Div1" tabindex="-1" role="dialog"
            aria-labelledby="myModalLabel2" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                        <%--<button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                            &times;
                        </button>--%>

                        <h4 class="modal-title text-left" id="H2">
                            <div style="padding-left: 3px; background-color: #f27302;">
                                <input type="hidden" name="id" />
                                <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">发送订单</p>
                            </div>
                        </h4>
                    </div>
                    <div class="modal-body">
                        是否确定调度
                    </div>
                    <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
                        <button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="ScheduleOrderList(this)"><span aria-hidden="true" class="">确定</span><span class="glyphicon glyphicon-ok" style="margin-left: 2px;"></span></button>
                        <button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left: 2px; color: #888;"></span></button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal -->
        </div>


    <div class="modal fade" id="IsHd" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style=" padding-bottom:0;padding-top:20px;">
                    

                    <h4 class="modal-title text-left" id="H2">
                        <div style="padding-left: 3px; background-color: #f27302;">
                            <p style="background-color: white; padding-left: 8px; height: 20px;margin-bottom:0; line-height: 20px; margin-bottom: 20px;color:#666; font-size:14px;font-family:'微软雅黑';">回单</p>
                            <input type="hidden"  name="HdID"/>
                        </div>
                    </h4>
                </div>
                <div class="modal-body">
                    您是否需要上传回单照片？
                </div>
                <div class="modal-footer" style="position:absolute; top:0; width:100%; padding-bottom:0;">
                    <button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;" aria-label="OK" title="确定" onclick="OrderReceiptEdit(this)"><span aria-hidden="true" class="">直接回单</span><span class="glyphicon glyphicon-ok" style="margin-left: 2px;"></span></button>
                    <button type="button" class="btn btn-default  okButton footKeepBtn" style="margin-right:8px; box-shadow:none;text-shadow:none;"  title="上传照片" onclick="loadPoto()"><span aria-hidden="true" class="">上传照片</span><span class="glyphicon glyphicon-picture" style="margin-left: 2px;"></span></button>
                    <button type="button" class="btn btn-default " data-dismiss="modal" aria-label="Close" title="关闭" style="box-shadow:none;margin-left:0;"><span aria-hidden="true" class="">关闭</span><span class="glyphicon glyphicon-remove" style="margin-left: 2px; color: #888;"></span></button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
<!--通用头部文件开始-->
<!--#include file="/Controls/TMS/header.aspx"-->
<!--通用头部文件结尾-->
<!-- 模板开始-->
<!-- 待接收订单 -->
<script id="jplist-template" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
	<div class=""><!-- block right -->
		<table class="jptable table demoList">
			<thead>
				<tr class="trtitle" >
					<td style="width:35px;">
                        <input type="checkbox"  >
                    </td>
					<td class="title">单据编号</td>
					<td class="title">合同编号</td>
					<td class="title">客户名称</td>
                    <td class="title">收货方名称</td>
					<td class="title">发货地址</td>
                    <td class="title">收货地址</td>
					<td class="title">数量</td>
					<!--1666 个人中心，待接收订单，拼车单体积、重量无需显示-->
					<!--<td class="title">重量</td>
					<td class="title">体积</td>-->
					<td class="title" style="text-align:left;">操作</td>
				</tr>
			</thead>
			<tbody>
			{{each data}}
				<tr>
					<td style="width:35px">
                        <input type="hidden" name="id" fld="id" value="{{$value.id}}"/>
                        <span  style="position:relative; top:-1px;display:inline-block;width:16px;">{{$index+1}}</span>
                        <input type="checkbox" class="receive-checkbox" value="{{$value.id}}" srcClass="{{$value.SrcClass}}" >
                    </td>
					<td class="title" fld="Code" title="{{$value.Code}}">
						{{if $value.SrcClass == "3" }}
							<a href="OrderAcceptCar_edit.aspx?id={{$value.id}}" >{{$value.Code}}</a>
						{{else}}
						    <a href="OrderAccept_edit.aspx?id={{$value.id}}" >{{$value.Code}}</a>
						{{/if}}
					</td>
					<td class="title" title="{{$value.PactCode}}" fld="PactCode">{{$value.PactCode}}</td>
					<td class="title" title="{{$value.CustomerName}}" fld="CustomerName">{{$value.CustomerName}}</td>
					<td class="title" title="{{$value.EndUserName}}" fld="EndUserName">{{$value.EndUserName}}</td>
					<td class="title" title="{{$value.From}}" fld="From">{{$value.From}}</td>
					<td class="title" title="{{$value.To}}" fld="To">{{$value.To}}</td>
                    <td class="title" title="{{$value.Qty}}" fld="">{{$value.Qty}}</td>
                   <!--1666 个人中心，待接收订单，拼车单体积、重量无需显示-->
                   <!--<td class="title" title="{{$value.Weight}}" fld="">{{$value.Weight}}</td>-->
                    <!--<td class="title" title="{{$value.Volume}}" fld="">{{$value.Volume}}</td>-->
					<td class="title" style="text-align:left;">
						{{if $value.SrcClass == "3" }}
							<button type="button"  title="接收订单" onclick = "IsReceiveCombineOrders( 1, {{$value.id}})" style="margin-left:0;" >接收</button>
                	    	<button type="button"  title="拒绝打单" onclick = "IsReceiveCombineOrders( 0, {{$value.id}})" >拒绝</button>
						{{else}}
							<button type="button"  title="接收订单" onclick = "ReceiveOrder( 1, {{$value.id}})" style="margin-left:0;">接收</button>
                	    	<button type="button"  title="拒绝打单" onclick = "ReceiveOrder( 0, {{$value.id}})" >拒绝</button>
						{{/if}}
                        
				</tr>
			{{/each}}
			</tbody>
		</table>
	</div>
</div>
</script>
<!-- 市内待调度订单 -->
<script id="jplist-template1" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
    <div class=""><!-- block right -->
        <table class="jptable table demoList">
            <thead>
                <tr class="trtitle">
                    <td style="width:40px;">
                        <input type="checkbox">
                    </td>
                    <td class="title">单据编号</td>
                    <td class="title">合同编号</td>
                    <td class="title">客户名称</td>
                    <td class="title">收货方名称</td>
                    <td class="title">发货地址</td>
                    <td class="title">收货地址</td>
                    <td class="title">数量</td>
                    <td class="title">重量(公斤)</td>
                    <td class="title">体积(立方米)</td>
                    <td class="title">操作</td>
                </tr>
            </thead>
            <tbody>
            {{each data}}
                <tr>
                    <td style="width:40px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/><span style="position:relative; top:-1px;display:inline-block;width:16px;">{{$index+1}}</span>
                    <input type="checkbox" name="CombineBox" fld="id" value="{{$value.id}}"/></td>
                    <td class="title"  fld="Code" title="{{$value.Code}}"><a href="OrderSend_edit.aspx?id={{$value.id}}&did=1" >{{$value.Code}}</a></td>
                    <td class="title" title="{{$value.PactCode}}" fld="PactCode">{{$value.PactCode}}</td>
                    <td class="title" title="{{$value.CustomerName}}" fld="CustomerName">{{$value.CustomerName}}</td>
                    <td class="title" title="{{$value.EndUserName}}" fld="EndUserName">{{$value.EndUserName}}</td>
                    <td class="title" title="{{$value.From}}" fld="From">{{$value.From}}</td>
                    <td class="title" title="{{$value.ToAddress}}" fld="ToAddress">{{$value.ToAddress}}</td>
                    <td class="title" title="{{$value.Qty}}" fld="Qty">{{$value.Qty}}</td>
                    <td class="title" title="{{$value.Weight}}" fld="Weight">{{$value.Weight}}</td>
                    <td class="title" title="{{$value.Volume}}" fld="Volume">{{$value.Volume}}</td>
                    <td class="title">
                        <button class="btn btn-link" title="关闭订单" onclick="Closed({{$value.id}})" style="margin-left:0;">关闭</button>
                    </td>
                </tr>
            {{/each}}
            </tbody>
        </table>
    </div>
</div>
</script>
<!--长途待调度-->
<script id="jplist-template5" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
    <div class=""><!-- block right -->
        <table class="jptable table demoList">
            <thead>
                <tr class="trtitle">
                    <td style="width:40px;">
                        <input type="checkbox" >
                    </td>
                    <td class="title">单据编号</td>
                    <td class="title">合同编号</td>
                    <td class="title">客户名称</td>
                    <td class="title">收货方名称</td>
                    <td class="title">发货地址</td>
                    <td class="title">收货地址</td>
                    <td class="title">数量</td>
                    <td class="title">重量(公斤)</td>
                    <td class="title">体积(立方米)</td>
                    <td class="title">操作</td>
                </tr>
            </thead>
            <tbody>
            {{each data}}
                <tr>
                    <td style="width:40px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/><span style="position:relative; top:-1px;display:inline-block;width:16px;">{{$index+1}}</span>
                    <input type="checkbox" name="CombineBox" fld="id" value="{{$value.id}}"/></td>
                    <td class="title"  fld="Code" title="{{$value.Code}}"><a href="OrderSend_edit.aspx?id={{$value.id}}&did=2" >{{$value.Code}}</a></td>
                    <td class="title" title="{{$value.PactCode}}" fld="PactCode">{{$value.PactCode}}</td>
                    <td class="title" title="{{$value.CustomerName}}" fld="CustomerName">{{$value.CustomerName}}</td>
                    <td class="title" title="{{$value.EndUserName}}" fld="EndUserName">{{$value.EndUserName}}</td>
                    <td class="title" title="{{$value.From}}" fld="From">{{$value.From}}</td>
                    <td class="title" title="{{$value.ToAddress}}" fld="ToAddress">{{$value.ToAddress}}</td>
                    <td class="title" title="{{$value.Qty}}" fld="Qty">{{$value.Qty}}</td>
                    <td class="title" title="{{$value.Weight}}" fld="Weight">{{$value.Weight}}</td>
                    <td class="title" title="{{$value.Volume}}" fld="Volume">{{$value.Volume}}</td>
                    <td class="title">
                        <button class="btn btn-link" title="关闭订单" onclick="Closed({{$value.id}})" style="margin-left:0;">关闭</button>
                    </td>
                </tr>
            {{/each}}
            </tbody>
        </table>
    </div>
</div>
</script>

<!-- 拼车待调度订单 -->
<script id="jplist-template6" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
    <div class=""><!-- block right -->
        <table class="jptable table demoList">
            <thead>
                <tr class="trtitle">
                    <td style="width:40px;"></td>
                    <td class="title">单据编号</td>
                    <td class="title">合同编号</td>
                    <td class="title">承运方名称</td>
                    <td class="title">订单数量</td>
                    <td class="title">运输模式</td>
                    <td class="title">操作</td>
                </tr>
            </thead>
            <tbody>
            {{each data}}
                <tr>
                    <td style="width:40px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
                    <td class="title"  fld="Code" title="{{$value.Code}}"><a href="CombinedSend_edit.aspx?id={{$value.id}}" >{{$value.Code}}</a></td>
                    <td class="title" title="{{$value.PactCode}}" fld="PactCode">{{$value.PactCode}}</td>
                    <td class="title" title="{{$value.SupplierName}}" fld="SupplierName">{{$value.SupplierName}}</td>
                    <td class="title" title="{{$value.Qty}}" fld="Qty">{{$value.Qty}}</td>
                    <td class="title" title="{{$value.ShipMode}}" fld="ShipMode">
                        {{if $value.ShipMode == "1" }}
                            市内
                        {{else if $value.ShipMode == "2" }}
                            长途
                        {{/if}}
                        </td>
                    <td class="title">
                        <button class="btn btn-link" title="发送拼车单" onclick="CombinedModal(1032836, '鲨鱼', '', '2')" style="margin-left:0;">发送</button>
                        <button class="btn btn-link" title="编辑拼车单" onclick="javascript:location.href='CombinedSend_edit.aspx?id={{$value.id}}'" style="margin-left:0;">编辑</button>
                        <button class="btn btn-link" title="关闭订单" onclick="Closed({{$value.id}})" style="margin-left:0;">关闭</button>
                    </td>
                </tr>
            {{/each}}
            </tbody>
        </table>
    </div>
</div>
</script>
<!-- 待签收订单 -->
<script id="jplist-template2" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
    <div class=""><!-- block right -->
        <table class="jptable  table demoList">
            <thead>
                <tr class="trtitle">
                    <td style="width:35px;"></td>
                    <td class="title">单据编号</td>
                    <td class="title">合同编号</td>
                    <td class="title">客户名称</td>
                    <td class="title">收货方名称</td>
                    <td class="title">发货地址</td>
                    <td class="title">收货地址</td>
                    <!--<td class="title">订单状态</td>-->
                    <td class="title" style="text-align:left;">操作</td>
              </tr>
            </thead>
            <tbody>
            {{each data}}
                <tr>
                    <td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
                    <td class="title" title="{{$value.code}}" fld="code">
                        {{if $value.SrcClass == "1" }}
                            <a href="OrderSign_edit.aspx?id={{$value.id}}">{{$value.code}}</a>
                        {{else}}
                            <a href="SignManage_edit.aspx?id={{$value.id}}">{{$value.code}}</a>
                        {{/if}}
                    </td>
                    <td class="title" title="{{$value.pactcode}}" fld="pactcode">{{$value.pactcode}}</td>
                    <td class="title" title="{{$value.CustomerName}}" fld="CustomerName">{{$value.CustomerName}}</td>
                    <td class="title" title="{{$value.endusername}}" fld="endusername">{{$value.endusername}}</td>
                    <td class="title" title="{{$value.from}}" fld="from">{{$value.from}}</td>
                    <td class="title" title="{{$value.to}}" fld="to">{{$value.to}}</td>
                    <!--<td class="title" title="{{$value.StatusName}}" fld="StatusName">{{$value.StatusName}}</td>-->
                    <td class="title" style="text-align:left;">
                        <button type="button" title="签收订单" onclick="IsSign({{$value.id}})" style="margin-left:0;">签收</button>
                        <a href="Comments.aspx?id={{$value.id}}&name=OrderSign" style="margin-right:5px;">备注</a>
                        <button type="button" title="关闭订单" onclick="Closed({{$value.id}})">关闭</button>
                    </td> 
               </tr>
            {{/each}}
            </tbody>
        </table>
    </div>
</div>
</script>
<!-- 待回单订单 -->
<script id="jplist-template3" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
    <div class=""><!-- block right -->
        <table class="jptable table demoList">
            <thead>
                <tr class="trtitle">
                    <td style="width:35px;"></td>
                    <td class="title">单据编号</td>
                    <td class="title">合同编号</td>
                    <td class="title">客户名称</td>
                    <td class="title">收货方名称</td>
                    <td class="title">发货地址</td>
                    <td class="title">收货地址</td>
                  <!--  <td class="title">订单状态</td>-->
                    <td class="title" style="text-align:left;">操作</td>
                </tr>
            </thead>
            <tbody>
            {{each data}}
                <tr>
                    <td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
                    <td class="title" title="{{$value.code}}" fld="code">
                        {{if $value.SrcClass == "1" }}
                            <a href="OrderReceipt_edit.aspx?id={{$value.id}}">{{$value.code}}</a>
                        {{else}}
                            <a href="ReceiptManage_edit.aspx?id={{$value.id}}">{{$value.code}}</a>
                        {{/if}}
                    </td>
                    <td class="title" title="{{$value.pactcode}}" fld="pactcode">{{$value.pactcode}}</td>
                    <td class="title" title="{{$value.CustomerName}}" fld="CustomerName">{{$value.CustomerName}}</td>
                    <td class="title" title="{{$value.endusername}}" fld="endusername">{{$value.endusername}}</td>
                    <td class="title" title="{{$value.from}}" fld="from">{{$value.from}}</td>
                    <td class="title" title="{{$value.to}}" fld="to">{{$value.to}}</td>
                    <!--<td class="title" title="{{$value.StatusName}}" fld="StatusName">{{$value.StatusName}}</td>-->
                    <td class="title" style="text-align:left;">
                        <button class="btn btn-link" title="提交纸质回单" onclick="IsHd({{$value.id}})" style="margin-left:0;margin-right:0px;">回单</button>
                        <a href="Comments.aspx?id={{$value.id}}&name=OrderReceipt" style="margin-right:0px;">备注</a>
                        {{if $value.SupplierID=="0"}}
                          <button class="btn btn-link" title="打回订单" onclick="IsBackOrder({{$value.id}})" style="margin-left:0;">打回</button>
                          {{else}}
                          <span readonly style="margin-left:0px; margin-right:0px;">打回</span>
                         {{/if}}
                        <button class="btn btn-link" title="关闭订单" onclick="Closed({{$value.id}})" style="margin-left:0;margin-right:0;">关闭</button>
                    </td> 
    </tr>
            {{/each}}
            </tbody>
        </table>
    </div>
</div>
</script>
<!-- 待审核承运方 -->
<script id="jplist-template4" type="text/x-template">
<div class="list-item box jplist-panel tabbtn">
    <div class=""><!-- block right -->
        <table class="jptable  table shTable">
            <thead>
                <tr class="trtitle">
                    <td style=""></td>
                    <td class="title">邀请公司名称</td>
                    <td class="title">状态</td>
                    <td class="title" style="text-align:left;">操作</td>
                </tr>
            </thead>
            <tbody>
            {{each data}}
                <tr>
                    <td style="width:35px"><input type="hidden" name="id" fld="id" value="{{$value.id}}"/>{{$index+1}}</td>
                    <td class="title" title="{{$value.OwnerCompanyName}}" fld="OwnerCompanyName"><a href="BeInvite_edit.aspx?id={{$value.id}}" >{{$value.OwnerCompanyName}}</a></td>
                    <td class="title"  fld="Status">
                        {{if $value.Status == "0"}}
                            待处理申请
                        {{else if $value.Status == "1" }}
                            接受申请
                        {{else if$value.Status == "2" }}
                            拒绝
                        {{/if}}
                    </td>
                    <td class="title" fld="" style="text-align:left;"><span  title="同意" onclick="SupplierAccept( 1, {{$value.id}})" style="cursor:pointer;color:#06c;">同意</span> &nbsp; <span onclick="SupplierAccept( 2, {{$value.id}})" title="拒绝" style="cursor:pointer; color:#06c;">不同意</span></td>
                    </tr>
            {{/each}}
            </tbody>
        </table>
    </div>
</div>
</script>
<!-- 模板结尾 -->

<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表开始 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->
<div class="mt30" style="padding-left:15px; padding-right:15px;">
    <p class="tips">欢迎您登录物流源平台！</p>
    <div class="navTab clearfix" name="TrackDetail" view-id='{ id:"stat_0001",cross:"false", paras:[]}'>
        <%
        //客服
        if (GetUserInfo().RoleId == OTMS.UserRole.OrderReceiver)
        {
            %>
            <a href="#0" role="demo" onclick="loadList( $(this).attr('href') )">待接收订单（<span class="orangeO" name="Recv_Count" view-fld='{fld:"Recv_Count",method:"show"}'></span>）</a>
            <%
        }
        
        //运营
        else if (GetUserInfo().RoleId == OTMS.UserRole.OrderCreator)
        {
            %>
            <a href="#1" role="demo1" onclick="loadList( $(this).attr('href') )">市内待调度订单（<span class="orangeO" name="ScheduleIn_Count" view-fld='{fld:"ScheduleIn_Count",method:"show"}'></span>）</a>
            <a href="#4" role="demo4" onclick="loadList( $(this).attr('href') )">待审核承运方（<span class="orangeO" name="Confirm_Count" view-fld='{fld:"Confirm_Count",method:"show"}'></span>）</a>
            <a href="#5" role="demo5" onclick="loadList( $(this).attr('href') )">长途待调度订单（<span class="orangeO" name="ScheduleLonge_Count" view-fld='{fld:"ScheduleLonge_Count",method:"show"}'></span>）</a>
            <a href="#6" role="demo6" onclick="loadList( $(this).attr('href') )">拼车待调度订单（<span class="orangeO" name="ScheduleComb_Count" view-fld='{fld:"ScheduleComb_Count",method:"show"}'></span>）</a>
            <%
        }
        // 客服 运营
        else
        {
            %>
            <a href="#0" role="demo" onclick="loadList( $(this).attr('href') )">待接收订单（<span class="orangeO" name="Recv_Count" view-fld='{fld:"Recv_Count",method:"show"}'></span>）</a>
            <a href="#1" role="demo1" onclick="loadList( $(this).attr('href'))">市内待调度订单（<span class="orangeO" name="ScheduleIn_Count" view-fld='{fld:"ScheduleIn_Count",method:"show"}'></span>）</a>
            <a href="#4" role="demo4" onclick="loadList( $(this).attr('href'))">待审核承运方（<span class="orangeO" name="Confirm_Count" view-fld='{fld:"Confirm_Count",method:"show"}'></span>）</a>
            <a href="#5" role="demo5" onclick="loadList( $(this).attr('href'))">长途待调度订单（<span class="orangeO" name="ScheduleLonge_Count" view-fld='{fld:"ScheduleLonge_Count",method:"show"}'></span>）</a>
            <a href="#6" role="demo6" onclick="loadList( $(this).attr('href'))">拼车待调度订单（<span class="orangeO" name="ScheduleComb_Count" view-fld='{fld:"ScheduleComb_Count",method:"show"}'></span>）</a>
            <%
        }
        %>
        <a href="#2" role="demo2" onclick="loadList( $(this).attr('href') )">待签收订单（<span class="orangeO" name="Sign_Count" view-fld='{fld:"Sign_Count",method:"show"}'></span>）</a>
        <a href="#3" role="demo3" onclick="loadList( $(this).attr('href') )">待回单订单（<span class="orangeO" name="Receipt_Count" view-fld='{fld:"Receipt_Count",method:"show"}'></span>）</a>
    </div>
</div>
<!-- 待接收订单 -->
<div id="demo" class="box jplist demoTab">
		<div class="" style="padding-left:15px; padding-right:15px;">
            <!-- 手机自适应按钮 -->
            <div class="tableDiv clearfix">
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
               <p class="mainHtml_tit">订单接收</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="StatusTime" data-order="desc" data-type="date">排序</span></li>
						<li><span data-path="endusername" data-order="asc" data-type="text">收货方名称</span></li>
						<li><span data-path="PactCode" data-order="desc" data-type="text">合同编号</span></li><
					/ul>
				</div>
			   <div class="text-filter-box" style="display:none;">
					<input data-path="opt_status" type="text" value="0" data-button="#opt_status-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/>
					<button type="button" id="opt_status-search-button"></button>
				</div>
				<div class="text-filter-box">
                    <input data-path="endusername" data-button="#opt_status-search-button" type="text" value="" placeholder="收货方名称" data-control-type="textbox" data-control-name="endusername" data-control-action="filter" />
                   
				</div>
				<div class="text-filter-box">
                    <input data-path="CustomerName" data-button="#opt_status-search-button" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter">
					 
				</div>
				<div class="text-filter-box">
                    <input data-path="rangefilter_fromtime" class="rangeFromModal time" name="FromTime" data-button="#search-button"  type="text" value="" placeholder="发货时段" data-control-type="textbox" data-control-name="rangefilter_fromtime" data-control-action="filter">
				</div>				
				<div class="text-filter-box">
					<!--[if lt IE 10]><div class="jplist-label">制单时段:</div><![endif]-->
					<!--<input readonly data-path="createtime" onclick="GetDateEvent(this, { format: 'YYYY/MM/DD' })"   data-button="#search-button" type="text" value="" placeholder="制单时间" data-control-type="textbox" data-control-name="createtime" data-control-action="filter">--> 
					<input data-path="rangefilter_createtime"  class="rangefilter rangeModal" data-button="#search-button"  type="text" value="" placeholder="制单时段" data-control-type="textbox" data-control-name="rangefilter_createtime" data-control-action="filter">					
					<button type="button" id="search-button">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
                
                 <a class="" role="button" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" onclick="collapseStat(this)" style="display:inline-block;line-height:30px;margin-top:10px;">
					<span rol="img" class="glyphicon glyphicon-menu-down" style="top:2px;margin-right:2px;color:#f27302;"></span><span rol="text" style="color:#666;font-weight:normal;">更多</span>
				</a>
                <div>
                    <button type="button" class="btn btn-default footKeepBtn" style="text-shadow:none;border:1px solid white;" onclick="lotsReceive()" title="批量接收" >批量接收&nbsp;<i class="glyphicon glyphicon-import"></i></button>
                </div>
				<div class="collapse clearfix" id="collapseExample" style="margin-left:238px;">
				    <div class="text-filter-box">
                        <input data-path="Code" data-button="#opt_status-search-button" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
				    </div>
                    <div class="text-filter-box">
                        <input data-path="PactCode" data-button="#opt_status-search-button" type="text" value="" placeholder="合同编号" data-control-type="textbox" data-control-name="PactCode" data-control-action="filter" />
				    </div>
				</div>
                <div class="clearfix"></div>
                
				<!-- 加载数据时显示 -->
				<div class="jplist-hide-preloader jplist-preloader" data-control-type="preloader" data-control-name="preloader" data-control-action="preloader"><img src="/assets/plugins/jpList-master/img/common/ajax-loader-line.gif" alt="加载中..." title="加载中..." /></div>
			</div>
			<div style="min-height:300px;">
				<!-- 异步加载内容 -->
				<div class="list box text-shadow anothertab_martop"></div>
				<!-- no result found -->
				<div class="text-pos box jplist-no-results text-shadow align-center jplist-hidden">
					<p>没有数据</p>
				</div>
			</div>
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-bottom" style="margin: 0 0 20px 0">
				<!--<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>-->
				<div class="jplist-drop-down left" data-control-type="items-per-page-drop-down"	data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true">
					<ul>
						<li><span data-number="5"> 每页 5 个项目 </span></li>
						<li><span data-number="10" data-default="true"> 每页 10 个项目 </span></li>
						<li><span data-number="15"> 每页 15 个项目 </span></li>
						<li><span data-number="50"> 每页 50 个项目 </span></li>
					</ul>
				</div>
				<!-- 分页结果 -->
				<div class="jplist-label"	data-type="{start} - {end} / {all}" data-control-type="pagination-info"	data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true"></div>
			</div> 
        </div>
        </div>
</div> 
<!-- 市内待调度订单 -->
<div id="demo1" class="box jplist demoTab hide">
     <div class="" style="padding-left:15px; padding-right:15px;">
			<!-- 手机自适应按钮 -->
            <div class="tableDiv clearfix">
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
               <p class="mainHtml_tit">市内待调度订单</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="CreateTime" data-order="desc" data-type="date">排序</span></li>
						<li><span data-path="endusername" data-order="asc" data-type="text">收货方名称</span></li>
						<li><span data-path="PactCode" data-order="desc" data-type="text">合同编号</span></li>
					</ul>
				</div>
			    <div class="text-filter-box" style="display:none;">
					<input data-path="opt_status" type="text" value="0" data-button="#opt_status-city_search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/>
					<button type="button" id="opt_status-city_search-button"></button>
				</div>
                <div class="text-filter-box">
                    <input data-path="CustomerName" data-button="#opt_status-city_search-button" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter">
                    
				</div>
                <div class="" style="height:30px;float:left;padding:10px 10px 0px 0px">
                        <input type="text" readonly placeholder="收货地址(省/市/区)" class="city_input inputFocus proCitySelAll"/>
                        <input name="ToProvince" type="hidden" class="edit form-control transparent"  data-path="ToProvince" data-button="#opt_status-city_search-button" data-control-type="textbox" data-control-name="ToProvince" data-control-action="filter">
                        <input name="ToCity" type="hidden" class="edit form-control transparent"  data-path="ToCity" data-button="#opt_status-city_search-button" data-control-type="textbox" data-control-name="ToCity" data-control-action="filter">
                        <input name="ToDistrict" type="hidden" class="edit form-control transparent"  data-path="ToDistrict" data-button="#opt_status-city_search-button" data-control-type="textbox" data-control-name="ToDistrict" data-control-action="filter">                
                          <div class="provinceCityAll" style="top:35px !important;left:-50px !important;">
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
                              <div class="listArea">
                                <ul>
                                  <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                                </ul>
                              </div>
                              <div class="next"><a class="can"></a></div>
                            </div>
                            <div class="provinceAll invis">
                              <div class="pre"><a onclick="provinceAllPre()"></a></div>
                              <div class="listArea">
                                <ul>
                                  <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                                </ul>
                              </div>
                              <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                            </div>
                            <div class="cityAll invis">
                              <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                              <div class="listArea">
                                <ul>
                                  <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                                </ul>
                              </div>
                              <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                            </div>
                            <div class="countyAll invis">
                              <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                              <div class="listArea">
                                <ul>
                                </ul>
                              </div>
                              <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                            </div>
                          </div>
                            </div>
 
				</div>
				<div class="text-filter-box">
                    <input data-path="rangefilter_fromtime" class="rangeFromModal time" name="FromTime" data-button="#search-button"  type="text" value="" placeholder="发货时段" data-control-type="textbox" data-control-name="rangefilter_fromtime" data-control-action="filter">
				</div>					
				<div class="text-filter-box">
                    <input data-path="rangefilter_createtime" class="rangefilter rangeModal" data-button="#city_search-button"  type="text" value="" placeholder="制单时段" data-control-type="textbox" data-control-name="rangefilter_createtime" data-control-action="filter">
                    <button type="button" id="city_search-button">
                      <i class="glyphicon glyphicon-search"></i>
                    </button>
                </div>
                 <a class="" role="button" data-toggle="collapse" href="#collapseExample1" aria-expanded="false" aria-controls="collapseExample" onclick="collapseStat(this)" style="display:inline-block;line-height:30px;margin-top:10px;">
					<span rol="img" class="glyphicon glyphicon-menu-down" style="top:2px;margin-right:2px;color:#f27302;"></span><span rol="text" style="color:#666;font-weight:normal;">更多</span>
				</a>
                <div class="">
                    <button class="edit btn footKeepBtn" title="拼车" onclick="ToOrderCombbined(1)" style="text-shadow:none;">拼车&nbsp;<span class="glyphicon glyphicon-magnet"></span></button>
                </div>
				<div class="collapse clearfix" id="collapseExample1" style="margin-left:238px;">
				    <div class="text-filter-box">
                        <input data-path="endusername" data-button="#opt_status-city_search-button" type="text" value="" placeholder="收货方名称" data-control-type="textbox" data-control-name="endusername" data-control-action="filter" /> 
				    </div>
                    <div class="text-filter-box">
                        <input data-path="Code" data-button="#opt_status-city_search-button" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
				    </div>
                    <div class="text-filter-box">
                        <input data-path="PactCode" data-button="#opt_status-city_search-button" type="text" value="" placeholder="合同编号" data-control-type="textbox" data-control-name="PactCode" data-control-action="filter" />
				    </div>
				</div>
                <div class="clearfix"></div>
                
				<!-- 加载数据时显示 -->
				<div class="jplist-hide-preloader jplist-preloader" data-control-type="preloader" data-control-name="preloader" data-control-action="preloader"><img src="/assets/plugins/jpList-master/img/common/ajax-loader-line.gif" alt="加载中..." title="加载中..." /></div>


			</div>
			<div style="min-height:300px;">
				<!-- 异步加载内容 -->
				<div class="list box text-shadow anothertab_martop"></div>
				<!-- no result found -->
				<div class="text-pos box jplist-no-results text-shadow align-center jplist-hidden">
					<p>没有数据</p>
				</div>
			</div>
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-bottom" style="margin: 0 0 20px 0">
				<!--<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>-->
				<div class="jplist-drop-down left" data-control-type="items-per-page-drop-down"	data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true">
					<ul>
						<li><span data-number="5"> 每页 5 个项目 </span></li>
						<li><span data-number="10"> 每页 10 个项目 </span></li>
						<li><span data-number="15" data-default="true"> 每页 15 个项目 </span></li>
						<li><span data-number="50"> 每页 50 个项目 </span></li>
                        <li><span data-number="100"> 每页 100 个项目 </span></li>
					</ul>
				</div>
				<!-- 分页结果 -->
				<div class="jplist-label"	data-type="{start} - {end} / {all}" data-control-type="pagination-info"	data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true"></div>
			</div>
		</div>
    </div>
</div>
<!-- 长途待调度订单 -->
<div id="demo5" class="box jplist hide demoTab">
    <div class="" style="padding-left:15px; padding-right:15px;">
    <!-- 手机自适应按钮 -->
        <div class="tableDiv clearfix" style="padding-left:15px; padding-right:15px;">
        <div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
        <div class="maintitle_container" style="margin-top:0;">
            <p class="mainHtml_tit">长途待调度订单</p>
        </div>
        <!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="statustime" data-order="desc" data-type="date">排序</span></li>
						<li><span data-path="endusername" data-order="asc" data-type="text">收货方名称</span></li>
						<li><span data-path="PactCode" data-order="desc" data-type="text">合同编号</span></li>
					</ul>
				</div>
			   <div class="text-filter-box" style="display:none;">
					<input data-path="opt_status" type="text" value="0" data-button="#opt_status-long_search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/>
					<button type="button" id="opt_status-long_search-button"></button>
				</div>
				
                <div class="text-filter-box">
                    <input data-path="CustomerName" data-button="#opt_status-long_search-button" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter">
 
				</div>
                <%--<div class="text-filter-box">
                    <input data-path="ToAddress" data-button="#long_search-button" type="text" value="" placeholder="收货地址" data-control-type="textbox" data-control-name="ToAddress" data-control-action="filter">
 
				</div>--%>
                <div class="" style="height:30px;float:left;padding:10px 10px 0px 0px">
                        <input type="text" name="cityName" readonly placeholder="收货地址(省/市/区)" class="city_input inputFocus proCitySelAll"/><!---->
                        <input name="ToProvince" type="hidden" class="edit form-control transparent"  data-path="ToProvince" data-button="#opt_status-long_search-button" data-control-type="textbox" data-control-name="ToProvince" data-control-action="filter">
                        <input name="ToCity" type="hidden" class="edit form-control transparent"  data-path="ToCity" data-button="#opt_status-long_search-button" data-control-type="textbox" data-control-name="ToCity" data-control-action="filter">
                        <input name="ToDistrict" type="hidden" class="edit form-control transparent"  data-path="ToDistrict" data-button="#long_search-button" data-control-type="textbox" data-control-name="ToDistrict" data-control-action="filter">                
                         <div class="provinceCityAll" style="top:35px !important;left:-50px !important;">
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
                              <div class="listArea">
                                <ul>
                                  <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                                </ul>
                              </div>
                              <div class="next"><a class="can"></a></div>
                            </div>
                            <div class="provinceAll invis">
                              <div class="pre"><a onclick="provinceAllPre()"></a></div>
                              <div class="listArea">
                                <ul>
                                  <!-- 					<li><a href="javascript:"  class="current">江西省</a></li> -->
                                </ul>
                              </div>
                              <div class="next"><a class="can" onclick="provinceAllNext()"></a></div>
                            </div>
                            <div class="cityAll invis">
                              <div class="pre"><a onclick="cityAllPre(this)"></a></div>
                              <div class="listArea">
                                <ul>
                                  <!-- 					<li><a href="javascript:"  class="current">南京</a></li> -->
                                </ul>
                              </div>
                              <div class="next"><a class="can" onclick="cityAllNext(this)"></a></div>
                            </div>
                            <div class="countyAll invis">
                              <div class="pre"><a onclick="countyAllPre(this)"></a></div>
                              <div class="listArea">
                                <ul>
                                </ul>
                              </div>
                              <div class="next"><a class="can" onclick="countyAllNext(this)"></a></div>
                            </div>
                          </div>
                            </div>
	                    
				</div>
				<div class="text-filter-box">
                    <input data-path="rangefilter_fromtime" class="rangeFromModal time" name="FromTime" data-button="#search-button"  type="text" value="" placeholder="发货时段" data-control-type="textbox" data-control-name="rangefilter_fromtime" data-control-action="filter">
				</div>	
				<div class="text-filter-box">
                    <input data-path="rangefilter_createtime" class="rangefilter rangeModal" data-button="#long_search-button"  type="text" value="" placeholder="制单时段" data-control-type="textbox" data-control-name="rangefilter_createtime" data-control-action="filter">
                    <button type="button" id="long_search-button">
                      <i class="glyphicon glyphicon-search"></i>
                    </button>
                </div>
                 <a class="" role="button" data-toggle="collapse" href="#collapseExample2" aria-expanded="false" aria-controls="collapseExample" onclick="collapseStat(this)" style="display:inline-block;line-height:30px;margin-top:10px;">
					<span rol="img" class="glyphicon glyphicon-menu-down" style="top:2px;margin-right:2px;color:#f27302;"></span><span rol="text" style="color:#666;font-weight:normal;">更多</span>
				</a>
                <div class="">
                    <button class="edit btn footKeepBtn" title="拼车" onclick="ToOrderCombbined(2)" style="text-shadow:none;">拼车&nbsp;<span class="glyphicon glyphicon-magnet"></span></button>
                </div>
				<div class="collapse clearfix" id="collapseExample2" style="margin-left:238px;">
				        <div class="text-filter-box">
                            <input data-path="endusername" data-button="#opt_status-long_search-button" type="text" value="" placeholder="收货方名称" data-control-type="textbox" data-control-name="endusername" data-control-action="filter" />
				        </div>
                        <div class="text-filter-box">
                            <input data-path="Code" data-button="#opt_status-long_search-button" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
				        </div>
                       <div class="text-filter-box">
                            <input data-path="PactCode" data-button="#opt_status-long_search-button" type="text" value="" placeholder="合同编号" data-control-type="textbox" data-control-name="PactCode" data-control-action="filter" />
				        </div>
				</div>
                <div class="clearfix"></div>
                
				<!-- 加载数据时显示 -->
				<div class="jplist-hide-preloader jplist-preloader" data-control-type="preloader" data-control-name="preloader" data-control-action="preloader"><img src="/assets/plugins/jpList-master/img/common/ajax-loader-line.gif" alt="加载中..." title="加载中..." /></div>

			</div>
			<div style="min-height:300px;">
				<!-- 异步加载内容 -->
				<div class="list box text-shadow anothertab_martop"></div>
				<!-- no result found -->
				<div class="text-pos box jplist-no-results text-shadow align-center jplist-hidden">
					<p>没有数据</p>
				</div>
			</div>
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-bottom" style="margin: 0 0 20px 0">
				<!--<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>-->
				<div class="jplist-drop-down left" data-control-type="items-per-page-drop-down"	data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true">
					<ul>
						<li><span data-number="5"> 每页 5 个项目 </span></li>
						<li><span data-number="10"> 每页 10 个项目 </span></li>
						<li><span data-number="15" data-default="true"> 每页 15 个项目 </span></li>
						<li><span data-number="50"> 每页 50 个项目 </span></li>
                        <li><span data-number="100"> 每页 100 个项目 </span></li>
					</ul>
				</div>
				<!-- 分页结果 -->
				<div class="jplist-label"	data-type="{start} - {end} / {all}" data-control-type="pagination-info"	data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true"></div>
        </div>
    </div>
   </div>
</div>
<!-- 拼车待调度订单 -->
<div id="demo6" class="box jplist hide demoTab">
    <div class="" style="padding-left:15px; padding-right:15px;">
    <!-- 手机自适应按钮 -->
        <div class="tableDiv clearfix" style="padding-left:15px; padding-right:15px;">
        <div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
        <div class="maintitle_container" style="margin-top:0;">
            <p class="mainHtml_tit">拼车待调度订单</p>
        </div>
        <!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="CreateTime" data-order="desc" data-type="date">排序</span></li>
						<li><span data-path="endusername" data-order="asc" data-type="text">收货方名称</span></li>
						<li><span data-path="PactCode" data-order="desc" data-type="text">合同编号</span></li>
					</ul>
				</div>
			    <div class="text-filter-box" style="display:none;">
					<input data-path="opt_status" type="text" value="0" data-button="#opt_status-pin_search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/>
					<button type="button" id="opt_status-pin_search-button"></button>
				</div>
				<div class="text-filter-box">
                    <input data-path="endusername" data-button="#opt_status-pin_search-button" type="text" value="" placeholder="收货方名称" data-control-type="textbox" data-control-name="endusername" data-control-action="filter" />
 
				</div>
                
                <div class="text-filter-box">
                    <input data-path="SupplierName" data-button="#opt_status-pin_search-button" type="text" value="" placeholder="承运方名称" data-control-type="textbox" data-control-name="SupplierName" data-control-action="filter">
 
				</div>
				<!--<div class="text-filter-box">
                    <input data-path="rangefilter_fromtime" class="rangeFromModal time" name="FromTime" data-button="#search-button"  type="text" value="" placeholder="发货时段" data-control-type="textbox" data-control-name="rangefilter_fromtime" data-control-action="filter">
				</div>					-->
				<div class="text-filter-box">
					
					<!--[if lt IE 10]><div class="jplist-label">制单时段:</div><![endif]-->
					<!--<input readonly data-path="createtime"data-button="#" type="text" value="" placeholder="制单时间" data-control-type="textbox" data-control-name="createtime" data-control-action="filter">--> 
					<input data-path="rangefilter_createtime"  class="rangefilter rangeModal" data-button="#pin_search-button"  type="text" value="" placeholder="制单时段" data-control-type="textbox" data-control-name="rangefilter_createtime" data-control-action="filter">
					<button type="button" id="pin_search-button">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
                 <a class="" role="button" data-toggle="collapse" href="#collapseExample3" aria-expanded="false" aria-controls="collapseExample" onclick="collapseStat(this)" style="display:inline-block;line-height:30px;margin-top:10px;">
					<span rol="img" class="glyphicon glyphicon-menu-down" style="top:2px;margin-right:2px;color:#f27302;"></span><span rol="text" style="color:#666;font-weight:normal;">更多</span>
				</a>
				<div class="collapse clearfix" id="collapseExample3" style="margin-left:238px;">
				     <div class="text-filter-box">
                        <input data-path="Code" data-button="#opt_status-pin_search-button" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
				    </div>
                    <div class="text-filter-box">
                        <input data-path="PactCode" data-button="#opt_status-pin_search-button" type="text" value="" placeholder="合同编号" data-control-type="textbox" data-control-name="PactCode" data-control-action="filter" />
				    </div>
				</div>
                <div class="clearfix"></div>
				<!-- 加载数据时显示 -->
				<div class="jplist-hide-preloader jplist-preloader" data-control-type="preloader" data-control-name="preloader" data-control-action="preloader"><img src="/assets/plugins/jpList-master/img/common/ajax-loader-line.gif" alt="加载中..." title="加载中..." /></div>
			</div>

			<div style="min-height:300px;">
				<!-- 异步加载内容 -->
				<div class="list box text-shadow anothertab_martop"></div>
				<!-- no result found -->
				<div class="text-pos box jplist-no-results text-shadow align-center jplist-hidden">
					<p>没有数据</p>
				</div>
			</div>
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-bottom" style="margin: 0 0 20px 0">
				<!--<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>-->
				<div class="jplist-drop-down left" data-control-type="items-per-page-drop-down"	data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true">
					<ul>
						<li><span data-number="5"> 每页 5 个项目 </span></li>
						<li><span data-number="10"> 每页 10 个项目 </span></li>
						<li><span data-number="15" data-default="true"> 每页 15 个项目 </span></li>
						<li><span data-number="50"> 每页 50 个项目 </span></li>
					</ul>
				</div>
				<!-- 分页结果 -->
				<div class="jplist-label"	data-type="{start} - {end} / {all}" data-control-type="pagination-info"	data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true"></div>
        </div>
    </div>
   </div>
</div>
<!-- 待签收订单 -->
<div id="demo2" class="box jplist hide demoTab">
    <div class="" style="padding-left:15px; padding-right:15px;">
    <!-- 手机自适应按钮 -->
        <div class="tableDiv clearfix" style="padding-left:15px; padding-right:15px;">
        <div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
        <div class="maintitle_container" style="margin-top:0;">
            <p class="mainHtml_tit">待签收订单</p>
        </div>
        <!-- 操作面板 -->
        <div class="jplist-panel box panel-top min_height">
            <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
	        <div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
		        <ul>
			        <li><span data-path="CreateTime" data-order="desc" data-type="date">排序</span></li>
			        <li><span data-path="endusername" data-order="asc" data-type="text">收货方名称</span></li>
			        <li><span data-path="PactCode" data-order="desc" data-type="text">合同编号</span></li>
		        </ul>
	        </div>
            <div class="text-filter-box" style="display:none;">
					<input data-path="opt_status" type="text" value="0" data-button="#opt_status-Qs_search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/>
					<button type="button" id="opt_status-Qs_search-button"></button>
				</div>
	        <div class="text-filter-box">
                <input data-path="endusername" data-button="#opt_status-Qs_search-button" type="text" value="" placeholder="收货方名称" data-control-type="textbox" data-control-name="endusername" data-control-action="filter" />
              
	        </div>
            
            <div class="text-filter-box">
                <input data-path="CustomerName" data-button="#opt_status-Qs_search-button" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter">
            
	        </div>
				<div class="text-filter-box">
                    <input data-path="rangefilter_fromtime" class="rangeFromModal time" name="FromTime" data-button="#search-button"  type="text" value="" placeholder="发货时段" data-control-type="textbox" data-control-name="rangefilter_fromtime" data-control-action="filter">
				</div>		        
				<div class="text-filter-box">
					
					<!--[if lt IE 10]><div class="jplist-label">制单时段:</div><![endif]-->
					<!--<input readonly data-path="createtime" onclick="GetDateEvent(this, { format: 'YYYY/MM/DD' })"   data-button="#Qs_search-button" type="text" value="" placeholder="制单时间" data-control-type="textbox" data-control-name="createtime" data-control-action="filter">--> 
					<input data-path="rangefilter_createtime"  class="rangefilter rangeModal"  data-button="#Qs_search-button" type="text" value="" placeholder="制单时段" data-control-type="textbox" data-control-name="rangefilter_createtime" data-control-action="filter">					
					<button type="button" id="Qs_search-button">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
             <a class="" role="button" data-toggle="collapse" href="#collapseExample4" aria-expanded="false" aria-controls="collapseExample" onclick="collapseStat(this)" style="display:inline-block;line-height:30px;margin-top:10px;">
				<span rol="img" class="glyphicon glyphicon-menu-down" style="top:2px;margin-right:2px;color:#f27302;"></span><span rol="text" style="color:#666;font-weight:normal;">更多</span>
			</a>
			<div class="collapse clearfix" id="collapseExample4" style="margin-left:238px;">
				 <div class="text-filter-box">
                    <input data-path="Code" data-button="#opt_status-Qs_search-button" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
	            </div>
                <div class="text-filter-box">
                    <input data-path="PactCode" data-button="#opt_status-Qs_search-button" type="text" value="" placeholder="合同编号" data-control-type="textbox" data-control-name="PactCode" data-control-action="filter" />
				</div>
			</div>
            <div class="clearfix"></div>
	        <!-- 加载数据时显示 -->
	        <div class="jplist-hide-preloader jplist-preloader" data-control-type="preloader" data-control-name="preloader" data-control-action="preloader"><img src="/assets/plugins/jpList-master/img/common/ajax-loader-line.gif" alt="加载中..." title="加载中..." /></div>
        </div>
        <div style="min-height:300px;">
	        <!-- 异步加载内容 -->
	        <div class="list box text-shadow anothertab_martop"></div>
	        <!-- no result found -->
	        <div class="text-pos box jplist-no-results text-shadow align-center jplist-hidden">
		        <p>没有数据</p>
	        </div>
        </div>
        <!-- 手机自适应按钮 -->
        <div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
        <!-- 操作面板 -->
        <div class="jplist-panel box panel-bottom" style="margin: 0 0 20px 0">
	        <!--<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>-->
	        <div class="jplist-drop-down left" data-control-type="items-per-page-drop-down"	data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true">
		        <ul>
			        <li><span data-number="5"> 每页 5 个项目 </span></li>
			        <li><span data-number="10"> 每页 10 个项目 </span></li>
			        <li><span data-number="15" data-default="true"> 每页 15 个项目 </span></li>
			        <li><span data-number="50"> 每页 50 个项目 </span></li>
		        </ul>
	        </div>
	        <!-- 分页结果 -->
	        <div class="jplist-label"	data-type="{start} - {end} / {all}" data-control-type="pagination-info"	data-control-name="paging" data-control-action="paging"></div>
	        <!-- 分页操作 -->
	        <div class="jplist-pagination" data-control-type="pagination" data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true"></div>
        </div>
    </div>
   </div>
</div>
<!-- 待回单订单 -->
<div id="demo3" class="box jplist demoTab hide">
    <div class="" style="padding-left:15px; padding-right:15px;">
			<!-- 手机自适应按钮 -->
            <div class="tableDiv clearfix">
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
               <p class="mainHtml_tit">待回单订单</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="CreateTime" data-order="desc" data-type="date">排序</span></li>
						<li><span data-path="endusername" data-order="asc" data-type="text">收货方名称</span></li>
						<li><span data-path="PactCode" data-order="desc" data-type="text">合同编号</span></li>
					</ul>
				</div>
			    <div class="text-filter-box" style="display:none;">
					<input data-path="opt_status" type="text" value="0" data-button="#opt_status-Hd_search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/>
					<button type="button" id="opt_status-Hd_search-button"></button>
				</div>
				<div class="text-filter-box">
                    <input data-path="endusername" data-button="#opt_status-Hd_search-button" type="text" value="" placeholder="收货方名称" data-control-type="textbox" data-control-name="endusername" data-control-action="filter" />
                    
				</div>
               
                <div class="text-filter-box">
                    <input data-path="CustomerName" data-button="#opt_status-Hd_search-button" type="text" value="" placeholder="客户名称" data-control-type="textbox" data-control-name="CustomerName" data-control-action="filter">
                    
				</div>
				<div class="text-filter-box">
                    <input data-path="rangefilter_fromtime" class="rangeFromModal time" name="FromTime" data-button="#search-button"  type="text" value="" placeholder="发货时段" data-control-type="textbox" data-control-name="rangefilter_fromtime" data-control-action="filter">
				</div>					
				<div class="text-filter-box">
					
					<!--[if lt IE 10]><div class="jplist-label">制单时段:</div><![endif]-->
					<!--<input readonly data-path="createtime" onclick="GetDateEvent(this, { format: 'YYYY/MM/DD' })"   data-button="#Hd_search-button" type="text" value="" placeholder="制单时间" data-control-type="textbox" data-control-name="createtime" data-control-action="filter">--> 
					<input data-path="rangefilter_createtime"  class="rangefilter rangeModal" data-button="#Hd_search-button" type="text" value="" placeholder="制单时段" data-control-type="textbox" data-control-name="rangefilter_createtime" data-control-action="filter">
					<button type="button" id="Hd_search-button">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
                 <a class="" role="button" data-toggle="collapse" href="#collapseExample5" aria-expanded="false" aria-controls="collapseExample" onclick="collapseStat(this)" style="display:inline-block;line-height:30px;margin-top:10px;">
					<span rol="img" class="glyphicon glyphicon-menu-down" style="top:2px;margin-right:2px;color:#f27302;"></span><span rol="text" style="color:#666;font-weight:normal;">更多</span>
				</a>
				<div class="collapse clearfix" id="collapseExample5" style="margin-left:238px;">
				     <div class="text-filter-box">
                        <input data-path="Code" data-button="#opt_status-Hd_search-button" type="text" value="" placeholder="单据编号" data-control-type="textbox" data-control-name="Code" data-control-action="filter" />
				    </div>
                    <div class="text-filter-box">
                        <input data-path="PactCode" data-button="#opt_status-Hd_search-button" type="text" value="" placeholder="合同编号" data-control-type="textbox" data-control-name="PactCode" data-control-action="filter" />
				    </div>
				</div>
                <div class="clearfix"></div>
				<!-- 加载数据时显示 -->
				<div class="jplist-hide-preloader jplist-preloader" data-control-type="preloader" data-control-name="preloader" data-control-action="preloader"><img src="/assets/plugins/jpList-master/img/common/ajax-loader-line.gif" alt="加载中..." title="加载中..." /></div>
			</div>
			<div style="min-height:300px;">
				<!-- 异步加载内容 -->
				<div class="list box text-shadow anothertab_martop"></div>
				<!-- no result found -->
				<div class="text-pos box jplist-no-results text-shadow align-center jplist-hidden">
					<p>没有数据</p>
				</div>
			</div>
			<!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-bottom" style="margin: 0 0 20px 0">
				<!--<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>-->
				<div class="jplist-drop-down left" data-control-type="items-per-page-drop-down"	data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true">
					<ul>
						<li><span data-number="5"> 每页 5 个项目 </span></li>
						<li><span data-number="10"> 每页 10 个项目 </span></li>
						<li><span data-number="15" data-default="true"> 每页 15 个项目 </span></li>
						<li><span data-number="50"> 每页 50 个项目 </span></li>
					</ul>
				</div>
				<!-- 分页结果 -->
				<div class="jplist-label"	data-type="{start} - {end} / {all}" data-control-type="pagination-info"	data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true"></div>
			</div>
		</div>
    </div>
</div>
<!-- 待审核承运方 -->
<div id="demo4" class="box jplist demoTab hide">
    <div class="" style="padding-left:15px; padding-right:15px;">
			<!-- 手机自适应按钮 -->
            <div class="tableDiv clearfix">
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <div class="maintitle_container">
               <p class="mainHtml_tit">待审核承运方</p>
            </div>
			<!-- 操作面板 -->
			<div class="jplist-panel box panel-top min_height">
                <button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>
				<%--<div class="jplist-drop-down" data-control-type="items-per-page-drop-down" data-control-name="paging" data-control-action="paging">
					<ul>
						<li><span data-number="5"> 每页 5 个项目 </span></li>
						<li><span data-number="10"> 每页 10 个项目 </span></li>
						<li><span data-number="15" data-default="true"> 每页 15 个项目 </span></li>
						<li><span data-number="50"> 每页 50 个项目 </span></li>
					</ul>
				</div>--%>
				<div class="jplist-drop-down" data-control-type="sort-drop-down" data-control-name="sort" data-control-action="sort">
					<ul>
						<li><span data-path="id" data-order="asc" data-type="number">排序</span></li>
						<li><span data-path="OwnerCompanyName" data-order="asc" data-type="text">邀请公司名称</span></li>
					</ul>
				</div>
			    <div class="text-filter-box" style="display:none;">
					<input data-path="opt_status" type="text" value="0" data-button="#opt_status-name-search-button" data-control-type="textbox" data-control-name="opt_status" data-control-action="filter"/>
					<button type="button" id="opt_status-name-search-button"></button>
				</div>
				<div class="text-filter-box">
                    <!--[if lt IE 10]><div class="jplist-label">姓名:</div><![endif]-->
                    <input data-path="OwnerCompanyName" data-button="#name-search-button" type="text" value="" placeholder="邀请公司名称" data-control-type="textbox" data-control-name="OwnerCompanyName" data-control-action="filter"> 
                    <button type="button" id="name-search-button"><i class="glyphicon glyphicon-search"></i></button>
				</div>
				<%--<!-- 分页结果 -->
				<div class="jplist-label" data-type="第 {current} 页，共 {pages} 页" data-control-type="pagination-info" data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging" data-control-action="paging"></div>
				<!-- 加载数据时显示 -->--%>
				<div class="jplist-hide-preloader jplist-preloader" data-control-type="preloader" data-control-name="preloader" data-control-action="preloader"><img src="/assets/plugins/jpList-master/img/common/ajax-loader-line.gif" alt="加载中..." title="加载中..." /></div>
			</div>
			<div style="min-height:300px;">
				<!-- 异步加载内容 -->
				<div class="list box text-shadow anothertab_martop"></div>
				<!-- no result found -->
				<div class="text-pos box jplist-no-results text-shadow align-center jplist-hidden">
					<p>没有数据</p>
				</div>
			</div>
            <!-- 手机自适应按钮 -->
			<div class="jplist-ios-button"><i class="fa fa-sort"></i>操作</div>
            <!-- 操作面板 -->
			<div class="jplist-panel box panel-bottom" style="margin: 0 0 20px 0">
				<!--<button type="button" class="jplist-reset-btn" data-control-type="reset" data-control-name="reset" data-control-action="reset">重置 &nbsp;<i class="glyphicon glyphicon-refresh"></i></button>-->
				<div class="jplist-drop-down left" data-control-type="items-per-page-drop-down"	data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true">
					<ul>
						<li><span data-number="5"> 每页 5 个项目 </span></li>
						<li><span data-number="10"> 每页 10 个项目 </span></li>
						<li><span data-number="15" data-default="true"> 每页 15 个项目 </span></li>
						<li><span data-number="50"> 每页 50 个项目 </span></li>
					</ul>
				</div>
				<!-- 分页结果 -->
				<div class="jplist-label"	data-type="{start} - {end} / {all}" data-control-type="pagination-info"	data-control-name="paging" data-control-action="paging"></div>
				<!-- 分页操作 -->
				<div class="jplist-pagination" data-control-type="pagination" data-control-name="paging"	data-control-action="paging" data-control-animate-to-top="true"></div>
			</div>
		</div>
    </div>
</div>
<div class="clear"></div>
<!--<><><><><><><><><><><><><><><><><><><><><><><><><><> 数据列表结尾 <><><><><><><><><><><><><><><><><><><><><><><><><><>-->				
<!--通用页尾开始-->
<!--#include file="/Controls/TMS/footer.aspx"-->
<!--通用页尾结尾-->

<script type="text/javascript">
 
    var resizeCols = null;
    var reqeustDone = function ()
    {		/*所有JS加载完成以后执行*/
        if ( typeof ( initHeader ) != "undefined" ) initHeader();					/*初始化页面通用头部*/
        if ( typeof ( initFooter ) != "undefined" ) initFooter();					/*初始化页面通用底部*/

        $('input.rangefilter').on( "click", function(){
          $("div#rangeModal").modal( "show" );
        } );
 
        $('input.rangeFromModal').on( "click", function(){
        	$("div#rangeFromModal").modal( "show" );
           	$('.fahuo').text('发货时段');        	
        } );

        var _myEvents = new NSF.System.Data.Grid();
        _myEvents.Initialize("/", "TrackDetail", $("div[name='TrackDetail']").attr("view-id"), $("div[name='TrackDetail']"));   //各订单对应数目
        loadList();     //初始化列表数据
    }


    var _jsUrl = "<%=MinifyUrl("ListJs")%>";
    
</script>
<script src="/assets/js/jquery-1.11.1.min.js"></script>
<script src="city/js/public.js"></script>
<!--#include file="/Controls/TMS/JS.aspx"-->
<script src="/assets/plugins/jquery/colResizable-1.5.min.js"></script>
<script src="/assets/request_minify.js"></script>
<style type="text/css">
    .active .orangeO{color:white}
    .navTab a{width:auto;}
    .tableDiv p{border-left:0px;}
    .demoTab .jptable tr td button {margin:-3px 5px 0; padding:0;}
    .demoTab .panel-top {border-top:1px solid #ddd; padding-top:15px; padding-bottom:0;}
    .demoTab .maintitle_container {margin-top:0;}
    .shTable tr td:first-child {
        width:2% !important;
    }
    #demo .jptable tr td:first-child,#demo1 .jptable tr td:first-child,#demo5 .jptable tr td:first-child {
        width:60px !important;
    }
    .gou-btn {
        width:12px;height:12px;border:1px solid #ddd;display:inline-block;position:relative;top:1px;margin-left:3px;margin-right:3px;
    }
    #myModal label {
        font-size:12px;
        color:#333;
    }
</style>
</body>
</html>
