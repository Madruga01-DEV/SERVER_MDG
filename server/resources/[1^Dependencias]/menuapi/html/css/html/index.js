var languageRanch = {}
var allSetup = {}
var maxBuy = []
var maxBreed = []
var allAnimals = []
var shared = []
var overMeCheck = false
var expCounter = []
var ownedTrough = []
var expTable = []
var owner = false
var inMinigame = false
var storageEnable = false
var blockSell = false
var isRentTime = false
function mouseOver() {overMeCheck = true}
function mouseOut() {overMeCheck = false}


$(document).keydown(function(e) {
    var close = 27;
    var close2 = 8;
    switch (e.keyCode) {
        case close:
            $.post('http://mdg_ranch_system/close');
            $("#ranchManage").hide();
            $("#ranchAnimals").hide();
            $("#minigame").hide();
            if (inMinigame === true) {
                $.post('http://mdg_ranch_system/finishMinigame');
                inMinigame = false
            }
            break;
        case close2:
            $.post('http://mdg_ranch_system/close');
            $("#ranchManage").hide();
            $("#ranchAnimals").hide();
            $("#minigame").hide();
            if (inMinigame === true) {
                $.post('http://mdg_ranch_system/finishMinigame');
                inMinigame = false
            }
        break;
    }
});

$(function() {
    function ranchMenu(bool) {
        if (bool) {
            $("#ranchManage").show();
        } else {
            $("#ranchManage").hide();
        }
    }
    function Stats(bool) {
        if (bool) {
            $("#animal_stats").show();
        } else {
            $("#animal_stats").hide();
        }
    }

    $("#ranchAnimals").hide();
    $("#minigame").hide();
    ranchMenu(false)
    Stats(false)
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "startMinigame") {
            openMinigame(item.product, item.count, item.pos)
            inMinigame = true
        }
        if (item.type === "show_stats") {
            Stats(true)
            languageRanch = item.language
            document.getElementById("gender").innerHTML = ""+languageRanch[44]+""+item.gender+""
            if (item.age == "Old") {
                document.getElementById("age").innerHTML = ""+languageRanch[45]+""
            } else {
                document.getElementById("age").innerHTML = ""+languageRanch[46]+""+item.age+""+languageRanch[47]+""
            }
            document.getElementById("exp").innerHTML = ""+languageRanch[48]+""+item.exp+""
            document.getElementById("satisfaction").innerHTML = ""+languageRanch[49]+""+item.satisfaction+"%"
            document.getElementById("health").innerHTML = ""+languageRanch[50]+""+item.health+"%"
            document.getElementById("hunger").innerHTML = ""+languageRanch[51]+""+item.hunger+"%"
            document.getElementById("thirst").innerHTML = ""+languageRanch[52]+""+item.thirst+"%"
            if (item.product !== "none" && item.product !== 0) {
                document.getElementById("product").innerHTML = ""+languageRanch[53]+""+item.product+""+languageRanch[54]+""
            } else {
                document.getElementById("product").innerHTML = ""+languageRanch[55]+""
            }
            if (Number(item.breedtime) !== 0) {
                $("#breedtime").show();
                document.getElementById("breedtime").innerHTML = ""+languageRanch[56]+""+item.breedtime+""
            } else {
                $("#breedtime").hide();
            }
        }
        if (item.type === "hide_stats") {
            Stats(false)
        }
        if (item.type === "showMenu") {
            $("#ranchAnimals").hide();
            blockSell = item.blockSell
            storageEnable = item.storageEnable
            languageRanch = item.language
            expTable = item.expTable
            owner = item.owner
            allSetup = item.allSetup
            expCounter = item.expCounter
            shared = item.shared
            maxBuy = item.maxBuy
            maxBreed = item.maxBreed
            allAnimals = item.allAnimals
            ownedTrough = item.ownedTrough
            data = item.data
            chicken = item.chicken
            cow = item.cow
            sheep = item.sheep
            goat = item.goat
            pig = item.pig
            horse = item.horse
            trough = item.trough
            isRentTime = item.isRentTime
            openMenuRanch(item.money, item.prepayed, item.prepayedDate)
        }

        if (item.type === "hide_stats_trough") {
            Stats(false)
        }
    })

    $("#close").click(function() {
        $.post('http://mdg_ranch_system/exit', JSON.stringify({}));
        return
    })
})
function openMinigame(animal, count, pos) {
   const tableBody = document.getElementById('minigame');
    let dataHtml = '';
    for(var i = 0; i < count; i++)
    {
        dataHtml += '<div class="gameItem" id="reward_'+i+'" onclick="pickReward(\''+i+'\',\''+animal+'\',\''+pos+'\')"><img src="images/product'+animal+'.png" width="100" height="100" id="item"></div></div>'
    }
    tableBody.innerHTML = dataHtml
    for(var i = 0; i < count; i++)
    {
        var randomGeneratorX = getRandomInt(80);
        var randomGeneratorY = getRandomInt(80);
        document.getElementById('reward_'+i+'').style.left = ""+randomGeneratorX+"%";
        document.getElementById('reward_'+i+'').style.top = ""+randomGeneratorY+"%";
    }
    $("#minigame").show();
}

function pickReward(i, animal, pos) {
    document.getElementById('reward_'+i+'').remove();
    $.post('http://mdg_ranch_system/pickReward', JSON.stringify({animal:animal, pos:pos}));
}
function getRandomInt(max) {
    return Math.floor(Math.random() * max);
  }
function openMenuRanch(money, prepayed, prepayedDate) {
    const tableBody = document.getElementById('ranchData');
    let dataHtml = '';
    dataHtml += '<div class="button" id="myAnimals" onclick="onClickMyAnimals()">'+languageRanch[57]+'</div>'
    dataHtml += '<div class="button" id="animalsBuy" onclick="onClickAnimalsStore()">'+languageRanch[58]+'</div>'
    dataHtml += '<div class="button" id="through" onclick="onClickThrought()">'+languageRanch[59]+'</div>'
    if (storageEnable) {
        dataHtml += '<div class="button" id="storage" onclick="onClickStorage()">'+languageRanch[75]+'</div>'
    }
    if (owner) {
        dataHtml += '<div class="button" id="access" onclick="onClickAccess()">'+languageRanch[60]+'</div>'
        dataHtml += '<div class="button" id="money" onclick="manipulateMoney()" >'+languageRanch[61]+''+money+' $</div>'
        const jsTime = new Date(prepayedDate);
        jsTime.setDate(jsTime.getDate() + 7);
        const day = jsTime.getDate();
        const month = jsTime.getMonth() + 1;
        const year = jsTime.getFullYear();
        const formattedDate = `${day}.${month}.${year}`;
        if (isRentTime) {
            dataHtml += '<div class="buttonPayment" id="payment" onclick="prepay()">'+languageRanch[62]+''+prepayed+' $</br>'+languageRanch[63]+''+formattedDate+'</div>'
        }
        dataHtml += '<div class="button" id="sell" onclick="onSell()">'+languageRanch[43]+'</div>'
    }
    tableBody.innerHTML = dataHtml
    $("#ranchManage").show();
    fixToDiv()
}

function onClickStorage() {
    $("#ranchManage").hide();
    $.post('http://mdg_ranch_system/storage');
}
function onSell() {
    $("#ranchManage").hide();
    $.post('http://mdg_ranch_system/sell');
}
function manipulateMoney() {
    $.post('http://mdg_ranch_system/money');
}
function prepay() {
    $.post('http://mdg_ranch_system/prepay');
}

function getItems(arg) {
    $.post('http://mdg_ranch_system/getItems', JSON.stringify({arg:arg}));
}

function onClickAccess() {
    if (document.getElementById("access").style.height == "25px") {
        document.getElementById("access").style.height = "225px"; 
        document.getElementById("access").style.overflowY = "scroll"; 
        document.getElementById("access").style.display = "grid"; 
        document.getElementById("access").style.gridTemplateColumns = "repeat(1, 315px)"; 
        document.getElementById("access").style.gridTemplateRows = "repeat(auto, 55px)"; 


        const tableBody = document.getElementById('access');
        let dataHtml = '';
        dataHtml += '<div class="button" onClick="giveKey()" onmouseover="mouseOver()" onmouseout="mouseOut()">'+languageRanch[64]+'</div>'
        for (var a in shared) {
            dataHtml += '<div class="button" onClick="takeKey(\''+shared[a].charid+'\', \''+shared[a].steamid+'\')" onmouseover="mouseOver()" onmouseout="mouseOut()">'+shared[a].firstname+' '+shared[a].lastname+'</div>'
        }
        tableBody.innerHTML = dataHtml
    } else {
        if (overMeCheck == false) {
            document.getElementById("access").style.display = "block"; 
            document.getElementById("access").style.height = "25px"; 
            document.getElementById("access").style.overflowY = "hidden"; 
            document.getElementById("access").innerHTML = ""+languageRanch[60]+""; 
            $("#ranchAnimals").hide();
        }
    }
}

function giveKey(arg) {
    $.post('http://mdg_ranch_system/giveKey', JSON.stringify({arg:arg})); 
}

function takeKey(charid, steamid) {
    $.post('http://mdg_ranch_system/takeKey', JSON.stringify({charid:charid, steamid:steamid}));
}


function onClickThrought() {
    if (document.getElementById("through").style.height == "25px") {
        document.getElementById("through").style.height = "225px"; 
        document.getElementById("through").style.overflowY = "scroll"; 
        document.getElementById("through").style.display = "grid"; 
        document.getElementById("through").style.gridTemplateColumns = "repeat(3, 110px)"; 
        document.getElementById("through").style.gridTemplateRows = "repeat(auto, 110px)"; 

        const tableBody = document.getElementById('through');
        let dataHtml = '';

        for (var a in data) {
            if (a == "trough") {
                const newTable = {};
                const troughData = JSON.parse(data[a]);
                for (var b in troughData) {
                    newTable[troughData[b].id] = true;
                    dataHtml += '<div class="buttonMyAnimals" onmouseover="mouseOver()" onmouseout="mouseOut()">'+languageRanch[65]+'</br><img id="myAnimalIcon" src="images/'+troughData[b].id+'IconTrough.png"width="70" height="70"></div>'
                }
                for (var b in allAnimals) {
                    if (newTable[allAnimals[b]] !== true) {
                        dataHtml += '<div class="buttonMyAnimals" onClick="buyTrough(\''+b+'\')" onmouseover="mouseOver()" onmouseout="mouseOut()">'+allSetup[b].troughPrice+'$</br><img id="myAnimalIcon" src="images/'+b+'IconTrough.png"width="70" height="70"></div>'
                    }
                }
            }
        }
        tableBody.innerHTML = dataHtml
    } else {
        if (overMeCheck == false) {
            document.getElementById("through").style.display = "block"; 
            document.getElementById("through").style.height = "25px"; 
            document.getElementById("through").style.overflowY = "hidden"; 
            document.getElementById("through").innerHTML = ""+languageRanch[66]+""; 
            $("#ranchAnimals").hide();
        }
    }
}

function buyTrough(arg) {
    $.post('http://mdg_ranch_system/buyTrough', JSON.stringify({arg:arg}));
}
function onClickAnimalsStore() {
    if (document.getElementById("animalsBuy").style.height == "25px") {
        document.getElementById("animalsBuy").style.height = "225px"; 
        document.getElementById("animalsBuy").style.display = "grid"; 
        document.getElementById("animalsBuy").style.overflowY = "scroll"; 
        document.getElementById("animalsBuy").style.gridTemplateColumns = "repeat(3, 110px)"; 
        document.getElementById("animalsBuy").style.gridTemplateRows = "repeat(auto, 110px)"; 
        const tableBody = document.getElementById('animalsBuy');
        let dataHtml = '';
        var countAnimals = []
        for (var a in allAnimals) {
            countAnimals[allAnimals[a]] = 0;
            for (var b in data) {
                if (allAnimals[a] == b) {
                    const animalData = JSON.parse(data[b]);
                    for (var c in animalData) {
                        if (c !== 'age') {
                            countAnimals[allAnimals[a]] += 1;
                        }
                    }
                }
            }
        }
        for (var a in countAnimals) {
            if ((maxBuy[a]-countAnimals[a]) <= 0) {
                dataHtml += '<div class="buttonMyAnimals" onmouseover="mouseOver()" onmouseout="mouseOut()">'+languageRanch[67]+'</br><img id="myAnimalIcon" src="images/'+a+'Icon.png"width="70" height="70"></div>'
            } else {
                dataHtml += '<div class="buttonMyAnimals" onClick="buyAnimals(\''+a+'\')" onmouseover="mouseOver()" onmouseout="mouseOut()">'+allSetup[a].buyPrice+'$ | '+(maxBuy[a]-countAnimals[a])+'</br><img id="myAnimalIcon" src="images/'+a+'Icon.png"width="70" height="70"></div>'
            }
        }
        tableBody.innerHTML = dataHtml
    } else {
        if (overMeCheck == false) {
            document.getElementById("animalsBuy").style.display = "block"; 
            document.getElementById("animalsBuy").style.height = "25px"; 
            document.getElementById("animalsBuy").style.overflowY = "hidden"; 
            document.getElementById("animalsBuy").innerHTML = ""+languageRanch[58]+""; 
            $("#ranchAnimals").hide();
        }
    }
}

function buyAnimals(arg) {
    $.post('http://mdg_ranch_system/buyAnimals', JSON.stringify({arg:arg}));
}

function onClickMyAnimals() {
    if (document.getElementById("myAnimals").style.height == "25px") {
        document.getElementById("myAnimals").style.height = "325px"; 
        document.getElementById("myAnimals").style.overflowY = "scroll"; 
        document.getElementById("myAnimals").style.display = "grid"; 
        document.getElementById("myAnimals").style.gridTemplateColumns = "repeat(3, 110px)"; 
        document.getElementById("myAnimals").style.gridTemplateRows = "repeat(auto, 110px)"; 

        const tableBody = document.getElementById('myAnimals');
        let dataHtml = '';

        var countAnimals = []
        for (var a in allAnimals) {
            countAnimals[allAnimals[a]] = 0;
            for (var b in data) {
                if (allAnimals[a] == b) {
                    const animalData = JSON.parse(data[b]);
                    for (var c in animalData) {
                        if (c !== 'age') {
                            countAnimals[allAnimals[a]] += 1;
                        }
                    }
                }
            }
        }
        dataHtml += '<div class="buttonMyAnimals2" onmouseover="mouseOver()" onmouseout="mouseOut()">'+languageRanch[68]+'</br><input type="range" min="1" max="5" value="0" class="slider" id="range"></input></div>'
        for (var a in countAnimals) {
            dataHtml += '<div class="buttonMyAnimals" onClick="openAnimals(\''+a+'\')" onmouseover="mouseOver()" onmouseout="mouseOut()">'+countAnimals[a]+'</br><img id="myAnimalIcon" src="images/'+a+'Icon.png"width="70" height="70"></div>'
        }
        tableBody.innerHTML = dataHtml
        setTimeout(() => {
            document.getElementById("range").oninput = function() {rangeLead(this.value)}
        }, 50);
    } else {
        if (overMeCheck == false) {
            document.getElementById("myAnimals").style.display = "block"; 
            document.getElementById("myAnimals").style.height = "25px"; 
            document.getElementById("myAnimals").style.overflowY = "hidden"; 
            document.getElementById("myAnimals").innerHTML = ""+languageRanch[57]+""; 
            $("#ranchAnimals").hide();
        }
    }
}

function rangeLead(value) {
    $.post('http://mdg_ranch_system/range', JSON.stringify({value:value}));
}

function openAnimals(arg) {
    const tableBody = document.getElementById('ranchAnimals');
    let dataHtml = '';
    dataHtml += '<div class="buttonPayment" onclick="leadAnimal(\''+arg+'\')">'+languageRanch[69]+'</div>'
    for (var a in allAnimals) {
        for (var b in data) {
            if (allAnimals[a] == b && allAnimals[a] == arg) {
                const animalData = JSON.parse(data[b]);
                for (var c in animalData) {
                    if (animalData[c].breedtime == 0) {
                        var result = allSetup[b].manualSellPrice * calculateProductFromExp(animalData[c].exp);
                        var roundedResult = parseFloat(result.toFixed(2));
                        if (animalData[c].age == languageRanch[3]) {
                            dataHtml += '<div class="buttonSmall" onclick="sellAnimal(\''+arg+'\', \''+(Number(c)+1)+'\', \''+''+allSetup[b].manualSellPrice*calculateProductFromExp(animalData[c].exp)+''+'\')">'+animalData[c].gender+'</br>'+languageRanch[45]+'</br>'+languageRanch[51]+''+Math.round(animalData[c].hunger*10)/10+'</br>'+languageRanch[52]+''+Math.round(animalData[c].thirst*10)/10+'</br>'+languageRanch[48]+''+Math.round(animalData[c].exp*10)/10+'</br>'+languageRanch[70]+''+roundedResult+'$</div>'
                        } else {
                            dataHtml += '<div class="buttonSmall" onclick="sellAnimal(\''+arg+'\', \''+(Number(c)+1)+'\', \''+''+allSetup[b].manualSellPrice*calculateProductFromExp(animalData[c].exp)+''+'\')">'+animalData[c].gender+'</br>'+languageRanch[46]+''+Math.round(animalData[c].age*10)/10+'</br>'+languageRanch[51]+''+Math.round(animalData[c].hunger*10)/10+'</br>'+languageRanch[52]+''+Math.round(animalData[c].thirst*10)/10+'</br>'+languageRanch[48]+''+Math.round(animalData[c].exp*10)/10+'</br>'+languageRanch[70]+''+roundedResult+'$</div>'
                        }
                    } else {
                        var result = allSetup[b].manualSellPrice * calculateProductFromExp(animalData[c].exp);
                        var roundedResult = parseFloat(result.toFixed(2));
                        if (animalData[c].age == languageRanch[3]) {
                            dataHtml += '<div class="buttonSmall">'+animalData[c].gender+'</br>'+languageRanch[45]+'</br>'+languageRanch[51]+''+Math.round(animalData[c].hunger*10)/10+'</br>'+languageRanch[52]+''+Math.round(animalData[c].thirst*10)/10+'</br>'+languageRanch[48]+''+Math.round(animalData[c].exp*10)/10+'</br>'+languageRanch[70]+''+roundedResult+'$</div>'
                        } else {
                            dataHtml += '<div class="buttonSmall">'+animalData[c].gender+'</br>'+languageRanch[46]+''+Math.round(animalData[c].age*10)/10+'</br>'+languageRanch[51]+''+Math.round(animalData[c].hunger*10)/10+'</br>'+languageRanch[52]+''+Math.round(animalData[c].thirst*10)/10+'</br>'+languageRanch[48]+''+Math.round(animalData[c].exp*10)/10+'</br>'+languageRanch[70]+''+roundedResult+'$</div>'
                        }
                    }

                }
            }
        }
    }
    tableBody.innerHTML = dataHtml

    $("#ranchAnimals").show();
}

function calculateProductFromExp(exp) {
    var counter = 0
    for (var i in expTable) {
        counter += 1
    }
    for (var i in expTable) {
        if (exp <= expTable[i][0]) {
            return expTable[i][1];
        }
    }
    return expTable[counter][1];
}
function leadAnimal(arg) {
    $.post('http://mdg_ranch_system/leadAnimal', JSON.stringify({arg:arg}));
}
function sellAnimal(arg, num, price) {
    if (blockSell !== true) {
        $.post('http://mdg_ranch_system/sellAnimal', JSON.stringify({arg:arg, num:num, price:price}));
    }
}
function fixToDiv() {
    document.getElementById("myAnimals").style.height = "25px"; 
    document.getElementById("animalsBuy").style.height = "25px"; 
    document.getElementById("through").style.height = "25px"; 
    if (owner) {
        document.getElementById("access").style.height = "25px"; 
    }
}