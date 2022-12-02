/**
 * 
 */
 
 
var player = videojs("myPlayer", {
            sources : [
                { src : "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", type : "video/mp4"}
            ],
            width="100",
            poster : "test-poster.png",
            controls : true,
            playsinline : true,
            muted : true,
            preload : "metadata"
        });
        
  $(document).ready(function() {
    console.log( "ready!" );
});