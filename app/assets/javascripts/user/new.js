var SignUp = SignUp || {}
SignUp.pageLoaded = function(){
  this.initialize();
}
SignUp.pageLoaded.prototype= {
  initialize:function(){
    this.postData();
    this.signin();       
  },
  postData:function(){
    $(".logout").hide()
    $(".col-sm-9 #Signup").click(function(){
	    var firstname= $(".col-sm-9 #Firstname").val();
	    var lastname= $(".col-sm-9 #Lastname").val();
      var contact_no= $(".col-sm-9 #Contact_no").val();
      var email= $(".col-sm-9 #Email").val();
      var password= $(".col-sm-9 #Password").val();
      if(password.length<6){
        $.notify({
          icon: 'glyphicon glyphicon-warning-sign',
          message:"password is too short",
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
      var level= $(".col-sm-4 #Level").val();
      var username= firstname+" "+lastname;
      var user={"username":username,"contact_no":contact_no,"email_id":email,"password":password,"level":level};
      $.ajax({
        type: "POST",
        url: "/users/",
        format: "JSON",
        data: user,
        success:function(result){
          window.open("/login","_self")
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
  signin:function(){
    $(".col-sm-9 #SignIn").click(function(){
      window.open("/login","_self")
    });
    $(document).on('click','.link', function(){
      window.open("/tests","_self")
    });
  }
}