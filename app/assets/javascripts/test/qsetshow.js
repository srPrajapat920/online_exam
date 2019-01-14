var Qsetshow = Qsetshow || {}
Qsetshow.pageLoaded = function(){
  this.initialize();
}
Qsetshow.pageLoaded.prototype= {
  initialize:function(){
    this.count;
    this.getData();
    this.linkShowNewDelete();
  },
  getData:function(){
  	var url=window.location.href;
  	var id = url.substring(url.lastIndexOf('/') + 1);
	  $.ajax({
     	type: "GET",
		  url: "/qsetshow/"+id,
		  dataType: "json",
		  success: function(result){
			  var qsetdata = result.questionset
        $.ajax({
          type: "GET",
          url: "/ques",
          dataType: "json",
          success: function(result){
            var testdata = result.questions;
            count=0;
            $.each(testdata, function (i, item) {
              if(item.questionset_id == qsetdata.id && item.is_active==true){
                count++;
              }
            });
            var row = '<div class="div-test-initiator" id="divInitiator"><div class="mx-none" id="divStartTestInstruction" style="display: block;"><div class="div-test-instruction"><p class="mx-green mx-bold mx-uline"><b>Instruction:</b></p><ul class="ul-test-instruction"><li>Total number of questions : <b>'+count+'</b>.</li><li>Time alloted : <b>'+qsetdata.time+'</b> minutes.</li><li>Each question carry '+qsetdata.marks_per_ques+' mark.</li><li>DO NOT refresh the page.</li><li>All the best :-).</li></ul></div><p align="center"><br><button class="btn btn-success" type="button" value="'+qsetdata.id+'" id="btnStartTest">Start Test ...</button></p></div></div>';
            $(".panel .panel-body").append(row);
          }
        });
   		}
   	});		
	},	
	linkShowNewDelete:function(){
    $(document).on('click','#btnStartTest', function(){
      var id= $(this).val();
      window.open("/exm/"+id,"_self")
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