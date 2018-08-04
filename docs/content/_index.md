# Project Flogo

<style>
html,
body {
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
}
body {
  align-items: center;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
}
.cards {
  margin-top: 25px;
  align-items: center;
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
  margin-bottom: 50px;
}
.card {
  position: relative;
  border-radius: 1em;
  width: 230px;
  height: 150px;
  background-color: #FFF;
  -webkit-box-shadow: 0 2px 5px #777;
  -moz-box-shadow: 0 2px 5px #777;
  box-shadow: 0 2px 5px #777;
  overflow: hidden;
  margin: 10px 10px;
  -webkit-transition: all 0.2s ease-in-out;
  -moz-transition: all 0.2s ease-in-out;
  transition: all 0.2s ease-in-out;
}
.card .card-header {
  position: absolute;
  align-items: center;
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
  left: 0;
  top: 0;
  width: 100%;
  height: 45%;
}
.card .card-header .card-image {
  height: 60px;
}
.card .card-header.bg1 {
  background-color: #FDD632;
}
.card .card-header.bg2 {
  background-color: #7F16A3;
}
.card .card-header.bg3 {
  background-color: #3AB7FC;
} 
.card .card-header.bg4 {
  background-color: #1E2A66;
}
.card .card-header.bg5 {
  background-color: #D67E11;
}
.card .card-header.bg6 {
  background-color: #FEBC18;
}
.card .card-content {
  position: absolute;
  top: 45%;
  left: 0;
  width: 100%;
  height: 55%;
  padding: 0 3%;
}
.card .card-content .card-text {
  position: absolute;
  top: 15%;
  -webkit-transform: translate(0, -50%);
  -moz-transform: translate(0, -50%);
  transform: translate(0, -50%);
  color: #AAA;
  font-size: .85em;
}
.card .card-content .card-start {
  position: absolute;
  right: 10%;
  bottom: 5%;
  text-decoration: none;
  font-size: .9em;
  color: #1EAAC2;
  font-weight: bold;
}
.card .card-content .card-start:hover {
  color: #8ED4E0;
}
.card:hover {
  -webkit-box-shadow: 0 5px 6px #777;
  -moz-box-shadow: 0 5px 6px #777;
  box-shadow: 0 5px 6px #777;
  -webkit-transform: translate(0, -2%);
  -moz-transform: translate(0, -2%);
  transform: translate(0, -2%);
}
</style>



<center>Docs and Tutorials for an Ultralight Edge Microservices Framework</center>

<img src="./images/Flynn1.png" width="250" height="174"/>

<div class="line center">
    <p>Get started...<p/>
    <div class="cards">
        <div class="card">
            <div class="card-header bg1">
                <img class="card-image" src="./images/get-started/005-gamepad.svg" alt="Share" />
            </div>
            <div class="card-content">
                <p class="card-text center">I'm an App Developer!</p>
                <a class="card-start" href="#" onclick='show("appdev")' alt="Start">Go!</a>
            </div>
        </div>
        <div class="card">
            <div class="card-header bg2">
                <img class="card-image" src="./images/get-started/004-coding-1.svg" alt="Share" />
            </div>
            <div class="card-content">
                <p class="card-text">I'm a Go Developer!</p>
                <a class="card-start" href="#" onclick='show("godev")' alt="Start">Go!</a>
            </div>
        </div>
        <div class="card">
            <div class="card-header bg3">
                <img class="card-image" src="./images/get-started/001-support.svg" alt="Share" />
            </div>
            <div class="card-content">
                <p class="card-text">I need help!</p>
                <a class="card-start" href="#" onclick='show("talk")' alt="Start">Go!</a>
            </div>
        </div>
    </div>
</div>

<div class="line hidden" id="app">
    <p class="center">As an App Developer you might want to try...</p>
    <div class="cards">
        <div class="card">
            <div class="card-header bg4">
                <img class="card-image" src="./images/get-started/006-idea.svg" alt="Share" />
            </div>
            <div class="card-content">
                <p class="card-text center">Our quickstart</p>
                <a class="card-start" href="./getting-started/quickstart/" alt="Start">Start!</a>
            </div>
        </div>
        <div class="card">
            <div class="card-header bg4">
                <img class="card-image" src="./images/get-started/008-monitor.svg" alt="Share" />
            </div>
            <div class="card-content">
                <p class="card-text">Getting started with the Web UI</p>
                <a class="card-start" href="./getting-started/getting-started-webui/" alt="Start">Start!</a>
            </div>
        </div>
        <div class="card">
            <div class="card-header bg5">
                <img class="card-image" src="./images/get-started/009-list.svg" alt="Share" />
            </div>
            <div class="card-content">
                <p class="card-text">Check out some labs</p>
                <a class="card-start" href="./labs/" alt="Start">Start!</a>
            </div>
        </div>
    </div>
</div>

<div class="line hidden" id="golang">
    <p class="center">As an Go Developer you might want to try...</p>
    <div class="cards">
        <div class="card">
            <div class="card-header bg4">
                <img class="card-image" src="./images/get-started/010-gears.svg" alt="Share" />
            </div>
            <div class="card-content">
                <p class="card-text center">Building your first activity</p>
                <a class="card-start" href="./development/extensions/building-your-first-activity/" alt="Start">Start!</a>
            </div>
        </div>
        <div class="card">
            <div class="card-header bg4">
                <img class="card-image" src="./images/get-started/012-diagram.svg" alt="Share" />
            </div>
            <div class="card-content">
                <p class="card-text">Mapping some fields</p>
                <a class="card-start" href="./development/flows/mapping/" alt="Start">Start!</a>
            </div>
        </div>
        <div class="card">
            <div class="card-header bg6">
                <img class="card-image" src="./images/get-started/011-networking.svg" alt="Share" />
            </div>
            <div class="card-content">
                <p class="card-text">Deploy a Flogo app to AWS Lambda</p>
                <a class="card-start" href="./faas/how-to/" alt="Start">Start!</a>
            </div>
        </div>
    </div>
</div>

<div class="line hidden" id="docs">
</div>

<div class="line hidden" id="talk">    
    <p class="center">If you have any questions, feel free to <a href="https://github.com/TIBCOSoftware/flogo/issues/new" target="_blank">post an issue</a> and tag it as a question, email <i>flogo-oss at tibco dot com</i> or chat with the team and community in:</p>
    <div class="cards">
        <div class="card">
            <div class="card-header bg3">
                <img class="card-image" src="./images/get-started/001-support.svg" alt="Share" />
            </div>
            <div class="card-content">
                <p class="card-text">Come join our Gitter channel to talk all things Flogo!</p>
                <a class="card-start" href="https://gitter.im/project-flogo/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link" target="_blank" alt="Start">Join!</a>
            </div>
        </div>
        <div class="card">
            <div class="card-header bg3">
                <img class="card-image" src="./images/get-started/001-support.svg" alt="Share" />
            </div>
            <div class="card-content">
                <p class="card-text">Join this Gitter channel for developer questions!</p>
                <a class="card-start" href="https://gitter.im/project-flogo/developers?utm_source=share-link&utm_medium=link&utm_campaign=share-link" target="_blank" alt="Start">Join!</a>
            </div>
        </div>
    </div>
</div>

<script>
    function show(arg) {
        if (arg == "appdev") {
            showAppDev(true)
            showGoDev(false)
            showDocs(false)
            showTalk(false)
        }
        else if (arg == "godev") {
            showAppDev(false)
            showGoDev(true)
            showDocs(false)
            showTalk(false)
        }
        else if (arg == "docs") {
            showAppDev(false)
            showGoDev(false)
            showDocs(true)
            showTalk(false)
        }
        else if (arg == "talk") {
            showAppDev(false)
            showGoDev(false)
            showDocs(false)
            showTalk(true)
        }
    }

    function showAppDev(shouldShow) {
        if (shouldShow) {
            document.getElementById("app").classList.remove("hidden")
            document.getElementById("app").classList.add("block")
        } else {
            document.getElementById("app").classList.add("hidden")
            document.getElementById("app").classList.remove("block")
        }
    }

    function showGoDev(shouldShow) {
        if (shouldShow) {
            document.getElementById("golang").classList.remove("hidden")
            document.getElementById("golang").classList.add("block")
        } else {
            document.getElementById("golang").classList.add("hidden")
            document.getElementById("golang").classList.remove("block")
        }
    }

    function showDocs(shouldShow) {
        if (shouldShow) {
            document.getElementById("docs").classList.remove("hidden")
            document.getElementById("docs").classList.add("block")
        } else {
            document.getElementById("docs").classList.add("hidden")
            document.getElementById("docs").classList.remove("block")
        }
    }

    function showTalk(shouldShow) {
        if (shouldShow) {
            document.getElementById("talk").classList.remove("hidden")
            document.getElementById("talk").classList.add("block")
        } else {
            document.getElementById("talk").classList.add("hidden")
            document.getElementById("talk").classList.remove("block")
        }
    }
</script>