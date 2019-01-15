var Subjectshow = Subjectshow || {}
Subjectshow.pageLoaded = function(){
  this.initialize();
}
Subjectshow.pageLoaded.prototype= {
  initialize:function(){
    this.subid;
    this.qsetid;
    this.getData();
    this.postData();
    this.updateData();
    this.linkShowDeleteNew(); 
    this.status();   
  },
  getData:function(){
    $.ajax({
      type: "GET",
      url: window.location.href,
      dataType: "json",
      success: function(result){
        var subdata = result.subject
        $(".tray .headtop").html(subdata.name);
        subid=subdata.id;
        $.ajax({
          type: "GET",
          url: "/questionsets",
          dataType: "json",
          success: function(result){  
            var qsetdata = result.questionsets;
            var c=0;
            $.each(qsetdata, function (i, item) {
              if(item.subject_id == subdata.id){
                c++;
                if(item.is_active==true){
                  var status='<div class="btn-group"><button type="button" class="btn btn-success btn-xs dropdown-toggle" data-toggle="dropdown" aria-expanded="true">Active<i class="glyphicon glyphicon-chevron-down"></i></button><ul  class="dropdown-menu success" role="menu"><li><button style="border:none;background: none;color: inherit;border: none;padding: 0;font: inherit; cursor: pointer;outline: inherit;" value="'+item.id+'"class="deactivate">Deactivate</button></li></ul></div>';
                }
                else{
                  status='<div class="btn-group"><button type="button" value="'+item.id+'" class="btn btn-danger btn-xs dropdown-toggle" data-toggle="dropdown" aria-expanded="true">Inactive<i class="glyphicon glyphicon-chevron-down"></i></button><ul  class="dropdown-menu danger" role="menu"><li><button style="border:none;background: none;color: inherit;border: none;padding: 0;font: inherit;cursor: pointer;  outline: inherit;" value="'+item.id+'"class="activate">Activate</button></li></ul></div>';
                }
              var row = '<tr id="subject'+item.id+'"><td>'+c+'</td><td>'+item.name+'</td><td>'+item.level+'</td><td>'+item.no_ques+'</td><td>'+item.time+'</td><td>'+status+'</td><td>'+item.marks_per_ques+'</td><td><button class="btn btn-xs btn-primary btn-block show"value="'+item.id+'">Show</button></td><td><button class="btn btn-xs btn-info btn-block edit"value="'+item.id+'">Edit</button></td><td><button class="btn btn-xs btn-danger btn-block delete"value="'+item.id+'">Delete</button></td></tr>';
              $(".table #Subject").append(row);
              }
            });
          }
        });   
      }
    });      
  },  
  postData:function(){
    $(".col-sm-3 .addsub").click(function(){
      var name= $(".col-sm-5 #name1").val();
      var level= $(".col-sm-5 #level1").val();
      var no_ques= $(".col-sm-5 #NoOfQues1").val();
      var time= $(".col-sm-5 #time1").val();
      var marks= $(".col-sm-5 #marks1").val();
      var status= $(".col-sm-5 #status1").val();
      if(status=='Active'){
        status=true;
      }
      else{
        status=false;
      }
      var questionset={questionset:{"subject_id":subid,"name":name,"level":level,"no_ques":no_ques,"time":time,"marks_per_ques":marks,"is_active":status}};
      $.ajax({
        type: "POST",
        url: "/questionsets",
        format: "JSON",
        data: questionset,
        success:function(result){
          window.open("/subjects/"+subid,"_self")
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
      $(".tray #spy3").hide();
      qsetid = $(this).val();
      $.ajax({
        type:"GET",
        url:"/questionsets/"+qsetid,
        dataType:"json",
        success:function(result){
          var qsetdata = result.questionset;
          $(".col-sm-5 #name").val(qsetdata.name);
          $(".col-sm-5 #level").val(qsetdata.level);
          $(".col-sm-5 #NoOfQues").val(qsetdata.no_ques);
          $(".col-sm-5 #time").val(qsetdata.time);
          $(".col-sm-5 #marks").val(qsetdata.marks_per_ques);
          if(qsetdata.is_active==true){
            var sts='Active';
          }
          else{
            sts='Inactive';
          }
          $(".col-sm-5 #status").val(sts);
        }
      });
    });
    $(".col-sm-3 .update").click(function(){
      var name= $(".col-sm-5 #name").val();
      var level= $(".col-sm-5 #level").val();
      var no_ques= $(".col-sm-5 #NoOfQues").val();
      var time= $(".col-sm-5 #time").val();
      var marks= $(".col-sm-5 #marks").val();
      var status= $(".col-sm-5 #status").val();
      if(status=="Active"){
        status="true";
      }
      else{
        status="false";
      }
      var questionset={questionset:{"subject_id":subid,"name":name,"level":level,"no_ques":no_ques,"time":time,"marks_per_ques":marks,"is_active":status}};
      $.ajax({
        type: "PUT",
        url: "/questionsets/"+qsetid,
        format: "JSON",
        data: questionset,
        success:function(result){
          window.open("/subjects/"+subid,"_self");
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
  status:function(){
    $(document).on('click','.activate',function(){
      var sid= $(this).val();
      var status={questionset:{"is_active":true }};
     $.ajax({
        type: "PUT",
        url: "/questionsets/"+sid,
        format: "JSON",
        data: status,
        success:function(result){
          window.open("/subjects/"+subid,"_self");
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
    $(document).on('click','.deactivate',function(){
      var sid= $(this).val();
      var status={questionset:{"is_active":false }};
     $.ajax({
        type: "PUT",
        url: "/questionsets/"+sid,
        format: "JSON",
        data: status,
        success:function(result){
          window.open("/subjects/"+subid,"_self");
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
      window.open("/questionsets/"+id,"_self")
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
          url: "/questionsets/"+id,
          dataType: "json",
          success: function(result){
            $("#subject"+id).remove();
            // window.open("/subjects/"+subid,"_self")
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