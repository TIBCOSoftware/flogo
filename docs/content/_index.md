# Project Flogo

<center>Docs and Tutorials for an Open Source ecosystem for event-driven apps</center>

<img src="./images/Flynn1.png" width="250" height="174"/>

<div class="line center">
    <p>Get started...<p/>
    <div class="cards">

        {{< smallcard img="./images/get-started/005-gamepad.svg" headercolor="bg1" text="I'm an App Developer!" href="#" show="app" >}}
        {{< smallcard img="./images/get-started/004-coding-1.svg" headercolor="bg4" text="I'm a Go Developer!" href="#" show="golang" >}}
        {{< smallcard img="./images/get-started/001-support.svg" headercolor="bg5" text="I need help!" href="#" show="talk" >}}

    </div>
</div>

<div class="line hidden" id="app">
    <p class="center">As an App Developer you might want to try...</p>
    <div class="cards">

        {{< smallcard img="./images/get-started/006-idea.svg" headercolor="bg6" text="Our quickstart" href="./getting-started/quickstart/">}}
        {{< smallcard img="./images/get-started/008-monitor.svg" headercolor="bg6" text="Getting started with the Web UI" href="./getting-started/getting-started-webui/">}}
        {{< smallcard img="./images/get-started/009-list.svg" headercolor="bg7" text="Check out some labs" href="./labs">}}

    </div>
</div>

<div class="line hidden" id="golang">
    <p class="center">As an Go Developer you might want to try...</p>
    <div class="cards">

        {{< smallcard img="./images/get-started/010-gears.svg" headercolor="bg6" text="Building your first activity" href="./labs/building-activities/">}}
        {{< smallcard img="./images/get-started/012-diagram.svg" headercolor="bg6" text="Mapping some fields" href="./development/flows/mapping/">}}
        {{< smallcard img="./images/get-started/011-networking.svg" headercolor="bg8" text="Deploy a Flogo app to AWS Lambda" href="./faas/how-to/">}}

    </div>
</div>

<div class="line hidden" id="docs">
</div>

<div class="line hidden" id="talk">    
    <p class="center">If you have any questions, feel free to <a href="https://github.com/TIBCOSoftware/flogo/issues/new" target="_blank">post an issue</a> and tag it as a question, email <i>flogo-oss at tibco dot com</i> or chat with the team and community in:</p>
    <div class="cards">

        {{< smallcard img="./images/get-started/001-support.svg" headercolor="bg5" text="Come join our Gitter channel to talk all things Flogo!" href="https://gitter.im/project-flogo/Lobby">}}
        {{< smallcard img="./images/get-started/001-support.svg" headercolor="bg5" text="Join this Gitter channel for developer questions!" href="https://gitter.im/project-flogo/developers">}}

    </div>
</div>

<script>
    function show(arg) {
        document.getElementById("app").classList = "line hidden"
        document.getElementById("golang").classList = "line hidden"
        document.getElementById("docs").classList = "line hidden"
        document.getElementById("talk").classList = "line hidden"
        document.getElementById(arg).classList.remove("hidden")
        document.getElementById(arg).classList.add("block")
    }
</script>
