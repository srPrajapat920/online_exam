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
 		  url: "/tests",
 		  dataType: "json",
 		  success: function(result){
        var data = result.subjects;
   		  $.each(data, function (i, item) {
     		  var row = '<button class="subshow ml20 " value="'+item.id+'" style=" all: unset; display:inline-block;"><div class="panel panel-tile bg-dark text-center br-a br-light"><div class="panel-body "><i class="glyphicon glyphicon-book text-muted fs45 br64 bg-dark dark p15 ph20 mt10"></i><h3>'+item.name+'</h3></div></div></button>';
          $(".data").append(row);
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
  },
}