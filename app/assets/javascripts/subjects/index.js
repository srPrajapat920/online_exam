var Subjects = Subjects || {}
Subjects.pageLoaded = function(){
  this.initialize();
}
Subjects.pageLoaded.prototype= {
  initialize:function(){
    this.subid;
    this.getData();
    this.postData();
    this.updateData();
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
          var i = i+1;
     		  var row = '<tr id="subject'+item.id+'"><td>'+i+'</td><td>'+item.name+'</td><td><button class="btn btn-xs btn-primary btn-block show"value="'+item.id+'">Show</button></td><td><button class="btn btn-xs btn-info btn-block edit"value="'+item.id+'">Edit</button></td><td><button class="btn btn-xs btn-danger btn-block delete"value="'+item.id+'">Delete</button></td></tr>';
          $(".table #Subject").append(row);
   		  });
 		  },
 		  error: function (result) {
        alert("Error");
      }
    }); 
    $("#edit").hide();  
    $("#new").hide(); 
    $(".col-sm-8 .update").hide(); 
	},
  postData:function(){
    $(".col-sm-8 .addsub").click(function(){
      var name= $(".col-sm-8 .name1").val();
      var sub={subject:{"name":name}};
      $.ajax({
        type: "POST",
        url: "/subjects/",
        format: "JSON",
        data: sub,
        success:function(result){
          $(".tray #spy3").show();
          window.open("/subjects","_self")
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
  updateData:function(){  
    $(document).on('click','.edit',function(){
      $("#edit").show();
      $("#new").hide();
      $(".tray #spy3").hide();
      $(".col-sm-8 .update").show();
      $(".col-sm-8 .addsub").hide();
       subid = $(this).val();
      $.ajax({
        type:"GET",
        url:"/subjects/"+subid,
        dataType:"json",
        success:function(result){
          var subdata = result.subject;
          $(".col-sm-8 .name2").val(subdata.name);
        }
      });
    });
    $(".col-sm-8 .update").click(function(){
      var name= $(".col-sm-8 .name2").val();
      var sub={subject:{"name":name}};
      $.ajax({
        type: "PUT",
        url: "/subjects/"+subid,
        format: "JSON",
        data: sub,
        success:function(result){
          window.open("/subjects","_self");
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
    $(document).on('click','.show', function(){
      var id= $(this).val();
      window.open("/subjects/"+id,"_self")
    });
    $(".hidden-xs #newsub").click(function(){
      $(".tray #spy3").hide();
      $("#new").show();
      $("#edit").hide();    
    });
    $(".mw20").click(function(){
      $("#edit").hide();
      $("#new").hide();
      $(".tray #spy3").show();
    });
    $(document).on('click','.delete', function(){
      if(confirm("are you sure!")){
        var id=$(this).val();
        $.ajax({
          type: "DELETE",
          url: "/subjects/"+id,
          dataType: "json",
          success: function(result){
            $("#subject"+id).remove();
            // window.open("/subjects","_self")
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