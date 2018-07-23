# Project Flogo

<center>Docs and Tutorials for an Ultralight Edge Microservices Framework</center>

<img src="./images/Flynn1.png" width="250" height="174"/>

<div class="line center">
    <p>Get started...<p/>
    {{% button href="#" onclick="appdev" icon="fa fa-desktop" %}}As an App Developer{{% /button %}}
    {{% button href="#" onclick="godev" icon="fa fa-code" %}}As a Go Developer{{% /button %}}
    {{% button href="#" onclick="talk" icon="fa fa-comments" %}}By talking to us{{% /button %}}
</div>

<div class="line hidden" id="app">
    <p>You might want to try...</p>
    <ul>
        <li>{{% button href="./getting-started/quickstart/" icon="fa fa-bolt" %}}Quickstart{{% /button %}}</li>
        <li>{{% button href="./getting-started/getting-started-webui/" icon="fa fa-desktop" %}}Getting started with the Web UI{{% /button %}}</li>
        <li>{{% button href="./labs/" icon="fa fa-flask" %}}Check out some labs{{% /button %}}</li>
    </ul>
</div>

<div class="line hidden" id="golang">
    <p>You might want to try...</p>
    <ul>
        <li>{{% button href="./development/extensions/building-your-first-activity/" icon="fa fa-cogs" %}}Build an activity{{% /button %}}</li>
        <li>{{% button href="./development/flows/mapping/" icon="fa fa-map" %}}Map some fields{{% /button %}}</li>
        <li>{{% button href="./faas/how-to/" icon="fa fa-cloud" %}}Deploy to AWS Lambda{{% /button %}}</li>
    </ul>
</div>
    
<div class="line hidden" id="docs">
</div>
    
<div class="line hidden" id="talk">
    <p>If you have any questions, feel free to <a href="https://github.com/TIBCOSoftware/flogo/issues/new" target="_blank">post an issue</a> and tag it as a question, email <i>flogo-oss at tibco dot com</i> or chat with the team and community in:</p>
    <p>
        <ul>
            <li>The <b><a href="https://gitter.im/project-flogo/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link" target="_blank">project-flogo/Lobby</a></b> Gitter channel should be used for general discussions, start here for all things Flogo!</li>
            <li>The <b><a href="https://gitter.im/project-flogo/developers?utm_source=share-link&utm_medium=link&utm_campaign=share-link" target="_blank">project-flogo/developers</a></b> Gitter channel should be used for developer/contributor focused conversations.</li>
        </ul>
    </p>
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