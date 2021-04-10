{/* <script>
  $(function() {
    $("#search").click(function (e) {
      e.preventDefault();
      var param = {
        zipcode: $('#zip_code').val()
      }
      var send_url = "http://zipcloud.ibsnet.co.jp/api/search";
      $.ajax({
        type: "GET",
        cache: false,
        data: param,
        url: send_url,
        dataType: "jsonp",
        success: function (res) {
          if (res.status == 200) {
            var html = '';
            // for (var i = 0; i < res.results.length; i++) {
            var result = res.results[0];
            $('#pref_name').val(result.address1);
            $('#city').val(result.address2);
            $('#other').val(result.address3);
            // }
            console.log(res.results);
          } else {
            $('#zip_result').html(res.message);
          }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
          console.log(XMLHttpRequest);
        }
      });
    });
  });
</script> */}