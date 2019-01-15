var Users = Users || {}
Users.pageLoaded = function(){
  this.initialize();
}
Users.pageLoaded.prototype= {
  initialize:function(){
    this.getData();
    this.admin();
    this.linkShowDeleteNew();    
  },
  getData:function() {
	  $.ajax({
 		  type: "GET",
 		  url: "/users",
 		  dataType: "json",
 		  success: function(result){   
        var data = result.users;
   		  $.each(data, function (i, item) {
          if(item.admin==true){
            var status='<div class="btn-group"><button type="button" class="btn btn-success btn-xs dropdown-toggle" data-toggle="dropdown" aria-expanded="true">Admin<i class="glyphicon glyphicon-chevron-down"></i></button><ul  class="dropdown-menu success" role="menu"><li><button style="border:none;background: none;color: inherit;border: none;padding: 0;font: inherit; cursor: pointer;outline: inherit;" value="'+item.id+'"class="user">User</button></li></ul></div>';
          }
          else{
            status='<div class="btn-group"><button type="button" value="'+item.id+'" class="btn btn-info btn-xs dropdown-toggle" data-toggle="dropdown" aria-expanded="true">User<i class="glyphicon glyphicon-chevron-down"></i></button><ul  class="dropdown-menu danger" role="menu"><li><button style="border:none;background: none;color: inherit;border: none;padding: 0;font: inherit;cursor: pointer;  outline: inherit;" value="'+item.id+'"class="admin">Admin</button></li></ul></div>';
          }
          var i = i+1;
     		  var row = '<tr id="user'+item.id+'"><td>'+i+'</td><td>'+item.username+'</td><td>'+item.email_id+'</td><td>'+item.level+'</td><td>'+status+'</td><td>'+item.contact_no+'</td><td><button class="btn btn-xs btn-danger btn-block delete"value="'+item.id+'">Delete</button></td></tr>';
          $(".table #User").append(row);
   		  });
 		  },
 		  error: function (result) {
        alert("Error");
      }
    }); 
	},
  admin:function(){
    $(document).on('click','.admin',function(){
      var sid= $(this).val();
      alert(sid);
      var status={"admin":true};
     $.ajax({
        type: "PATCH",
        url: "/users/"+sid,
        format: "JSON",
        data: status,
        success:function(result){
          window.open("/users","_self");
          $("#spy3 .newsub").hide();
        },
        error:function (jqXHR, textStatus, errorThorwn){
          var msg = JSON.stringify(jqXHR.responseJSON.errors);
          msg = msg.replace(/[{()}]/g,"").replace(/[["]/g,'').replace(/]/g,'').replace(/:/g,'-')
          $.notify({
            icon: 'glyphicon glyphicon-warning-sign',
            message:msg,
            target:'_blank',
          },{
            element:'body',
            placement:{
              form:"top",
              align:"right"
            },
            type:"danger",
            allow:"right"
          });
        }
      });
    });
    $(document).on('click','.user',function(){
      var sid= $(this).val();
      var status={"admin":false };
     $.ajax({
        type: "PATCH",
        url: "/users/"+sid,
        format: "JSON",
        data: status,
        success:function(result){
          window.open("/users","_self");
          $("#spy3 .newsub").hide();
        },
        error:function (jqXHR, textStatus, errorThorwn){
          var msg = JSON.stringify(jqXHR.responseJSON.errors);
          msg = msg.replace(/[{()}]/g,"").replace(/[["]/g,'').replace(/]/g,'').replace(/:/g,'-')
          $.notify({
            icon: 'glyphicon glyphicon-warning-sign',
            message:msg,
            target:'_blank',
          },{
            element:'body',
            placement:{
              form:"top",
              align:"right"
            },
            type:"danger",
            allow:"right"
          });
        }
      });
    });
  },
  linkShowDeleteNew:function() {
    $(document).on('click','.delete', function(){
      if(confirm("are you sure!")){
        var id=$(this).val();
        $.ajax({
          type: "DELETE",
          url: "/users/"+id,
          dataType: "json",
          success: function(result){
            $("#user"+id).remove();
            // window.open("/users","_self")
          }
        });
      };
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
    $(document).on('click','.subjects', function(){
      window.open("/subjects","_self")
    });
    $(document).on('click','.exams', function(){
      window.open("/exams","_self")
    });
    $(document).on('click','.users', function(){
      window.open("/users","_self")
    });
    $(document).on('click','.link', function(){
      window.open("/tests","_self")
    });
  },
}