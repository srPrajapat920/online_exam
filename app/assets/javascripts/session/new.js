var SignIn = SignIn || {}
SignIn.pageLoaded = function(){
  this.initialize();
}
SignIn.pageLoaded.prototype= {
  initialize:function(){
    this.postData();
    this.signup();       
  },
  postData:function(){
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
          console.log(result);
          window.open("/tests","_self")
        },
        error: function (jqXHR, textStatus, errorThrown) {
             alert("Error Code: " + jqXHR.status + ", Type:" + textStatus + ", Message: " + errorThrown);

        }
	    });
    });
  },
  signup:function(){
    $(".col-md-9 #Signup").click(function(){
      window.open("/","_self")
    })
  }
}