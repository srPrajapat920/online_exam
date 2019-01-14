var Exams = Exams || {}
Exams.pageLoaded = function(){
  this.initialize();
}
Exams.pageLoaded.prototype= {
  initialize:function(){
    this.getData();  
    this.action();
  },
  getData:function() {  
	  $.ajax({
 		  type: "GET",
 		  url: "/exams",
 		  dataType: "json",
 		  success: function(result){   
        var data = result.exams;
   		  $.each(data, function (i, item) {
          var i = i+1;
     		  var row = '<tr id="Exam'+item.id+'"><td>'+i+'</td><td>'+item.username+'</td><td>'+item.email_id+'</td><td>'+item.question_set+'</td><td>'+item.attended_ques+'</td><td>'+item.total_marks+'</td><td>'+item.start_at+'</td><td><button class="btn btn-xs btn-danger btn-block delete"value="'+item.id+'">Delete</button></td></tr>';
          $("#datatable3 #exam").append(row);
   		  });
        $("#datatable3").dataTable( {
          dom: '<"row"<"col-sm-4"l><"col-sm-4"B><"col-sm-4"f>>rtip',
          buttons: [{
            text:'<i class="">print</i>',
            extend:'pdf',
            className:'btn  btn-primary ',
            extension:'.pdf',
            exportOptions: {
            columns: [ 1, 2, 3, 5, 6 ]
            }
          }]
        });
        $("#datatable3_filter input").css("border","1px solid #b0bec5");
        $("#datatable3_length select").css("border","1px solid #b0bec5");
        $("#datatable3_filter input").addClass('datepicker');
 		  },
 		  error: function (result) {
        alert("Error");
      }
    });    
	},
  action:function(){
    $(document).on('click','.delete', function(){
      if(confirm("are you sure!")){
        var id=$(this).val();
        $.ajax({
          type: "DELETE",
          url: "/exams/"+id,
          dataType: "json",
          success: function(result){
            $("#Exam"+id).remove();
            // window.open("/exams","_self")
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
  }
}