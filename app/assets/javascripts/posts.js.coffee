## The new post page. Mostly webcam handler stuff.
$(".posts.new").ready ->
   data_uri = false
   Webcam.attach("#my_camera")
   Webcam.on('live', ->
      $("#file_fields").hide()
      $("#file_input").attr('type', 'hidden')
   )
   Webcam.on('error', ->
      alert("Error! Couldn't connect to webcam. Either give permission, or upload a saved file.")
   )
   $("#snap").click ->
      data_uri = Webcam.snap()
      result = $("<img>")
      result.attr('src', data_uri)
      $("#my_result").empty()
      $("#my_result").append(result)
      $("#my_camera").hide()
      $("#my_result").show()
      $("#file_input").val(data_uri)
   $("#cancel").click ->
      $("#my_camera").show()
      $("#my_result").hide()
      $("#file_input").val('')
   $(document).on("page:before-change", ->
      Webcam.reset()
   )

$(".posts.index").ready ->
