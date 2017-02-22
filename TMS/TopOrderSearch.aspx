<!DOCTYPE html>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>送货单搜索-<%=NDS.Kits.Config.Instance.WebsiteParameters("ProductName")%></title>
	<script src="/assets/js/jquery-1.11.1.min.js"></script>
	<script src="/assets/NSF/js/NSF.0.0.4.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<head>
		<title>送货单搜索</title>
	</head>
	<style>
		.sosokuang{
			margin-left: 42%;
			margin-top: 250px;
		}
		input::-webkit-input-placeholder{
			color: black;
		}
		input{
			border:1px solid black;
		}
	</style>
	<body>
		<div class="sosokuang">
	 		<input type="text" placeholder="请输入合同编号">
	 		<button type="button" onclick="searchorder()">搜索</button>
	 	</div>
	</body>
	<script>
		function searchorder(){
			var orderid = $("input").val().trim();

			var vml =
		 '[{"namespace":"protocol","cmd":"data","version":1,"id":"tms_0223","paras":[{"name":"id","value":"' +orderid+ '"}]}]';
				
				NSF.System.Network.Ajax('/Portal.aspx',
					vml,
					'POST',
					false,
					function(result, data) {
						if(result) {
							if(data[0].rs==""){
								alert("订单号不匹配！");
							}else{
								window.open( "TopOrderPrint2.aspx?orderid="+orderid );
							}
						}
					})
		}
	</script>
</html>