$(".center h1").html(name)
$(".center p").html(underName)
$(".center span").html(desc)
var serverInfo = null

if (!showServerName) {
	$(".center").hide()
}

if (!showLoadingBar) {
	$(".loading-bar").hide()
}

function loading(num) {
	let current = parseInt($(".loading-bar p").text(), 10) || 0;
	const step = 1;
	const delay = 700 / Math.abs(num - current);

	const interval = setInterval(function () {
		if (current < num) {
			current += step;
			if (current > num) current = num;
		} else if (current > num) {
			current -= step;
			if (current < num) current = num;
		} else {
			clearInterval(interval);
		}
		$(".loading-bar p").text(current + "%");
	}, delay);

	$(".loading-bar .line").width(num + "%");
}

if (showStaffTeam) {
	$(".panel.staffteam").show()
	staff_team.forEach(function (user) {
		$(".staff_team").append(`
			<div class="staff">
				<div class="info">
					<img src="${user.image}" class="pfp">
					<p>${user.name}</p>
				</div>
				<p class="status">${user.rank}</p>
			</div>
		`)
	})
}

if (showPlayersList) {
	$(".panel.playerlist").show()
	players()
}

function players() {
	if (serverCode == "******") { return }
	$.get("https://servers-frontend.fivem.net/api/servers/single/" + serverCode, function (data) {
		serverInfo = data.Data
		serverInfo.players.forEach(function (player) {



			$(".player_list").append(`
				<div class="staff">
					<div class="info">
						<img src="${playerProfileImage}" class="pfp">
						<p>${player.name}</p>
					</div>
					<p class="status">${player.id}</p>
				</div>
			`)
		})
	})
}

window.addEventListener('message', function (e) {
	if (e.data.eventName === 'loadProgress') {
		var num = (e.data.loadFraction * 100).toFixed(0)
		loading(num);
	}
});

const socials = { discord, instagram, youtube, twitter, tiktok, facebook, twitch, github };
const platforms = ["discord", "instagram", "youtube", "twitter", "tiktok", "facebook", "twitch", "github"];

platforms.forEach(platform => {
	if (socials[platform] != "") {
		$(`.${platform}`).show();
		$(`.${platform} a`).attr("href", socials[platform]);
	}
});

$("a").on("click", function (e) {
	e.preventDefault()
	window.invokeNative('openUrl', e.target.href)
})

if (theme == "orange") {
	$("body").append(`<style>:root{--main:255, 150, 0;}</style>`)
	$("body").css("background-image", "url('assets/img/orange.jpg')")
	$(".winter").css("background", "linear-gradient(0deg, rgb(255 150 0 / 10%) 0%, rgba(255, 150, 0, 0.0) 100%)")
}
if (theme == "red") {
	$("body").append(`<style>:root{--main:255,0,0;}</style>`)
	$("body").css("background-image", "url('assets/img/red.jpg')")
	$(".winter").css("background", "linear-gradient(0deg, rgb(255 0 0 / 10%) 0%, rgba(255, 0, 0, 0.0) 100%)")
}
if (theme == "blue") {
	$("body").append(`<style>:root{--main:0, 163, 255;}</style>`)
	$("body").css("background-image", "url('assets/img/blue.jpg')")
	$(".winter").css("background", "linear-gradient(0deg, rgb(0 163 255 / 10%) 0%, rgba(0, 163, 255, 0.0) 100%)")
}
if (theme == "green") {
	$("body").append(`<style>:root{--main:65, 255, 0;}</style>`)
	$("body").css("background-image", "url('assets/img/green.jpg')")
	$(".winter").css("background", "linear-gradient(0deg, rgb(65 255 0 / 10%) 0%, rgba(65, 255, 0, 0.0) 100%)")
}
if (theme == "pink") {
	$("body").append(`<style>:root{--main:255, 122, 237;}</style>`)
	$("body").css("background-image", "url('assets/img/pink.jpg')")
	$(".winter").css("background", "linear-gradient(0deg, rgb(255 122 237 / 10%) 0%, rgba(255, 122, 237, 0.0) 100%)")
}
if (theme == "purple") {
	$("body").append(`<style>:root{--main:193, 67, 255;}</style>`)
	$("body").css("background-image", "url('assets/img/purple.jpg')")
	$(".winter").css("background", "linear-gradient(0deg, rgb(193 67 255 / 10%) 0%, rgba(193, 67, 255, 0.0) 100%)")
}
// Winter update
if (enableWinterUpdate) {
	particlesJS("particles-js", { "particles": { "number": { "value": 160, "density": { "enable": true, "value_area": 800 } }, "color": { "value": "#ffffff" }, "shape": { "type": "circle", "stroke": { "width": 0, "color": "#000000" }, "polygon": { "nb_sides": 5 }, "image": { "src": "img/github.svg", "width": 100, "height": 100 } }, "opacity": { "value": 0.5, "random": false, "anim": { "enable": false, "speed": 1, "opacity_min": 0.1, "sync": false } }, "size": { "value": 3, "random": true, "anim": { "enable": false, "speed": 40, "size_min": 0.1, "sync": false } }, "line_linked": { "enable": false, "distance": 150, "color": "#ffffff", "opacity": 0.4, "width": 1 }, "move": { "enable": true, "speed": 1.5, "direction": "bottom", "random": true, "straight": false, "out_mode": "out", "bounce": false, "attract": { "enable": true, "rotateX": 100, "rotateY": 1200 } } }, "interactivity": { "detect_on": "canvas", "events": { "onhover": { "enable": false, "mode": "repulse" }, "onclick": { "enable": false, "mode": "repulse" }, "resize": true }, "modes": { "grab": { "distance": 400, "line_linked": { "opacity": 1 } }, "bubble": { "distance": 400, "size": 40, "duration": 2, "opacity": 8, "speed": 3 }, "repulse": { "distance": 223.7762237762238, "duration": 0.4 }, "push": { "particles_nb": 4 }, "remove": { "particles_nb": 2 } } }, "retina_detect": true });
	$("body").css("background-image", "url('assets/img/winter.jpg')")
	$(".winter").css("display", "flex")
	$("#particles-js").css("opacity", 1)
}

let a, vl, yt, isMute = false, isPaused = false;

if (youtubeVideo.startsWith("https://www.youtube.com")) {
	if (!enableLocalVideo) {
		let videoId = youtubeVideo.split('/').pop().split('=')[1];
		if (!showYoutubeVideo) {
			videoOpacity = 0

		}
		$("iframe").attr("src", `https://www.youtube.com/embed/${videoId}?autoplay=1&controls=0&enablejsapi=1&disablekb=1`)
			.css({ filter: `blur(${videoBlur}px)`, opacity: videoOpacity });
		if (showYoutubeVideo) $("body").css("background", "#000");
		if (enableLocalVideo) {
			$("iframe").attr("src", "")
		}
	}
}
if (localAudio) {
	$('body').append('<audio id="audioPlayer" src="audio.mp3" loop></audio>');
	$('#audioPlayer')[0].play();
	a = $('#audioPlayer');
}

if (enableLocalVideo) {
	$('body').append('<video id="videoPlayer" autoplay loop><source src="video.webm" type="video/webm"></video>');
	$('#videoPlayer')[0].play();
	vl = $('#videoPlayer');
	if (localAudio) {
		vl[0].muted = true
	}
	$("body").css("background", "#000");
}

function onYouTubeIframeAPIReady() {
	yt = new YT.Player('youtube-video', {
		events: { 'onReady': onPlayerReady }
	});
}

function onPlayerReady() {
	if (localAudio) { yt.mute(); }
}

function toggleMute(self) {
	$(self).toggleClass("act");
	isMute = !isMute;
	if (yt && typeof yt.mute === "function") {
		localAudio ? yt.mute() : (isMute ? yt.mute() : yt.unMute());
	}
	if (a && a[0]) { a[0].muted = isMute; }
	if (vl && vl[0]) { if (localAudio) { vl[0].muted = true }; vl[0].muted = localAudio || isMute; }
}

function togglePause(self) {
	$(self).toggleClass("act");
	isPaused = !isPaused;
	if (yt && typeof yt.pauseVideo === "function" && typeof yt.playVideo === "function") {
		isPaused ? yt.pauseVideo() : yt.playVideo();
	}
	if (a && a[0]) { isPaused ? a[0].pause() : a[0].play(); }
	if (vl && vl[0]) { isPaused ? vl[0].pause() : vl[0].play() }
}


function setVolume(volume) {
	if (a && a[0]) { a[0].volume = volume / 100; }
	if (vl && vl[0]) { vl[0].volume = volume / 100; }
	if (yt && typeof yt.setVolume === "function" && yt.videoTitle !== "" && !localAudio) {
		yt.setVolume(volume);
	}

	$(".inpt span").text(volume + "%");
	$(".volume-slider").css({
		background: `rgba(var(--main), ${(volume / 100) + 0.2})`
	});
}