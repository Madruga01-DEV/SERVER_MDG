$(document).ready(function() {
    $('html, body').css({
        'width': '100vw',
        'height': '100vh',
        'margin': '0',
        'padding': '0',
        'overflow': 'hidden',
        'background': '#000'
    });
    
    if (typeof enableLocalVideo !== 'undefined' && enableLocalVideo) {

        const videoElement = $(`
            <video id="videoPlayer" 
                   autoplay 
                   loop 
                   playsinline
                   style="position: absolute; 
                          top: 0; 
                          left: 0; 
                          width: 100vw; 
                          height: 100vh; 
                          object-fit: cover; 
                          z-index: 1;">
                <source src="video.mp4" type="video/mp4">
            </video>
        `);
        
        $('body').prepend(videoElement);
        
        $('#videoPlayer').css({
            'position': 'absolute',
            'top': '0',
            'left': '0',
            'width': '100vw',
            'height': '100vh',
            'object-fit': 'cover',
            'z-index': '1'
        });
        
        setTimeout(function() {
            const video = document.getElementById('videoPlayer');
            if (video) {
                
                const audioEnabled = typeof enableVideoAudio !== 'undefined' ? enableVideoAudio : true;
                
                if (audioEnabled) {
                    video.volume = 1.0;
                    video.muted = false;
                    
                    video.play().then(function() {
                    }).catch(function(error) {
                        video.muted = true;
                        video.play().then(function() {

                            const enableAudio = function() {
                                video.muted = false;
                                video.volume = 1.0;
                                document.removeEventListener('click', enableAudio);
                                document.removeEventListener('keydown', enableAudio);
                            };
                            
                            document.addEventListener('click', enableAudio);
                            document.addEventListener('keydown', enableAudio);
                            
                        }).catch(function(finalError) {
                        });
                    });
                } else {
                    video.muted = true;
                    
                    video.play().then(function() {
                    }).catch(function(error) {
                    });
                }
            }
        }, 500);
    }
    
    $(window).resize(function() {
        $('#videoPlayer').css({
            'width': '100vw',
            'height': '100vh'
        });
    });
});

window.addEventListener('message', function (e) {
    if (e.data.eventName === 'loadProgress') {
        const progress = Math.round(e.data.loadFraction * 100);
        $('.loading-bar p').text(progress + '%');
        $('.loading-bar .line').css('width', progress + '%');

        if (progress >= 100) {

            const video = document.getElementById('videoPlayer');
            if (video && video.muted && typeof enableVideoAudio !== 'undefined' && enableVideoAudio) {
                video.muted = false;
                video.volume = 1.0;
            }
        }
    }
});