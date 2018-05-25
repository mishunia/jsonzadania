<!doctype html>
<html lang="en">
    <head>
      <meta charset="utf-8">
      <title>Video Watcher</title>
      <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.1.0/css/bootstrap.min.css">
      <style type="text/css">
        li {
            list-style-type: none;
        }
        li:not(:last-child) {
            margin-bottom: 20px;
        }
        .videos-list__item {
            width: 700px;
            padding: 35px;
            background-color: #DDD;
            border: 2px solid #ff0000;
        }
        .videos-list__item h2 {
            color: #ff0000;
            font-size: 20px;
            text-transform: uppercase;
        }
        #video-watcher {
            position: fixed;
            right: 10px;
            top: 100px;
        }
        .video {
            display: flex;
            align-items: center;
        }
        .video-desc {
            display: none;
            margin-left: 15px;
        }
        .video-link:hover + .video-desc {
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
                    <ul class="videos-list"></ul>
                </div>
                <div class="span9" id="video-watcher"></div>
            </div>
        </div>
      <script src="http://teaching-materials.org/common/youtube.js"></script>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
      <script>

        const jsonObj = 'movies.json'
        const videoList = $('.videos-list')

        function createVideoEmbed(videoLink) {

          videoLink.on('click', function (e) {
            e.preventDefault()

            const videoLinkId = $(this).attr('href')

            const videoEmbed = $('<iframe></iframe>')
            videoEmbed.attr('src', youtube.generateEmbedUrl(videoLinkId))
            videoEmbed.attr('width', 560)
            videoEmbed.attr('height', 315)

            const videoWatcher = $('#video-watcher')
            videoWatcher.hide()
            videoWatcher.html(videoEmbed)
            videoWatcher.fadeIn()
          })
        }


        function pushTemplates(movies) {
          $.each(movies.categories, (i, category) =>  {
            const categoriesQuan = movies.categories 
            $.each(category.videos, (i, videos) => {
              
              const element = $(`
                <li class="videos-list__item">
                    <h2>${category.name}</h2>
                    <ul>
                        ${videos.map(video => {
                            const thumbnailUrl = youtube.generateThumbnailUrl(video);
                            return `
                            <li class="video">
                                <a class="video-link" href="https://www.youtube.com/watch?v=${video}">
                                    <img src="${thumbnailUrl}" />
                                </a>
                                <span class="video-desc">
                                    <strong>adres: </strong>https://www.youtube.com/watch?v=${video}
                                </span>
                            </li>
                            
                            `
                        }).join('')}
                    </ul>
                </li>
            `)

            videoList.append(element)

            const videoLink = $('.video-link')

            createVideoEmbed(videoLink) // Run reate video embed on click

            })
          })
        }

        
        function loadJson() {
          $.ajax({
            url : jsonObj,
            dataType : 'json'
          })
          .done(movies => {
            pushTemplates(movies) // Run push template
          })
        }
        loadJson();

    
      </script>
   </body>
</html>