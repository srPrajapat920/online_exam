var SignIn = SignIn || {}
SignIn.pageLoaded = function(){
  this.initialize();
}
SignIn.pageLoaded.prototype= {
  initialize:function(){
    this.url;
    this.urlid;
    this.postData();
    this.signup();       
  },
  postData:function(){
    url=window.location.href;
    urlid = url.substring(url.lastIndexOf('/'));
    $(".logout").hide()
    $(".col-md-9 #SignIn").click(function(){
      var email= $(".col-md-9 #Email").val();
      var password= $(".col-md-9 #Password").val();
      var user={"email_id":email,"password":password};
      $.ajax({
        type: "POST",
        url: "/login/",
        format: "JSON",
        data: user,
        success:function(result){
          if(urlid=="/login"){
          window.open("/tests","_self")
          }
          else{
            window.open("/subjects","_self")
          }
        },
        error:function (jqXHR, textStatus, errorThorwn){
          $.notify({
            icon: 'glyphicon glyphicon-warning-sign',
            message:"Incorrect combination of email_id and password",
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
  signup:function(){    
    if(urlid=="/admin"){
      $(".panel-title").html("Login");
      $("#lastdiv").hide();
      $(".col-md-9 .span").hide();
      $("#SignIn").html("&nbsp Log In");
    }
    $("#lastdiv #Signup").click(function(){
      window.open("/","_self")
    });
    $(document).on('click','.link', function(){
      window.open("/tests","_self")
    });
  }
}