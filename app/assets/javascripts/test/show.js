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
		  url: "/subjects/"+id,
		  dataType: "json",
		  success: function(result){
			  var subdata = result.subject
			  $(".panel-heading .sub").html(subdata.name);
			  $.ajax({
				  type: "GET",
				  url: "/questionsets",
				  dataType: "json",
				  success: function(result){
					  var testdata = result.questionsets;
   				  $.each(testdata, function (i, item) {
   					  if(item.subject_id == subdata.id){
	     				  var row = '<button class="alert alert-primary mr-3 btn-lg btn-block qsetshow" value="'+item.id+'" style="font-size:25px;"role="alert">'+item.name+'</button>';
	     				  $(".panel .panel-body").append(row);
	     			  }
   				  });
   			  }
   			});   
   		}
   	});		
	},	
	linkShowNewDelete:function(){
	  $(document).on('click','.branchedit', function(){
    	var id= $(this).val();
	    window.open("/branches/"+id+"/edit","_self")
                              });
    $(document).on('click','.atmedit', function(){
    	var id= $(this).val();
	    window.open("/atms/"+id+"/edit","_self")
    });		
    $(document).on('click','.branchshow', function(){
      var id= $(this).val();
      window.open("/branches/"+id,"_self")
    });
    $(document).on('click','.atmshow', function(){
      var id= $(this).val();    
      window.open("/atms/"+id,"_self")
    });
    $(".bankshow #branchnew").click(function(){
      $(".bankshow #addbranch").toggle();
    });
    $(".bankshow #atmnew").click(function(){
     	$(".bankshow #addatm").toggle();
    	location.href="#addatm";
    });
    $(document).on('click','.branchdelete', function(){
      if(confirm("are you sure!")){
  		  var id=$(this).val();
	  	  $.ajax({
		    	type: "DELETE",
		    	url: "/branches/"+id,
		    	dataType: "json",
			    success: function(result){
				    $("#branch"+id).remove();
			    }
		    });
	    };
    });
    $(document).on('click','.atmdelete', function(){
      if(confirm("are you sure!")){
		    var id=$(this).val();
		    $.ajax({
			    type: "DELETE",
			    url: "/atms/"+id,
			    dataType: "json",
			    success: function(result){
				    $("#atm"+id).remove();
			    }
		    });
	    };
    });
  },
}