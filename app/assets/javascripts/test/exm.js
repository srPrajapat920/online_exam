var Showexm = Showexm || {}
Showexm.pageLoaded = function(){
  this.initialize();
}
Showexm.pageLoaded.prototype= {
  initialize:function(){
    this.qsetdata;
    this.exmdata;
    this.getData(); 
    this.checkResult(); 
    this.logout();
  },
  getData:function(){
    window.location.hash="";
    window.location.hash="";
  	var url=window.location.href;
  	var id = url.substring(url.lastIndexOf('/') + 1);
	  $.ajax({
     	type: "GET",
		  url: "/qsetshow/"+id,
		  dataType: "json",
		  success: function(result){
			   qsetdata = result.questionset      
			  $.ajax({
				  type: "GET",
				  url: "/ques",
				  dataType: "json",
				  success: function(result){
					   exmdata = result.questions;
             var c=0;
   				  $.each(exmdata, function (i, item) {
   					  if(item.questionset_id == qsetdata.id && item.is_active==true){
                c++;
	     				  var row = '<tr><td class="align="left" valign="top">'+c+'.&nbsp;&nbsp;</td><td><p style="font-size: 17px;">'+item.name+'.?<br><br>&nbsp;<input type="radio" name="option'+item.id+'" value="'+item.option_a+'">&nbsp;&nbsp;(A)&nbsp;&nbsp;&nbsp;'+item.option_a+'<br><br>&nbsp;<input type="radio" name="option'+item.id+'" value="'+item.option_b+'">&nbsp;&nbsp;(B)&nbsp;&nbsp;&nbsp;'+item.option_b+'<br><br>&nbsp;<input type="radio" name="option'+item.id+'" value="'+item.option_c+'">&nbsp;&nbsp;(C)&nbsp;&nbsp;&nbsp;'+item.option_c+'<br><br>&nbsp;<input type="radio" name="option'+item.id+'" value="'+item.option_d+'">&nbsp;&nbsp;(D)&nbsp;&nbsp;&nbsp;'+item.option_d+'</td></tr><tr>';
	     				  $(".panel-body #exm").append(row);
	     			  }
   				  });
            $('input[type=radio]').click(function(){
              if (this.previous) {
               this.checked = false;
              }
              this.previous = this.checked;
            }); 
   			  }
   			});
        var time=qsetdata.time
        var valueTimer = time*60;
        setInterval(function(){
          if(valueTimer > 0){
            valueTimer = valueTimer - 1;  
            hours = (valueTimer/3600).toString().split('.')[0];
            mins  = ((valueTimer % 3600) / 60).toString().split('.')[0]; 
            secs  = ((valueTimer % 3600) % 60).toString();  
            if(hours.length == 1) hours = '0' + hours; 
            if(mins.length  == 1) mins  = '0' + mins; 
            if(secs.length  == 1) secs  = '0' + secs;  
            if(mins=='00'){
              $('#divFloatTimer').css("background-color", "red");
            } 
            $('#timer').text( hours + ':' +  mins + ':'  + secs);
          }
          else{ 
            $('#submit').click();
            alert(" Your time is up ! ");
          }
        },1000);
   	  }
   	});
	},
  checkResult:function(){
    $('#submit').click(function(){
      var count=0;
      var att=0;
      var marks=0;
      var result = $('input[type="radio"]:checked');
      var n;
      for(var i=0;i<result.length;i++){
        att++;
        $.each(exmdata, function (j, item) {
          if(item.questionset_id == qsetdata.id && item.is_active==true){
             n = "option"+item.id;
            if(result[i].name==n && result[i].value==item.ans){
              count++;
            }         
          }
        });
      } 
      marks=count*qsetdata.marks_per_ques;
      var userid=$('#hidden').val();
      $.ajax({
        type:"GET",
        url:"/users/"+userid,
        dataType:'json',
        success:function(result){
          var userdata=result.user;  
          var exm={"attended_ques":att,"total_marks":marks,"user_id":userdata.id,"questionset_id":qsetdata.id};
          $.ajax({
            type:"POST",
            url:"/exams",
            dataType:'json',
            data: exm,
            success:function(result){
              alert('"you have Attended '+att+' questions"');
              window.open("/tests","_self");
            },
            error:function (jqXHR, textStatus, errorThorwn){
              var msg = jqXHR.responseJSON.errors.toSource(); 
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
        }
      });
    });
  },
  logout:function(){
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