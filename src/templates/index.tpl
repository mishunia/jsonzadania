<!doctype html>
<html lang="en">
    <head>
      <meta charset="utf-8">
      <title>Video Watcher</title>
      <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.1.0/css/bootstrap.min.css">
      <style type="text/css">
         /* This puts titles always on a separate line from thumbnails */
         #videos-list img {
         display: block;
         }
      </style>
    </head>
   <body>
      <div class="container">
         <div class="row">
            <div class="span12">
               <h2 class="page-header">Best Videos Ever ❤</h2>
            </div>
         </div>
         <div class="row">
            <div class="span3">
               <ul id="videos-list"></ul>
                <li class="video-list
            </div>
            <div class="span9" id="video-watcher"></div>
         </div>
      </div>
      <script src="http://teaching-materials.org/common/youtube.js"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
      <script>

       function addVideoToList(video) {

        var videoLink = $('<a>')
        videoLink.append(video.sport)
        var thumbnailUrl = youtube.generateThumbnailUrl(video.youtubeId)
        var thumbnailImg = $('<img>')
        thumbnailImg.attr('src', thumbnailUrl)
        videoLink.append(thumbnailImg)

        videoLink.on('click', function (e) {
            e.preventDefault()

            var videoEmbed = $('<iframe></iframe>')
            videoEmbed.attr('src', youtube.generateEmbedUrl(video.youtubeId))
            videoEmbed.attr('width', 560)
            videoEmbed.attr('height', 315)

            var videoWatcher = $('#video-watcher')
            videoWatcher.hide()
            videoWatcher.html(videoEmbed)
            videoWatcher.fadeIn()
        });

        var videoItem = $('<li>')
        videoItem.append(videoLink)
        $('#videos-list').append(videoItem)
        }

        var videos = []
        $.getJSON('movies.json')
        .done(function(data) {
            console.log('done')
            videos = data
            for (var i = 0; i < videos.length; i++) {
            addVideoToList(videos[i])
            }
        });

      </script>
   </body>
</html>