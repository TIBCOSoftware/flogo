---
title: Labs
weight: 2500
chapter: true
pre: "<i class=\"fa fa-flask\" aria-hidden=\"true\"></i> "
---

# Labs

After getting up and running you might want to try your hand at some more advanced labs and tutorials. These labs provide you with a guides, tutorials and code samples and will help you work through building and deploying Flogo apps. The labs cover a wide range of topics like deploying to Kubernetes, using Flogo with the Serverless Framework and a bunch more!

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
  height: 290px;
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
  height: 100px;
}
.card .card-header.bg1 {
  background-color: #FDD632;
}
.card .card-header.bg2 {
  background-color: #ED0045;
}
.card .card-header.bg3 {
  background-color: #0438A1;
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

<div class="cards">

  <div class="card">
    <div class="card-header bg1">
      <img class="card-image" src="../images/labs/009-scientific.svg" alt="Share" />
    </div>
    <div class="card-content">
      <p class="card-text">Deploy a Flogo app to a Kubernetes cluster</p>
      <a class="card-start" href="./kubernetes-demo" alt="Start">Start!</a>
    </div>
  </div>

  <div class="card">
    <div class="card-header bg2">
      <img class="card-image" src="../images/labs/034-experiment.svg" alt="Share" />
    </div>
    <div class="card-content">
      <p class="card-text">Deploy a Flogo app using the Serverless Framework</p>
      <a class="card-start" href="./serverless" alt="Start">Start!</a>
    </div>
  </div>

