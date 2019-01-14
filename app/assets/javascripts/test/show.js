var Showtest = Showtest || {}
Showtest.pageLoaded = function(){
  this.initialize();
}
Showtest.pageLoaded.prototype= {
  initialize:function(){
    this.getData();
    this.linkShowNewDelete();
  },
  getData:function(){
  	var url=window.location.href;
  	var id = url.substring(url.lastIndexOf('/') + 1);
	  $.ajax({
     	type: "GET",
		  url: "/tests/"+id,
		  dataType: "json",
		  success: function(result){
			  var subdata = result.subject
			  $(".panel-heading .sub").html(subdata.name);
			  $.ajax({
				  type: "GET",
				  url: "/qset",
				  dataType: "json",
				  success: function(result){
					  var testdata = result.questionsets;
   				  $.each(testdata, function (i, item) {
   					  if(item.subject_id == subdata.id && item.is_active==true){
	     				  var row = '<button class=" bg-dark mr-3 btn-lg btn-block qsetshow" value="'+item.id+'" style="font-size:25px;"role="alert">'+item.name+'</button>';
	     				  $(".panel .panel-body").append(row);
	     			  }
   				  });
   			  }
   			});   
   		}
   	});		
	},	
	linkShowNewDelete:function(){
    $(document).on('click','.qsetshow', function(){
      var id= $(this).val();
      window.open("/qsetshow/"+id,"_self")
    });
    $(document).on('click','.logout', function(){
      if(confirm("are you sure..? logout")){
        $.ajax({
          type: 'GET',
          url:'/logout',
          dataType:'json',
          success: function(result){
            window.open("/login","_self")
          }
        });
      };
    });
    $(document).on('click','.link', function(){
      window.open("/tests","_self")
    });
  }
}