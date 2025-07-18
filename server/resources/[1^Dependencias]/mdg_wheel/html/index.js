let busy = false;
let nailed = 0;
let closed = true;
let isComplete = false;
let elementMouseIsOver;
let stateNail = [
	"Nail-State01.png",
	"Nail-State02.png",
	"Nail-State03.png"
];

function display(bool) {
    if (bool) {
        $("#containerMain").show();
		closed = false;
    } else {
        $("#containerMain").hide();
		closed = true;
    }
}

display(false);


function reset() {
	document.getElementById("status").innerHTML = "Nailed: 0";
	nailed = 0;
	document.querySelector(".nail1").src = "Nail-State01.png";
	document.querySelector(".nail1").id = "stateNail1";
	document.querySelector(".nail1").style.display = 'none';

	document.querySelector(".nail2").src = "Nail-State01.png";
	document.querySelector(".nail2").id = "stateNail1";
	document.querySelector(".nail2").style.display = 'none';

	document.querySelector(".nail3").src = "Nail-State01.png";
	document.querySelector(".nail3").id = "stateNail1";
	document.querySelector(".nail3").style.display = 'none';

	document.querySelector(".nail4").src = "Nail-State01.png";
	document.querySelector(".nail4").id = "stateNail1";
	document.querySelector(".nail4").style.display = 'none';
	
	document.querySelector(".nail5").src = "Nail-State01.png";
	document.querySelector(".nail5").id = "stateNail1";
	document.querySelector(".nail5").style.display = 'none';

	document.querySelector(".nail6").src = "Nail-State01.png";
	document.querySelector(".nail6").id = "stateNail1";
	document.querySelector(".nail6").style.display = 'none';

	document.querySelector(".nail6").src = "Nail-State01.png";
	document.querySelector(".nail6").id = "stateNail1";
	document.querySelector(".nail6").style.display = 'none';

	document.querySelector(".nail7").src = "Nail-State01.png";
	document.querySelector(".nail7").id = "stateNail1";
	document.querySelector(".nail7").style.display = 'none';

	document.querySelector(".nail8").src = "Nail-State01.png";
	document.querySelector(".nail8").id = "stateNail1";
	document.querySelector(".nail8").style.display = 'none';
	loadNails();
}

window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === "ui") {
        if (item.status == true) {
            display(true)
			reset()
        } else {
            display(false)
        }
    }
});
	
document.onkeyup = function (data) {
    if (data.which == 27) {
        $.post('http://mdg_wheel/exit', JSON.stringify({}));
        return
    }
};
	
$("#close").click(function () {
    $.post('http://mdg_wheel/exit', JSON.stringify({}));
    return
});

$(document).mousemove(function(e) {
  $("#tool").css({
    left: e.pageX-55,
    top: e.pageY-50
  });
});

$(window).click(function(e) {
    var x = e.clientX, y = e.clientY,
    elementMouseIsOver = document.elementFromPoint(x, y);
	if (!busy) {
    	busy = true;
    	playAudio("hammer")
        document.getElementById("tool").style.animationName = 'hammering';
        setStateNail(elementMouseIsOver);
        document.getElementById("tool").style.animationPlayState = "running";
        setTimeout(() => {
        	document.getElementById("tool").style.animationName = 'none';
        	busy = false;
        }, 325);
    }
});

function setStateNail(element) {
	switch (element.id) {
  	case "stateNail1":
    	element.id = "stateNail2";
    	element.src = "Nail-State02.png";
    	break;
 	case "stateNail2":
    	element.id = "stateNail3";
    	element.src = "Nail-State03.png";
        nailed = nailed + 1;
        document.getElementById("status").innerHTML = "Nailed: " + nailed;
        if (nailed === 8) {
        	playAudio("success")
            document.getElementById("status").innerHTML = "SUCCESS!";
            document.querySelector(".square").style.backgroundColor = '#579627';
			$.post('http://mdg_wheel/VehicleWheelWasFixed', JSON.stringify({ status: "FIXED" }));
			finish();
        }
    break;
	}
}

var sounds = [
    "https://cdn.discordapp.com/attachments/729805671763017809/959941865816342568/Hit01.ogg",
	"https://cdn.discordapp.com/attachments/729805671763017809/959941866017665054/Hit02.ogg",
	"https://cdn.discordapp.com/attachments/729805671763017809/959941866172870656/Hit03.ogg",
	"https://cdn.discordapp.com/attachments/729805671763017809/959941866344841296/Hit04.ogg",
    "https://cdn.discordapp.com/attachments/729805671763017809/961691851889467442/succes1.ogg",
    "https://cdn.discordapp.com/attachments/729805671763017809/961691851444879391/click1.ogg"
];

function loadNails() {
	setTimeout(() => {
		if (!closed) {
			document.querySelector(".nail1").style.display = 'block';
			playAudio("click");		
		}
	}, 2000);
	setTimeout(() => {
		if (!closed) {
			document.querySelector(".nail2").style.display = 'block';
			playAudio("click");
		}
	}, 2200);
    setTimeout(() => {
		if (!closed) {
			document.querySelector(".nail3").style.display = 'block';
			playAudio("click");
		}
	}, 2400);
    setTimeout(() => {
		if (!closed) {
			document.querySelector(".nail4").style.display = 'block';
			playAudio("click");
		}
	}, 2600);
    setTimeout(() => {
		if (!closed) {
			document.querySelector(".nail5").style.display = 'block';
			playAudio("click");
		}
	}, 2800);
    setTimeout(() => {
		if (!closed) {
			document.querySelector(".nail6").style.display = 'block';
			playAudio("click");
		}
	}, 3000);
    setTimeout(() => {
		if (!closed) {
			document.querySelector(".nail7").style.display = 'block';
			playAudio("click");
		}
	}, 3200);
    setTimeout(() => {
		if (!closed) {
			document.querySelector(".nail8").style.display = 'block';
			playAudio("click");
		}
	}, 3400);
}

function playAudio(type) {
	var x = document.createElement("AUDIO");
    let number = getRandomInt(0, 3);
    
  	if (x.canPlayType("audio/mpeg")) {
    	if (type === "click") {
        	x.setAttribute("src", "https://cdn.discordapp.com/attachments/729805671763017809/961691851444879391/click1.ogg");
            x.volume = 0.45;
			setTimeout(() => {
				x.remove();
			}, 350);
        } else if (type === "hammer") {
        	x.setAttribute("src", sounds[number]);
            x.volume = 0.45;
			setTimeout(() => {
				x.remove();
			}, 350);
        } else if (type === "success") {
        	x.setAttribute("src", "https://cdn.discordapp.com/attachments/729805671763017809/961691851889467442/succes1.ogg");
            x.volume = 0.65;
			setTimeout(() => {
				x.remove();
			}, 2500);
        }
  	}

  	document.body.appendChild(x);
    x.play();	
}

function getRandomInt(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function finish() {
	setTimeout(() => {
		document.getElementById("containerMain").style.animationPlayState = 'running';
		setTimeout(() => {
			$.post('http://mdg_wheel/exit', JSON.stringify({}));
			document.getElementById("containerMain").style.animationPlayState = 'paused';
		}, 1000);
	}, 1000);
}