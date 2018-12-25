var Home = Home || {}
Home.pageLoaded = function(){
  this.initialize();
}
Home.pageLoaded.prototype= {
  initialize:function(){
    this.getData();
    this.linkShowDeleteNew();    
  },
  getData:function() {
	  $.ajax({
 		  type: "GET",
 		  url: "/subjects",
 		  dataType: "json",
 		  success: function(result){
        var data = result.subjects;
   		  $.each(data, function (i, item) {
     		  var row = '<button class="alert alert-primary mr-3 subshow" value="'+item.id+'" style="font-size:25px;"role="alert">'+item.name+'</button>';
          $(".panel .panel-body").append(row);
   		  });
 		  },
 		  error: function (result) {
        alert("Error");
      }
    });     
	},
  linkShowDeleteNew:function() {
    $(document).on('click','.subshow', function(){
      var id= $(this).val();
      window.open("/tests/"+id,"_self")
    });
    
  },
}