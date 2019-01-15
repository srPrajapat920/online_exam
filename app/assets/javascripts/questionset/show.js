var Question = Question || {}
Question.pageLoaded = function(){
  this.initialize();
}
Question.pageLoaded.prototype= {
  initialize:function(){
    this.qsetid;
    this.qid;
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
        var qsetdata = result.questionset
        $(".tray .headtop").html(qsetdata.name);
        qsetid=qsetdata.id;
        $.ajax({
          type: "GET",
          url: "/questions",
          dataType: "json",
          success: function(result){  
            var qdata = result.questions;
            var c=0;
            $.each(qdata, function (i, item) {
              if(item.questionset_id == qsetdata.id){
                c++;
                if(item.is_active==true)
                {
                  var status='<div class="btn-group"><button type="button" class="btn btn-success btn-xs dropdown-toggle" data-toggle="dropdown" aria-expanded="true">Active<i class="glyphicon glyphicon-chevron-down"></i></button><ul  class="dropdown-menu success" role="menu"><li><button style="border:none;background: none;color: inherit;border: none;padding: 0;font: inherit; cursor: pointer;outline: inherit;" value="'+item.id+'"class="deactivate">Deactivate</button></li></ul></div>';
                }
                else
                {
                  status='<div class="btn-group"><button type="button" value="'+item.id+'" class="btn btn-danger btn-xs dropdown-toggle" data-toggle="dropdown" aria-expanded="true">Inactive<i class="glyphicon glyphicon-chevron-down"></i></button><ul  class="dropdown-menu danger" role="menu"><li><button style="border:none;background: none;color: inherit;border: none;padding: 0;font: inherit;cursor: pointer;  outline: inherit;" value="'+item.id+'"class="activate">Activate</button></li></ul></div>';
                }
                var row = '<tr id="question'+item.id+'"><td>'+c+'</td><td colspan="8"><div style=" word-break: break-all;"class="row form-group"><div class="col-sm-12"><label class="control-label">(Q).&nbsp;</label>'+item.name+'<label class="control-label">.&nbsp;?</label></div><div ></div></div><div class="row form-group"><div class="col-sm-6"><label class="control-label">(A).&nbsp;</label>'+item.option_a+'</div><div class="col-sm-6"><label class="control-label">(B).&nbsp;</label>'+item.option_b+'</div></div><div class="row form-group"><div class="col-sm-6"><label class="control-label">(C).&nbsp;</label>'+item.option_c+'</div><div class="col-sm-6"><label class="control-label">(D).&nbsp;</label>'+item.option_d+'</div></div><div class="row"><div class="col-sm-6"><label class="control-label">(Ans).&nbsp;</label>'+item.ans+'</div></div></td><td>'+item.ques_type+'</td><td>'+status+'</td><td><button class="btn btn-xs btn-info btn-block edit"value="'+item.id+'">Edit</button></td><td><button class="btn btn-xs btn-danger btn-block delete"value="'+item.id+'">Delete</button></td></tr>';
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
      var name= $(".col-sm-8 .question1").val();
      var oa= $(".col-sm-8 #optiona1").val();
      var ob= $(".col-sm-8 #optionb1").val();
      var oc= $(".col-sm-8 #optionc1").val();
      var od= $(".col-sm-8 #optiond1").val();
      var ans= $(".col-sm-8 #ans1").val();
      var status= $(".col-sm-5 #status1").val();
      var qtype= $(".col-sm-5 #questype1").val();
      if(status=='Active'){
        status=true;
      }
      else{
        status=false;
      }
      var question={question:{"questionset_id":qsetid,"name":name,"option_a":oa,"option_b":ob,"option_c":oc,"option_d":od,"ans":ans,"is_active":status,"ques_type":qtype}};
      $.ajax({
        type: "POST",
        url: "/questions",
        format: "JSON",
        data: question,
        success:function(result){
          window.open("/questionsets/"+qsetid,"_self")
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
      qid = $(this).val();
      $.ajax({
        type:"GET",
        url:"/questions/"+qid,
        dataType:"json",
        success:function(result){
          var qdata = result.question;
          $(".col-sm-8 .question").val(qdata.name);
          $(".col-sm-8 #optiona").val(qdata.option_a);
          $(".col-sm-8 #optionb").val(qdata.option_b);
          $(".col-sm-8 #optionc").val(qdata.option_c);
          $(".col-sm-8 #optiond").val(qdata.option_d);
          $(".col-sm-5 #questype").val(qdata.ques_type);
          $(".col-sm-8 #ans").val(qdata.ans);
          if(qdata.is_active==true){
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
      var name= $(".col-sm-8 .question").val();
      var oa= $(".col-sm-8 #optiona").val();
      var ob= $(".col-sm-8 #optionb").val();
      var oc= $(".col-sm-8 #optionc").val();
      var od= $(".col-sm-8 #optiond").val();
      var ans= $(".col-sm-8 #ans").val();
      var status= $(".col-sm-5 #status").val();
      var qtype= $(".col-sm-5 #questype").val();
      if(status=="Active"){
        status="true";
      }
      else{
        status="false";
      }
      var question={question:{"questionset_id":qsetid,"name":name,"option_a":oa,"option_b":ob,"option_c":oc,"option_d":od,"ans":ans,"is_active":status,"ques_type":qtype}};
      $.ajax({
        type: "PUT",
        url: "/questions/"+qid,
        format: "JSON",
        data: question,
        success:function(result){
          window.open("/questionsets/"+qsetid,"_self");
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
      var qid= $(this).val();
      var status={question:{"is_active":true }};
     $.ajax({
        type: "PUT",
        url: "/questions/"+qid,
        format: "JSON",
        data: status,
        success:function(result){
          window.open("/questionsets/"+qsetid,"_self");
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
      var qid= $(this).val();
      var status={question:{"is_active":false }};
     $.ajax({
        type: "PUT",
        url: "/questions/"+qid,
        format: "JSON",
        data: status,
        success:function(result){
          window.open("/questionsets/"+qsetid,"_self");
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
          url: "/questions/"+id,
          dataType: "json",
          success: function(result){
            $("#question"+id).remove();
            // window.open("/questionsets/"+qsetid,"_self")
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