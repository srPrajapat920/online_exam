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
    $(".col-md-9 #Signup").click(function(){
	    var firstname= $(".col-md-9 #Firstname").val();
	    var lastname= $(".col-md-9 #Lastname").val();
      var contact_no= $(".col-md-9 #Contact_no").val();
      var email= $(".col-md-9 #Email").val();
      var password= $(".col-md-9 #Password").val();
      var level= $(".col-md-4 #Level").val();
      var username= firstname+" "+lastname;
      var user={"username":username,"contact_no":contact_no,"email_id":email,"password":password,"level":level};
      $.ajax({
        type: "POST",
        url: "/users/",
        format: "JSON",
        data: user,
        success:function(result){
          alert(result);
          console.log(result);
          window.open("/login","_self")
        },
        error:function (){
          alert("fill correct data ..!");
        }
	    });
    });
  },
  signin:function(){
    $(".col-md-9 #Signin").click(function(){
      window.open("/login","_self")
    })
  }
}